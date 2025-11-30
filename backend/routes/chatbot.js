const express = require('express');
const router = express.Router();
const db = require('../config/database');

const OPENROUTER_API_URL = 'https://openrouter.ai/api/v1/chat/completions';

// Cache thông tin nhà hàng
let restaurantCache = { data: '', lastUpdate: 0 };

// Lấy đầy đủ thông tin từ database
async function getRestaurantInfo() {
    const now = Date.now();
    if (restaurantCache.data && (now - restaurantCache.lastUpdate) < 300000) {
        return restaurantCache.data;
    }
    
    try {
        // Lấy tất cả danh mục
        const [categories] = await db.query(`SELECT * FROM danh_muc WHERE trang_thai = 1 ORDER BY ma_danh_muc`);
        
        // Lấy tất cả món ăn
        const [dishes] = await db.query(`
            SELECT m.ten_mon, m.mo_ta_chi_tiet, m.gia_tien, m.don_vi_tinh, d.ten_danh_muc, d.ma_danh_muc
            FROM mon_an m 
            LEFT JOIN danh_muc d ON m.ma_danh_muc = d.ma_danh_muc 
            WHERE m.trang_thai = 1
            ORDER BY d.ma_danh_muc, m.ten_mon
        `);
        
        // Tạo thông tin menu theo danh mục
        let menuInfo = '\n\n=== THỰC ĐƠN ĐẦY ĐỦ ===\n';
        
        categories.forEach(cat => {
            const catDishes = dishes.filter(d => d.ma_danh_muc === cat.ma_danh_muc);
            if (catDishes.length > 0) {
                menuInfo += `\n📌 ${cat.ten_danh_muc.toUpperCase()}:\n`;
                catDishes.forEach(dish => {
                    const price = new Intl.NumberFormat('vi-VN').format(dish.gia_tien);
                    menuInfo += `  - ${dish.ten_mon}: ${price}đ/${dish.don_vi_tinh || 'phần'}\n`;
                });
            }
        });
        
        restaurantCache = { data: menuInfo, lastUpdate: now };
        return menuInfo;
    } catch (error) {
        console.error('Error getting restaurant info:', error.message);
        return '';
    }
}

// API chat
router.post('/chat', async (req, res) => {
    try {
        const { message } = req.body;
        
        if (!message || message.trim() === '') {
            return res.status(400).json({ success: false, message: 'Vui lòng nhập tin nhắn' });
        }

        const apiKey = process.env.OPENROUTER_API_KEY;
        if (!apiKey) {
            return res.json({ success: false, message: 'Chưa cấu hình API key' });
        }

        // Lấy thông tin nhà hàng từ database
        const menuInfo = await getRestaurantInfo();
        
        const systemPrompt = `Bạn là trợ lý ảo thông minh của Nhà hàng Ẩm thực Phương Nam - chuyên món ăn đặc sản miền Tây Nam Bộ tại Vĩnh Long, Việt Nam.

=== THÔNG TIN NHÀ HÀNG ===
- Tên: Nhà hàng Ẩm thực Phương Nam
- Địa chỉ: 123 Đường ABC, Phường 1, TP. Vĩnh Long, Việt Nam
- Hotline: 0123 456 789
- Email: info@phuongnam.vn
- Website: phuongnam.vn
- Giờ mở cửa: 10:00 - 22:00 hàng ngày (Thứ 2 - Chủ nhật)
- Dịp Tết Nguyên Đán: 09:00 - 23:00

=== DỊCH VỤ ===
- Phục vụ tại chỗ với không gian ấm cúng
- Đặt bàn trước qua website hoặc hotline
- Giao hàng tận nơi (miễn phí trong bán kính 5km)
- Đặt tiệc sinh nhật, họp mặt gia đình, sự kiện công ty
- Có bãi đỗ xe rộng rãi

=== KHUYẾN MÃI ===
- Giảm 10% cho đơn đặt bàn online
- Miễn phí giao hàng trong 5km
- Combo gia đình tiết kiệm từ 299.000đ

=== CHỨC NĂNG WEBSITE ===
- Trang chủ: Giới thiệu nhà hàng
- Thực đơn: Xem tất cả món ăn và giá
- Đặt bàn: Đặt bàn trực tuyến
- Giỏ hàng: Đặt món mang về/giao hàng
- Tin tức: Cập nhật khuyến mãi, sự kiện
- Liên hệ: Thông tin liên lạc, bản đồ
- Tài khoản: Đăng ký, đăng nhập, quản lý đơn hàng
${menuInfo}

=== QUY TẮC TRẢ LỜI ===
1. Trả lời bằng tiếng Việt, thân thiện và chuyên nghiệp
2. Câu trả lời ngắn gọn (2-4 câu), sử dụng emoji phù hợp
3. Khi khách hỏi về món ăn/đồ uống, TRẢ LỜI DỰA TRÊN THỰC ĐƠN Ở TRÊN
4. Nếu không có thông tin trong thực đơn, nói rằng "Hiện tại nhà hàng chưa có món này, bạn có thể gọi hotline 0123 456 789 để hỏi thêm"
5. Hướng dẫn đặt bàn qua website hoặc hotline khi được hỏi
6. Không trả lời câu hỏi không liên quan đến nhà hàng, ẩm thực`;

        // Gọi API
        const controller = new AbortController();
        const timeout = setTimeout(() => controller.abort(), 20000);

        const response = await fetch(OPENROUTER_API_URL, {
            method: 'POST',
            headers: {
                'Authorization': `Bearer ${apiKey}`,
                'Content-Type': 'application/json',
                'HTTP-Referer': 'http://localhost:3000',
                'X-Title': 'Phuong Nam Restaurant Chatbot'
            },
            body: JSON.stringify({
                model: 'x-ai/grok-4.1-fast:free',
                messages: [
                    { role: 'system', content: systemPrompt },
                    { role: 'user', content: message }
                ],
                max_tokens: 300,
                temperature: 0.7
            }),
            signal: controller.signal
        });

        clearTimeout(timeout);
        const data = await response.json();
        
        if (data.choices?.[0]?.message?.content) {
            return res.json({
                success: true,
                data: { response: data.choices[0].message.content, source: 'ai' }
            });
        }

        console.error('OpenRouter error:', data);
        return res.json({
            success: false,
            message: data.error?.message || 'Lỗi từ AI service'
        });

    } catch (error) {
        console.error('Chatbot error:', error.message);
        return res.json({
            success: false,
            message: 'Không thể kết nối đến AI. Vui lòng thử lại!'
        });
    }
});

module.exports = router;
