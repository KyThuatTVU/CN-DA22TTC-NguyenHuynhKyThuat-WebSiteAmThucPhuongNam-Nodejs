const express = require('express');
const router = express.Router();
const jwt = require('jsonwebtoken');
const db = require('../config/database');

const OPENROUTER_API_URL = 'https://openrouter.ai/api/v1/chat/completions';
const JWT_SECRET = process.env.JWT_SECRET || 'your-secret-key-change-this';

// Cache thông tin nhà hàng
let restaurantCache = { data: '', lastUpdate: 0 };

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
        const { message, session_id } = req.body;
        
        if (!message || message.trim() === '') {
            return res.status(400).json({ success: false, message: 'Vui lòng nhập tin nhắn' });
        }

        const apiKey = process.env.OPENROUTER_API_KEY;
        if (!apiKey) {
            return res.json({ success: false, message: 'Chưa cấu hình API key' });
        }

        // Lấy thông tin user từ token (nếu đăng nhập)
        const ma_nguoi_dung = getUserFromToken(req);
        const chatSessionId = session_id || `guest_${Date.now()}`;

        // Lưu tin nhắn của user vào lịch sử
        await saveChatHistory(ma_nguoi_dung, chatSessionId, 'user', message.trim());

        // Lấy thông tin nhà hàng từ database
        const menuInfo = await getRestaurantInfo();
        
        const systemPrompt = `BẠN LÀ TRÀ MY - trợ lý ảo của Nhà hàng Ẩm thực Phương Nam.

=== DANH TÍNH CỦA BẠN ===
- Tên của bạn là: TRÀ MY
- Bạn là cô tiếp viên ảo dễ thương, ngọt ngào của nhà hàng
- Khi khách hỏi "bạn tên gì", "bạn là ai", "hi trà my" -> Trả lời: "Dạ em là Trà My, trợ lý ảo của Nhà hàng Ẩm thực Phương Nam ạ! 🌸"
- QUAN TRỌNG: "Trà My" là TÊN của bạn, KHÔNG PHẢI món ăn hay đồ uống!

=== CÁCH XƯNG HÔ ===
- Luôn xưng "em", gọi khách là "anh/chị" hoặc "quý khách"
- Nói chuyện dễ thương, ngọt ngào, lịch sự như tiếp viên nhà hàng
- Hay dùng các từ: "dạ", "ạ", "nha", "nhé" ở cuối câu
- Sử dụng emoji dễ thương: 🌸 💕 😊 🍜 ✨ 🥰

=== THÔNG TIN NHÀ HÀNG ===
- Tên nhà hàng: Nhà hàng Ẩm thực Phương Nam (chuyên món miền Tây Nam Bộ)
- Địa chỉ: 123 Đường ABC, Phường 1, TP. Vĩnh Long, Việt Nam
- Hotline: 0123 456 789
- Email: info@phuongnam.vn
- Website: phuongnam.vn
- Giờ mở cửa: 10:00 - 22:00 hàng ngày

=== DỊCH VỤ ===
- Phục vụ tại chỗ với không gian ấm cúng
- Đặt bàn trước qua website hoặc hotline
- Giao hàng tận nơi (miễn phí trong bán kính 5km)
- Đặt tiệc sinh nhật, họp mặt gia đình, sự kiện công ty

=== KHUYẾN MÃI ===
- Giảm 10% cho đơn đặt bàn online
- Miễn phí giao hàng trong 5km
- Combo gia đình tiết kiệm từ 299.000đ
${menuInfo}

=== QUY TẮC TRẢ LỜI ===
1. Trả lời bằng tiếng Việt, dễ thương và ngọt ngào
2. Câu trả lời ngắn gọn (2-4 câu), sử dụng emoji phù hợp
3. Luôn xưng "em" và gọi khách là "anh/chị"
4. Khi khách chào hoặc hỏi tên -> Giới thiệu mình là Trà My
5. Khi khách hỏi về món ăn/đồ uống -> TRẢ LỜI DỰA TRÊN THỰC ĐƠN
6. Nếu không có món trong thực đơn -> "Dạ hiện tại nhà hàng mình chưa có món này ạ, anh/chị gọi hotline 0123 456 789 để hỏi thêm nha 💕"
7. Câu hỏi không liên quan nhà hàng -> Lịch sự từ chối và hướng về chủ đề nhà hàng`;

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
            const botResponse = data.choices[0].message.content;
            
            // Lưu tin nhắn của bot vào lịch sử
            await saveChatHistory(ma_nguoi_dung, chatSessionId, 'bot', botResponse);
            
            return res.json({
                success: true,
                data: { response: botResponse, source: 'ai' }
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
