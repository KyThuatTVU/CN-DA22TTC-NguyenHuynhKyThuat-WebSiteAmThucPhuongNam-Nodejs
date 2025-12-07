const express = require('express');
const router = express.Router();
const jwt = require('jsonwebtoken');
const db = require('../config/database');
const OpenAI = require('openai');

const JWT_SECRET = process.env.JWT_SECRET || 'your-secret-key-change-this';

// Khởi tạo Groq AI client
const groq = new OpenAI({
    apiKey: process.env.GROQ_API_KEY,
    baseURL: 'https://api.groq.com/openai/v1'
});

console.log('🤖 Chatbot using: Groq (Free)');
console.log('🔑 Groq API Key:', process.env.GROQ_API_KEY ? '✅ Configured (***' + process.env.GROQ_API_KEY.slice(-8) + ')' : '❌ NOT SET');

// Cache thông tin nhà hàng
let restaurantCache = { data: '', lastUpdate: 0 };
let settingsCache = { data: null, lastUpdate: 0 };

// API test - kiểm tra dữ liệu chatbot đọc được
router.get('/test-data', async (req, res) => {
    try {
        // Test settings
        const [settings] = await db.query('SELECT * FROM cai_dat');
        const settingsObj = {};
        settings.forEach(item => {
            settingsObj[item.setting_key] = item.setting_value;
        });
        
        // Test menu
        const [categories] = await db.query('SELECT * FROM danh_muc WHERE trang_thai = 1');
        const [dishes] = await db.query('SELECT ma_mon, ten_mon, gia_tien, ma_danh_muc FROM mon_an WHERE trang_thai = 1 LIMIT 10');
        
        res.json({
            success: true,
            data: {
                groq_api_key: process.env.GROQ_API_KEY ? '✅ Configured' : '❌ NOT SET',
                settings_count: settings.length,
                settings: settingsObj,
                categories_count: categories.length,
                categories: categories.map(c => c.ten_danh_muc),
                dishes_count: dishes.length,
                dishes_sample: dishes.slice(0, 5).map(d => ({ ten: d.ten_mon, gia: d.gia_tien }))
            }
        });
    } catch (error) {
        res.json({
            success: false,
            error: error.message
        });
    }
});

// Hàm lấy thông tin user từ token (nếu có)
function getUserFromToken(req) {
    try {
        const authHeader = req.headers['authorization'];
        const token = authHeader && authHeader.split(' ')[1];
        if (token) {
            const decoded = jwt.verify(token, JWT_SECRET);
            return decoded.ma_nguoi_dung;
        }
    } catch (error) {
        // Token không hợp lệ hoặc hết hạn
    }
    return null;
}

// Hàm lưu tin nhắn vào lịch sử
async function saveChatHistory(ma_nguoi_dung, session_id, nguoi_gui, noi_dung) {
    try {
        await db.query(
            `INSERT INTO lich_su_chatbot (ma_nguoi_dung, session_id, nguoi_gui, noi_dung) VALUES (?, ?, ?, ?)`,
            [ma_nguoi_dung, session_id, nguoi_gui, noi_dung]
        );
    } catch (error) {
        console.error('Error saving chat history:', error.message);
    }
}

// Lấy thống kê kinh doanh từ database
async function getBusinessStats() {
    try {
        const currentDate = new Date();
        const currentMonth = currentDate.getMonth() + 1;
        const currentYear = currentDate.getFullYear();
        
        // Doanh thu tháng này
        const [revenueThisMonth] = await db.query(`
            SELECT COALESCE(SUM(tong_tien), 0) as total FROM don_hang 
            WHERE MONTH(thoi_gian_tao) = ? AND YEAR(thoi_gian_tao) = ? AND trang_thai = 'delivered'
        `, [currentMonth, currentYear]);

        // Số đơn hàng tháng này
        const [ordersThisMonth] = await db.query(`
            SELECT COUNT(*) as total FROM don_hang 
            WHERE MONTH(thoi_gian_tao) = ? AND YEAR(thoi_gian_tao) = ?
        `, [currentMonth, currentYear]);

        // Khách hàng mới tháng này
        const [customersThisMonth] = await db.query(`
            SELECT COUNT(*) as total FROM nguoi_dung 
            WHERE MONTH(ngay_tao) = ? AND YEAR(ngay_tao) = ?
        `, [currentMonth, currentYear]);

        // Đặt bàn tháng này
        const [reservationsThisMonth] = await db.query(`
            SELECT COUNT(*) as total FROM dat_ban 
            WHERE MONTH(ngay_dat) = ? AND YEAR(ngay_dat) = ?
        `, [currentMonth, currentYear]);

        // Top 5 món bán chạy
        const [topProducts] = await db.query(`
            SELECT m.ten_mon, SUM(ct.so_luong) as so_luong_ban
            FROM chi_tiet_don_hang ct
            JOIN mon_an m ON ct.ma_mon = m.ma_mon
            JOIN don_hang dh ON ct.ma_don_hang = dh.ma_don_hang
            WHERE dh.trang_thai = 'delivered'
            GROUP BY m.ma_mon, m.ten_mon
            ORDER BY so_luong_ban DESC
            LIMIT 5
        `);

        // Đánh giá trung bình
        const [avgRating] = await db.query(`
            SELECT AVG(so_sao) as avg_rating, COUNT(*) as total_reviews 
            FROM danh_gia_san_pham WHERE trang_thai = 'approved'
        `);

        // Tổng số món ăn
        const [totalDishes] = await db.query(`SELECT COUNT(*) as total FROM mon_an WHERE trang_thai = 1`);
        
        // Tổng số danh mục
        const [totalCategories] = await db.query(`SELECT COUNT(*) as total FROM danh_muc WHERE trang_thai = 1`);

        return {
            currentMonth,
            currentYear,
            revenue: revenueThisMonth[0]?.total || 0,
            orders: ordersThisMonth[0]?.total || 0,
            newCustomers: customersThisMonth[0]?.total || 0,
            reservations: reservationsThisMonth[0]?.total || 0,
            topProducts: topProducts || [],
            avgRating: avgRating[0]?.avg_rating || 0,
            totalReviews: avgRating[0]?.total_reviews || 0,
            totalDishes: totalDishes[0]?.total || 0,
            totalCategories: totalCategories[0]?.total || 0
        };
    } catch (error) {
        console.error('Error getting business stats:', error.message);
        return null;
    }
}

// Lấy cài đặt nhà hàng từ database (cache 30 giây)
async function getRestaurantSettings() {
    const now = Date.now();
    if (settingsCache.data && (now - settingsCache.lastUpdate) < 30000) {
        console.log('📋 Using cached settings');
        return settingsCache.data;
    }
    
    try {
        console.log('📋 Loading settings from database...');
        const [settings] = await db.query('SELECT * FROM cai_dat');
        const settingsObj = {};
        settings.forEach(item => {
            settingsObj[item.setting_key] = item.setting_value;
        });
        settingsCache = { data: settingsObj, lastUpdate: now };
        console.log('📋 Settings loaded:', JSON.stringify(settingsObj, null, 2));
        return settingsObj;
    } catch (error) {
        console.error('Error getting settings:', error.message);
        return {};
    }
}

// Lấy đầy đủ thông tin từ database
async function getRestaurantInfo() {
    const now = Date.now();
    if (restaurantCache.data && (now - restaurantCache.lastUpdate) < 300000) {
        console.log('🍽️ Using cached menu');
        return restaurantCache.data;
    }
    
    try {
        console.log('🍽️ Loading menu from database...');
        
        // Lấy tất cả danh mục
        const [categories] = await db.query(`SELECT * FROM danh_muc WHERE trang_thai = 1 ORDER BY ma_danh_muc`);
        console.log(`📂 Found ${categories.length} categories`);
        
        // Lấy tất cả món ăn
        const [dishes] = await db.query(`
            SELECT m.ten_mon, m.mo_ta_chi_tiet, m.gia_tien, m.don_vi_tinh, d.ten_danh_muc, d.ma_danh_muc
            FROM mon_an m 
            LEFT JOIN danh_muc d ON m.ma_danh_muc = d.ma_danh_muc 
            WHERE m.trang_thai = 1
            ORDER BY d.ma_danh_muc, m.ten_mon
        `);
        console.log(`🍜 Found ${dishes.length} dishes`);
        
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
        
        console.log('🍽️ Menu loaded successfully, length:', menuInfo.length);
        restaurantCache = { data: menuInfo, lastUpdate: now };
        return menuInfo;
    } catch (error) {
        console.error('❌ Error getting restaurant info:', error.message);
        return '';
    }
}

// API chat
router.post('/chat', async (req, res) => {
    try {
        const { message, session_id } = req.body;
        
        if (!message || message.trim() === '') {
            return res.status(400).json({ success: false, message: 'Vui lòng nhập tin nhắn' });
        }

        // Kiểm tra Groq API key
        if (!process.env.GROQ_API_KEY) {
            return res.json({ success: false, message: 'Chưa cấu hình GROQ_API_KEY trong file .env' });
        }

        // Lấy thông tin user từ token (nếu đăng nhập)
        const ma_nguoi_dung = getUserFromToken(req);
        const chatSessionId = session_id || `guest_${Date.now()}`;

        // Lưu tin nhắn của user vào lịch sử
        await saveChatHistory(ma_nguoi_dung, chatSessionId, 'user', message.trim());

        // Lấy thông tin nhà hàng từ database
        const menuInfo = await getRestaurantInfo();
        const settings = await getRestaurantSettings();
        const stats = await getBusinessStats();
        
        // Lấy thông tin từ settings hoặc dùng giá trị mặc định
        const tenNhaHang = settings.ten_nha_hang || 'Nhà hàng Ẩm thực Phương Nam';
        const diaChi = settings.dia_chi || '123 Đường ABC, Phường 1, TP. Vĩnh Long';
        const soDienThoai = settings.so_dien_thoai || '0123 456 789';
        const email = settings.email || 'info@phuongnam.vn';
        const website = settings.website || 'phuongnam.vn';
        const gioMoCuaT2T6 = settings.gio_mo_cua_t2_t6 || '08:00-22:00';
        const gioMoCuaT7CN = settings.gio_mo_cua_t7_cn || '07:00-23:00';
        const phiGiaoHang = settings.phi_giao_hang || '20000';
        const mienPhiGiaoHangTu = settings.mien_phi_giao_hang_tu || '200000';
        
        console.log('🤖 Chatbot processing message:', message);
        console.log('📋 Settings loaded:', Object.keys(settings).length > 0 ? 'YES' : 'NO (using defaults)');
        console.log('🍽️ Menu loaded:', menuInfo.length > 50 ? `YES (${menuInfo.length} chars)` : 'NO or EMPTY');
        console.log('📊 Stats loaded:', stats ? 'YES' : 'NO');
        console.log('📍 Restaurant info:', { tenNhaHang, diaChi, soDienThoai });
        
        // Tạo thông tin thống kê
        const formatMoney = (amount) => new Intl.NumberFormat('vi-VN').format(amount) + 'đ';
        let statsInfo = '';
        if (stats) {
            statsInfo = `

=== THỐNG KÊ KINH DOANH THÁNG ${stats.currentMonth}/${stats.currentYear} ===
📊 Doanh thu tháng này: ${formatMoney(stats.revenue)}
📦 Số đơn hàng: ${stats.orders} đơn
👥 Khách hàng mới: ${stats.newCustomers} người
🍽️ Lượt đặt bàn: ${stats.reservations} lượt
⭐ Đánh giá trung bình: ${parseFloat(stats.avgRating || 0).toFixed(1)}/5 (${stats.totalReviews} đánh giá)
📋 Tổng số món ăn: ${stats.totalDishes} món trong ${stats.totalCategories} danh mục

🏆 TOP MÓN BÁN CHẠY:
${stats.topProducts.length > 0 ? stats.topProducts.map((p, i) => `${i + 1}. ${p.ten_mon} (${p.so_luong_ban} phần)`).join('\n') : 'Chưa có dữ liệu'}
`;
        }
        
        const systemPrompt = `BẠN LÀ TRÀ MY - trợ lý ảo thông minh của ${tenNhaHang}.

=== DANH TÍNH CỦA BẠN ===
- Tên của bạn là: TRÀ MY
- Bạn là cô tiếp viên ảo dễ thương, ngọt ngào, am hiểu sâu sắc về nhà hàng
- Khi khách chào hoặc hỏi tên -> "Dạ em là Trà My, trợ lý ảo của ${tenNhaHang} ạ! Em rất vui được hỗ trợ anh/chị hôm nay 🌸"
- QUAN TRỌNG: "Trà My" là TÊN của bạn, KHÔNG PHẢI món ăn hay đồ uống!

=== CÁCH XƯNG HÔ & GIAO TIẾP ===
- Luôn xưng "em", gọi khách là "anh/chị" hoặc "quý khách"
- Nói chuyện dễ thương, ngọt ngào, lịch sự, nhiệt tình như tiếp viên thực sự
- Hay dùng: "dạ", "ạ", "nha", "nhé" ở cuối câu
- Emoji phù hợp: 🌸 💕 😊 🍜 ✨ 🥰 🎉 👨‍🍳

=== THÔNG TIN NHÀ HÀNG (ĐỌC KỸ) ===
📍 Tên: ${tenNhaHang}
📍 Slogan: "PHƯƠNG NAM – NGON NHƯ MẸ NẤU"
📍 Định vị: Nhà hàng cơm Việt, quán cơm gia đình ngon tại Vĩnh Long
📍 Chuyên môn: Món ăn miền Tây Nam Bộ, cơm Việt truyền thống, hương vị đậm đà quê nhà
📍 Địa chỉ: ${diaChi}
📍 Hotline: ${soDienThoai}
📍 Email: ${email}
📍 Website: ${website}
📍 Giờ mở cửa:
   - Thứ 2 đến Thứ 6: ${gioMoCuaT2T6}
   - Thứ 7 và Chủ nhật: ${gioMoCuaT7CN}

=== TRIẾT LÝ & GIÁ TRỊ CỐT LÕI ===
🎯 Triết lý: Chia sẻ hương vị và văn hóa thưởng thức cơm Việt tới tất cả mọi người
🎯 Nguyên liệu: Tươi sạch nhất, chế biến bởi đầu bếp tận tâm
🎯 Không gian: Lấy cảm hứng từ giá trị truyền thống Việt Nam kết hợp hiện đại
🎯 Thiết kế: Chủ đạo gỗ, cây xanh, ánh sáng tự nhiên - ấm cúng như nhà

4 GIÁ TRỊ CỐT LÕI:
1. CHẤT LƯỢNG: Nguyên liệu tươi ngon, đảm bảo chất lượng món ăn tốt nhất
2. TẬN TÂM: Phục vụ nhiệt tình, chu đáo, chuyên nghiệp
3. TRUYỀN THỐNG: Giữ gìn hương vị ẩm thực truyền thống miền Tây
4. SÁNG TẠO: Đổi mới thực đơn, trải nghiệm ẩm thực độc đáo

=== ĐỘI NGŨ NHÀ HÀNG (QUAN TRỌNG - ĐỌC KỸ) ===
👩‍💼 CHỦ NHÀ HÀNG: Hoàng Thục Linh
   - Kinh nghiệm: 10 năm
   - Vai trò: Người sáng lập và điều hành nhà hàng
   - Tầm nhìn: Phát triển ẩm thực miền Tây đến mọi người

👨‍🍳 BẾP TRƯỞNG: Nguyễn Nhật Trường
   - Kinh nghiệm: 20 năm
   - Vai trò: Đầu bếp chính, chịu trách nhiệm toàn bộ món ăn
   - Đặc điểm: Đầu bếp tài hoa với bí quyết gia truyền

👨‍🍳 PHÓ BẾP TRƯỞNG: Nguyễn Huỳnh Kỹ Thuật
   - Kinh nghiệm: 12 năm
   - Vai trò: Hỗ trợ bếp trưởng, đảm bảo chất lượng món ăn

👩‍💼 QUẢN LÝ: Hứa Thị Thảo Vy
   - Kinh nghiệm: 8 năm
   - Vai trò: Quản lý vận hành nhà hàng hàng ngày

=== DỊCH VỤ & TIỆN ÍCH ===
✅ Phục vụ tại chỗ: Không gian ấm cúng, trang trí phong cách truyền thống
✅ Đặt bàn trước: Qua website hoặc hotline ${soDienThoai}
✅ Giao hàng tận nơi: 
   - Phí giao hàng: ${new Intl.NumberFormat('vi-VN').format(phiGiaoHang)}đ
   - MIỄN PHÍ cho đơn từ ${new Intl.NumberFormat('vi-VN').format(mienPhiGiaoHangTu)}đ trở lên
✅ Đặt tiệc: Sinh nhật, họp mặt gia đình, sự kiện công ty
✅ Bãi đỗ xe: Có chỗ để xe ô tô rộng rãi

=== KHUYẾN MÃI HIỆN TẠI ===
🎁 Giảm 10% cho đơn đặt bàn online
🎁 Miễn phí giao hàng cho đơn từ ${new Intl.NumberFormat('vi-VN').format(mienPhiGiaoHangTu)}đ
🎁 Combo gia đình tiết kiệm từ 299.000đ
${menuInfo}

=== QUY TẮC TRẢ LỜI (BẮT BUỘC TUÂN THỦ) ===
1. ✅ Trả lời bằng tiếng Việt, dễ thương, ngọt ngào, nhiệt tình
2. ✅ Câu trả lời ngắn gọn (2-5 câu), rõ ràng, dễ hiểu
3. ✅ Luôn xưng "em" và gọi khách là "anh/chị"
4. ✅ Khi khách chào/hỏi tên → Giới thiệu mình là Trà My
5. ✅ Khi hỏi về món ăn → TRẢ LỜI CHÍNH XÁC DỰA TRÊN THỰC ĐƠN BÊN DƯỚI
6. ✅ Khi hỏi về chủ/đội ngũ → Trả lời CHÍNH XÁC theo thông tin ĐỘI NGŨ NHÀ HÀNG
7. ✅ Khi hỏi số điện thoại/hotline → Trả lời: "${soDienThoai}"
8. ✅ Khi hỏi địa chỉ → Trả lời: "${diaChi}"
9. ✅ Khi hỏi giờ mở cửa → Trả lời CHÍNH XÁC giờ mở cửa
10. ✅ Khi hỏi về giá món ăn → Đọc KỸ thực đơn và trả lời ĐÚNG GIÁ
11. ✅ Nếu không có món trong thực đơn → "Dạ hiện tại nhà hàng mình chưa có món này ạ, anh/chị có thể gọi hotline ${soDienThoai} để hỏi thêm nha 💕"
12. ✅ Câu hỏi không liên quan → Lịch sự từ chối và hướng về chủ đề nhà hàng
13. ✅ Luôn ĐỌC KỸ thông tin trước khi trả lời, KHÔNG được bịa đặt
14. ✅ Nếu không chắc chắn → Khuyên khách gọi hotline ${soDienThoai}

=== LƯU Ý ĐẶC BIỆT ===
⚠️ PHẢI ĐỌC KỸ THỰC ĐƠN trước khi trả lời về món ăn
⚠️ PHẢI TRẢ LỜI ĐÚNG GIÁ TIỀN (đọc từ thực đơn)
⚠️ PHẢI TRẢ LỜI ĐÚNG TÊN NGƯỜI trong đội ngũ
⚠️ KHÔNG ĐƯỢC bịa đặt thông tin không có trong hệ thống
⚠️ Khi khách hỏi về người cụ thể (Linh, Trường, Kỹ Thuật, Vy) → Trả lời CHÍNH XÁC theo thông tin đội ngũ
⚠️ Khi khách hỏi về tình hình kinh doanh, doanh thu, đơn hàng → Trả lời dựa trên THỐNG KÊ KINH DOANH bên dưới
${statsInfo}`;

        // Gọi Groq AI API
        const completion = await groq.chat.completions.create({
            model: 'llama-3.3-70b-versatile',
            messages: [
                { role: 'system', content: systemPrompt },
                { role: 'user', content: message }
            ],
            max_tokens: 300,
            temperature: 0.7
        });
        
        if (completion.choices?.[0]?.message?.content) {
            const botResponse = completion.choices[0].message.content;
            
            // Lưu tin nhắn của bot vào lịch sử
            await saveChatHistory(ma_nguoi_dung, chatSessionId, 'bot', botResponse);
            
            return res.json({
                success: true,
                data: { response: botResponse, source: 'groq' }
            });
        }

        return res.json({
            success: false,
            message: 'Không nhận được phản hồi từ Groq AI'
        });

    } catch (error) {
        console.error('Chatbot error:', error.message);
        
        // Xử lý lỗi cụ thể từ Groq API
        if (error.status === 401) {
            return res.json({
                success: false,
                message: 'GROQ_API_KEY không hợp lệ. Vui lòng kiểm tra lại trong file .env!'
            });
        }
        
        if (error.status === 429) {
            return res.json({
                success: false,
                message: 'Đã vượt quá giới hạn Groq API. Vui lòng thử lại sau!'
            });
        }
        
        return res.json({
            success: false,
            message: 'Không thể kết nối đến Groq AI. Vui lòng thử lại!'
        });
    }
});

// API lấy danh sách các sessions chat của user (giống ChatGPT)
router.get('/sessions', async (req, res) => {
    try {
        const ma_nguoi_dung = getUserFromToken(req);
        
        console.log('📜 Getting sessions for user:', ma_nguoi_dung);
        
        if (!ma_nguoi_dung) {
            return res.status(401).json({
                success: false,
                message: 'Vui lòng đăng nhập để xem lịch sử chat'
            });
        }

        // Lấy danh sách sessions - query đơn giản hơn
        const [sessions] = await db.query(
            `SELECT 
                session_id,
                MIN(thoi_diem_chat) as thoi_diem_chat,
                COUNT(*) as message_count
             FROM lich_su_chatbot
             WHERE ma_nguoi_dung = ? AND session_id IS NOT NULL
             GROUP BY session_id
             ORDER BY MIN(thoi_diem_chat) DESC
             LIMIT 50`,
            [ma_nguoi_dung]
        );
        
        console.log('📜 Found sessions:', sessions.length);

        // Lấy tin nhắn đầu tiên cho mỗi session
        for (let session of sessions) {
            const [firstMsg] = await db.query(
                `SELECT noi_dung FROM lich_su_chatbot 
                 WHERE session_id = ? AND nguoi_gui = 'user' 
                 ORDER BY thoi_diem_chat ASC LIMIT 1`,
                [session.session_id]
            );
            session.first_message = firstMsg.length > 0 ? firstMsg[0].noi_dung : 'Cuộc trò chuyện';
        }

        res.json({
            success: true,
            data: sessions
        });

    } catch (error) {
        console.error('Error getting chat sessions:', error.message);
        res.status(500).json({
            success: false,
            message: 'Lỗi lấy danh sách chat'
        });
    }
});

// API lấy lịch sử chat của user đang đăng nhập
router.get('/history', async (req, res) => {
    try {
        const ma_nguoi_dung = getUserFromToken(req);
        
        if (!ma_nguoi_dung) {
            return res.status(401).json({
                success: false,
                message: 'Vui lòng đăng nhập để xem lịch sử chat'
            });
        }

        const [history] = await db.query(
            `SELECT ma_tin_nhan, nguoi_gui, noi_dung, thoi_diem_chat 
             FROM lich_su_chatbot 
             WHERE ma_nguoi_dung = ? 
             ORDER BY thoi_diem_chat DESC 
             LIMIT 100`,
            [ma_nguoi_dung]
        );

        res.json({
            success: true,
            data: history
        });

    } catch (error) {
        console.error('Error getting chat history:', error.message);
        res.status(500).json({
            success: false,
            message: 'Lỗi lấy lịch sử chat'
        });
    }
});

// API lấy lịch sử chat theo session (cho khách vãng lai)
router.get('/history/:session_id', async (req, res) => {
    try {
        const { session_id } = req.params;

        const [history] = await db.query(
            `SELECT ma_tin_nhan, nguoi_gui, noi_dung, thoi_diem_chat 
             FROM lich_su_chatbot 
             WHERE session_id = ? 
             ORDER BY thoi_diem_chat ASC`,
            [session_id]
        );

        res.json({
            success: true,
            data: history
        });

    } catch (error) {
        console.error('Error getting session chat history:', error.message);
        res.status(500).json({
            success: false,
            message: 'Lỗi lấy lịch sử chat'
        });
    }
});

// ==================== ADMIN APIs ====================

// API lấy thống kê chat cho admin
router.get('/admin/stats', async (req, res) => {
    try {
        const [totalMsg] = await db.query('SELECT COUNT(*) as count FROM lich_su_chatbot');
        const [totalSessions] = await db.query('SELECT COUNT(DISTINCT session_id) as count FROM lich_su_chatbot WHERE session_id IS NOT NULL');
        const [loggedUsers] = await db.query('SELECT COUNT(DISTINCT ma_nguoi_dung) as count FROM lich_su_chatbot WHERE ma_nguoi_dung IS NOT NULL');
        const [guestSessions] = await db.query('SELECT COUNT(DISTINCT session_id) as count FROM lich_su_chatbot WHERE ma_nguoi_dung IS NULL AND session_id IS NOT NULL');
        
        // Thống kê user vs bot
        const [userMessages] = await db.query("SELECT COUNT(*) as count FROM lich_su_chatbot WHERE nguoi_gui = 'user'");
        const [botMessages] = await db.query("SELECT COUNT(*) as count FROM lich_su_chatbot WHERE nguoi_gui = 'bot'");
        
        // Thống kê 7 ngày gần nhất
        const [dailyStats] = await db.query(`
            SELECT DATE(thoi_diem_chat) as ngay, COUNT(*) as so_tin_nhan
            FROM lich_su_chatbot
            WHERE thoi_diem_chat >= DATE_SUB(CURDATE(), INTERVAL 6 DAY)
            GROUP BY DATE(thoi_diem_chat)
            ORDER BY ngay ASC
        `);

        res.json({
            success: true,
            data: {
                total_messages: totalMsg[0].count,
                total_sessions: totalSessions[0].count,
                logged_users: loggedUsers[0].count,
                guest_sessions: guestSessions[0].count,
                user_messages: userMessages[0].count,
                bot_messages: botMessages[0].count,
                daily_stats: dailyStats
            }
        });
    } catch (error) {
        console.error('Error getting chat stats:', error.message);
        res.status(500).json({ success: false, message: 'Lỗi lấy thống kê' });
    }
});

// API lấy lịch sử chat cho admin (có phân trang và filter)
router.get('/admin/history', async (req, res) => {
    try {
        const page = parseInt(req.query.page) || 1;
        const limit = parseInt(req.query.limit) || 20;
        const offset = (page - 1) * limit;
        const { search, user_type, nguoi_gui } = req.query;

        let whereClause = '1=1';
        const params = [];

        if (search) {
            whereClause += ' AND l.noi_dung LIKE ?';
            params.push(`%${search}%`);
        }
        if (user_type === 'logged') {
            whereClause += ' AND l.ma_nguoi_dung IS NOT NULL';
        } else if (user_type === 'guest') {
            whereClause += ' AND l.ma_nguoi_dung IS NULL';
        }
        if (nguoi_gui) {
            whereClause += ' AND l.nguoi_gui = ?';
            params.push(nguoi_gui);
        }

        // Count total
        const [countResult] = await db.query(
            `SELECT COUNT(*) as total FROM lich_su_chatbot l WHERE ${whereClause}`,
            params
        );
        const total = countResult[0].total;

        // Get data with user info
        const [history] = await db.query(
            `SELECT l.*, n.ten_nguoi_dung, n.email 
             FROM lich_su_chatbot l
             LEFT JOIN nguoi_dung n ON l.ma_nguoi_dung = n.ma_nguoi_dung
             WHERE ${whereClause}
             ORDER BY l.thoi_diem_chat DESC
             LIMIT ? OFFSET ?`,
            [...params, limit, offset]
        );

        res.json({
            success: true,
            data: history,
            pagination: {
                page,
                limit,
                total,
                totalPages: Math.ceil(total / limit)
            }
        });
    } catch (error) {
        console.error('Error getting admin chat history:', error.message);
        res.status(500).json({ success: false, message: 'Lỗi lấy lịch sử chat' });
    }
});

// API lấy chi tiết một session cho admin
router.get('/admin/session/:session_id', async (req, res) => {
    try {
        const { session_id } = req.params;
        const [messages] = await db.query(
            `SELECT l.*, n.ten_nguoi_dung, n.email 
             FROM lich_su_chatbot l
             LEFT JOIN nguoi_dung n ON l.ma_nguoi_dung = n.ma_nguoi_dung
             WHERE l.session_id = ?
             ORDER BY l.thoi_diem_chat ASC`,
            [session_id]
        );

        res.json({ success: true, data: messages });
    } catch (error) {
        console.error('Error getting session:', error.message);
        res.status(500).json({ success: false, message: 'Lỗi lấy cuộc trò chuyện' });
    }
});

// API xóa tin nhắn
router.delete('/admin/message/:id', async (req, res) => {
    try {
        const { id } = req.params;
        await db.query('DELETE FROM lich_su_chatbot WHERE ma_tin_nhan = ?', [id]);
        res.json({ success: true, message: 'Đã xóa tin nhắn' });
    } catch (error) {
        console.error('Error deleting message:', error.message);
        res.status(500).json({ success: false, message: 'Lỗi xóa tin nhắn' });
    }
});

module.exports = router;
