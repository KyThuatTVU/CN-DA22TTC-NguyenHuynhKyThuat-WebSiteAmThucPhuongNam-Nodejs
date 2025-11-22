const express = require('express');
const router = express.Router();
const crypto = require('crypto');
const querystring = require('qs');
const db = require('../config/database');
const vnpayConfig = require('../config/vnpay');

// Middleware xác thực token
const authenticateToken = (req, res, next) => {
    const authHeader = req.headers['authorization'];
    const token = authHeader && authHeader.split(' ')[1];

    if (!token) {
        return res.status(401).json({
            success: false,
            message: 'Không có token xác thực'
        });
    }

    try {
        const jwt = require('jsonwebtoken');
        const JWT_SECRET = process.env.JWT_SECRET || 'your-secret-key';
        jwt.verify(token, JWT_SECRET, (err, user) => {
            if (err) {
                return res.status(403).json({
                    success: false,
                    message: 'Token không hợp lệ'
                });
            }
            req.user = user;
            next();
        });
    } catch (error) {
        res.status(500).json({
            success: false,
            message: 'Lỗi xác thực token'
        });
    }
};

// Hàm sắp xếp object theo key (không encode)
function sortObject(obj) {
    let sorted = {};
    let str = [];
    let key;
    for (key in obj) {
        if (obj.hasOwnProperty(key)) {
            str.push(key);
        }
    }
    str.sort();
    for (key = 0; key < str.length; key++) {
        sorted[str[key]] = obj[str[key]];
    }
    return sorted;
}

// Tạo URL thanh toán VNPay
router.post('/vnpay/create-payment', authenticateToken, async (req, res) => {
    try {
        const { orderId, amount, orderInfo, bankCode } = req.body;

        // Validate
        if (!orderId || !amount) {
            return res.status(400).json({
                success: false,
                message: 'Thiếu thông tin đơn hàng'
            });
        }

        // Kiểm tra đơn hàng có tồn tại và thuộc về user
        const [orderRows] = await db.query(
            'SELECT * FROM don_hang WHERE ma_don_hang = ? AND ma_nguoi_dung = ?',
            [orderId, req.user.ma_nguoi_dung]
        );

        if (orderRows.length === 0) {
            return res.status(404).json({
                success: false,
                message: 'Không tìm thấy đơn hàng'
            });
        }

        const order = orderRows[0];

        // Tạo thời gian
        const date = new Date();
        const createDate = date.toISOString().slice(0, 19).replace(/[-:T]/g, '').slice(0, 14);
        const expireDate = new Date(date.getTime() + 30 * 60 * 1000) // Tăng lên 30 phút
            .toISOString().slice(0, 19).replace(/[-:T]/g, '').slice(0, 14);

        // Lấy IP người dùng
        let ipAddr = req.headers['x-forwarded-for'] ||
            req.connection.remoteAddress ||
            req.socket.remoteAddress ||
            req.connection.socket.remoteAddress;

        // Xử lý trường hợp IP là IPv6 localhost (::1)
        if (ipAddr === '::1') {
            ipAddr = '127.0.0.1';
        }

        // Tạo mã giao dịch duy nhất
        const txnRef = `${orderId}_${Date.now()}`;

        // Tạo các tham số cho VNPay
        let vnp_Params = {
            'vnp_Version': '2.1.0',
            'vnp_Command': 'pay',
            'vnp_TmnCode': vnpayConfig.vnp_TmnCode,
            'vnp_Locale': 'en', // Đổi sang tiếng Anh để tránh lỗi script trên bản tiếng Việt
            'vnp_CurrCode': 'VND',
            'vnp_TxnRef': txnRef,
            'vnp_OrderInfo': orderInfo || `Thanh toan don hang ${orderId}`,
            'vnp_OrderType': 'other',
            'vnp_Amount': Math.floor(amount) * 100, // VNPay yêu cầu số tiền nhân 100 và là số nguyên
            'vnp_ReturnUrl': vnpayConfig.vnp_ReturnUrl,
            'vnp_IpAddr': ipAddr,
            'vnp_CreateDate': createDate,
            // 'vnp_ExpireDate': expireDate // Tạm tắt để tránh lỗi ReferenceError: timer is not defined trên sandbox
        };

        // Thêm bankCode nếu có, nếu không thì mặc định là NCB để bypass trang chọn ngân hàng (tránh lỗi ReferenceError trên sandbox)
        if (bankCode && bankCode !== "") {
            vnp_Params['vnp_BankCode'] = bankCode;
        } else {
            vnp_Params['vnp_BankCode'] = 'NCB';
        }

        // Sắp xếp params
        vnp_Params = sortObject(vnp_Params);

        // Bước 1: Tạo chuỗi KHÔNG encode để ký
        let signDataArr = [];
        for (let key in vnp_Params) {
            if (vnp_Params.hasOwnProperty(key) && vnp_Params[key] !== null && vnp_Params[key] !== '') {
                signDataArr.push(key + '=' + vnp_Params[key]);
            }
        }
        const signDataString = signDataArr.join('&');

        // Bước 2: Tạo chữ ký từ chuỗi không encode
        const hmac = crypto.createHmac("sha512", vnpayConfig.vnp_HashSecret);
        const signed = hmac.update(Buffer.from(signDataString, 'utf-8')).digest("hex");
        vnp_Params['vnp_SecureHash'] = signed;

        // Bước 3: Tạo URL với encode
        let urlDataArr = [];
        for (let key in vnp_Params) {
            if (vnp_Params.hasOwnProperty(key) && vnp_Params[key] !== null && vnp_Params[key] !== '') {
                urlDataArr.push(key + '=' + encodeURIComponent(vnp_Params[key]));
            }
        }
        const paymentUrl = vnpayConfig.vnp_Url + '?' + urlDataArr.join('&');

        // Log để debug
        console.log('🔐 VNPay Payment URL created:');
        console.log('📋 TxnRef:', txnRef);
        console.log('💰 Amount:', amount);
        console.log('🔑 TMN Code:', vnpayConfig.vnp_TmnCode);
        console.log('📝 Sign Data (không encode):', signDataString);
        console.log('🔐 SecureHash:', signed);
        console.log('🔗 Payment URL:', paymentUrl);

        // Lưu thông tin giao dịch vào database
        await db.query(
            `INSERT INTO thanh_toan (ma_don_hang, so_tien, phuong_thuc, ma_giao_dich, trang_thai)
             VALUES (?, ?, 'vnpay', ?, 'pending')`,
            [orderId, amount, txnRef]
        );

        res.json({
            success: true,
            data: {
                paymentUrl: paymentUrl,
                txnRef: txnRef
            }
        });

    } catch (error) {
        console.error('Lỗi tạo thanh toán VNPay:', error);
        res.status(500).json({
            success: false,
            message: 'Lỗi server',
            error: error.message
        });
    }
});

// Xử lý callback từ VNPay
router.get('/vnpay-return', async (req, res) => {
    try {
        let vnp_Params = req.query;
        const secureHash = vnp_Params['vnp_SecureHash'];

        // Xóa các tham số không cần thiết
        delete vnp_Params['vnp_SecureHash'];
        delete vnp_Params['vnp_SecureHashType'];

        // Sắp xếp params
        vnp_Params = sortObject(vnp_Params);

        // Tạo chuỗi KHÔNG encode để ký
        let signDataArr = [];
        for (let key in vnp_Params) {
            if (vnp_Params.hasOwnProperty(key) && vnp_Params[key] !== null && vnp_Params[key] !== '') {
                signDataArr.push(key + '=' + vnp_Params[key]);
            }
        }
        const signDataString = signDataArr.join('&');

        const hmac = crypto.createHmac("sha512", vnpayConfig.vnp_HashSecret);
        const signed = hmac.update(Buffer.from(signDataString, 'utf-8')).digest("hex");        // Kiểm tra chữ ký
        if (secureHash === signed) {
            const orderId = vnp_Params['vnp_TxnRef'].split('_')[0];
            const rspCode = vnp_Params['vnp_ResponseCode'];
            const amount = vnp_Params['vnp_Amount'] / 100;
            const transactionNo = vnp_Params['vnp_TransactionNo'];
            const bankCode = vnp_Params['vnp_BankCode'];
            const payDate = vnp_Params['vnp_PayDate'];

            // Chuyển đổi format thời gian VNPay (yyyyMMddHHmmss) sang datetime
            const year = payDate.substring(0, 4);
            const month = payDate.substring(4, 6);
            const day = payDate.substring(6, 8);
            const hour = payDate.substring(8, 10);
            const minute = payDate.substring(10, 12);
            const second = payDate.substring(12, 14);
            const formattedPayDate = `${year}-${month}-${day} ${hour}:${minute}:${second}`;

            if (rspCode === '00') {
                // Thanh toán thành công
                await db.query(
                    `UPDATE thanh_toan 
                     SET trang_thai = 'success', 
                         ma_giao_dich = ?,
                         thoi_gian_thanh_toan = ?,
                         thong_tin_them = ?
                     WHERE ma_giao_dich = ?`,
                    [
                        transactionNo,
                        formattedPayDate,
                        JSON.stringify({ bankCode, amount }),
                        vnp_Params['vnp_TxnRef']
                    ]
                );

                // Cập nhật trạng thái đơn hàng
                await db.query(
                    `UPDATE don_hang SET trang_thai = 'confirmed' WHERE ma_don_hang = ?`,
                    [orderId]
                );

                // Redirect về trang thành công
                res.redirect(`/dat-hang-thanh-cong.html?orderId=${orderId}&payment=vnpay&status=success`);
            } else {
                // Thanh toán thất bại
                await db.query(
                    `UPDATE thanh_toan 
                     SET trang_thai = 'failed',
                         thong_tin_them = ?
                     WHERE ma_giao_dich = ?`,
                    [
                        JSON.stringify({ rspCode, message: 'Thanh toán thất bại' }),
                        vnp_Params['vnp_TxnRef']
                    ]
                );

                // Redirect về trang đơn hàng với thông báo thất bại
                res.redirect(`/don-hang-cua-toi.html?payment_failed=true&orderId=${orderId}&message=${encodeURIComponent('Thanh toán không thành công. Đơn hàng đã được lưu, bạn có thể thanh toán lại sau.')}`);
            }
        } else {
            // Chữ ký không hợp lệ
            res.redirect(`/don-hang-cua-toi.html?payment_failed=true&message=${encodeURIComponent('Chữ ký không hợp lệ. Vui lòng thử lại hoặc liên hệ hỗ trợ.')}`);
        }
    } catch (error) {
        console.error('Lỗi xử lý callback VNPay:', error);
        res.redirect(`/don-hang-cua-toi.html?payment_failed=true&message=${encodeURIComponent('Lỗi xử lý thanh toán. Vui lòng thử lại.')}`);
    }
});

// IPN (Instant Payment Notification) - VNPay gọi API này để thông báo kết quả
router.get('/vnpay-ipn', async (req, res) => {
    try {
        let vnp_Params = req.query;
        const secureHash = vnp_Params['vnp_SecureHash'];

        delete vnp_Params['vnp_SecureHash'];
        delete vnp_Params['vnp_SecureHashType'];

        vnp_Params = sortObject(vnp_Params);

        // Tạo chuỗi để ký (encode theo chuẩn URL)
        const signData = new URLSearchParams(vnp_Params).toString();

        const hmac = crypto.createHmac("sha512", vnpayConfig.vnp_HashSecret);
        const signed = hmac.update(Buffer.from(signData, 'utf-8')).digest("hex");

        if (secureHash === signed) {
            const orderId = vnp_Params['vnp_TxnRef'].split('_')[0];
            const rspCode = vnp_Params['vnp_ResponseCode'];

            // Kiểm tra đơn hàng có tồn tại
            const [orderRows] = await db.query(
                'SELECT * FROM don_hang WHERE ma_don_hang = ?',
                [orderId]
            );

            if (orderRows.length > 0) {
                const order = orderRows[0];

                if (rspCode === '00') {
                    // Thanh toán thành công
                    if (order.trang_thai === 'pending') {
                        await db.query(
                            'UPDATE don_hang SET trang_thai = "confirmed" WHERE ma_don_hang = ?',
                            [orderId]
                        );
                    }

                    res.status(200).json({ RspCode: '00', Message: 'Success' });
                } else {
                    res.status(200).json({ RspCode: '00', Message: 'Success' });
                }
            } else {
                res.status(200).json({ RspCode: '01', Message: 'Order not found' });
            }
        } else {
            res.status(200).json({ RspCode: '97', Message: 'Invalid signature' });
        }
    } catch (error) {
        console.error('Lỗi IPN VNPay:', error);
        res.status(200).json({ RspCode: '99', Message: 'Unknown error' });
    }
});

// Kiểm tra trạng thái thanh toán
router.get('/check-payment-status/:orderId', authenticateToken, async (req, res) => {
    try {
        const { orderId } = req.params;

        const [payments] = await db.query(
            `SELECT * FROM thanh_toan 
             WHERE ma_don_hang = ? 
             ORDER BY ma_thanh_toan DESC 
             LIMIT 1`,
            [orderId]
        );

        if (payments.length === 0) {
            return res.status(404).json({
                success: false,
                message: 'Không tìm thấy thông tin thanh toán'
            });
        }

        res.json({
            success: true,
            data: payments[0]
        });

    } catch (error) {
        console.error('Lỗi kiểm tra trạng thái thanh toán:', error);
        res.status(500).json({
            success: false,
            message: 'Lỗi server',
            error: error.message
        });
    }
});

// Thanh toán lại đơn hàng (khi thanh toán trước đó thất bại)
router.post('/vnpay/retry-payment/:orderId', authenticateToken, async (req, res) => {
    try {
        const { orderId } = req.params;

        // Kiểm tra đơn hàng
        const [orderRows] = await db.query(
            'SELECT * FROM don_hang WHERE ma_don_hang = ? AND ma_nguoi_dung = ?',
            [orderId, req.user.ma_nguoi_dung]
        );

        if (orderRows.length === 0) {
            return res.status(404).json({
                success: false,
                message: 'Không tìm thấy đơn hàng'
            });
        }

        const order = orderRows[0];
        
        // Debug: Log order data
        console.log('📦 Order data:', {
            ma_don_hang: order.ma_don_hang,
            tong_tien: order.tong_tien,
            tong_thanh_toan: order.tong_thanh_toan,
            all_fields: Object.keys(order)
        });

        // Kiểm tra đơn hàng chưa thanh toán và chưa bị hủy
        if (order.trang_thai === 'cancelled') {
            return res.status(400).json({
                success: false,
                message: 'Đơn hàng đã bị hủy, không thể thanh toán'
            });
        }

        // Tạo URL thanh toán mới (tương tự create-payment)
        const date = new Date();
        const createDate = date.toISOString().slice(0, 19).replace(/[-:T]/g, '').slice(0, 14);
        
        let ipAddr = req.headers['x-forwarded-for'] ||
            req.connection.remoteAddress ||
            req.socket.remoteAddress ||
            req.connection.socket.remoteAddress;

        if (ipAddr === '::1') {
            ipAddr = '127.0.0.1';
        }

        const txnRef = `${orderId}_${Date.now()}`;

        let vnp_Params = {
            'vnp_Version': '2.1.0',
            'vnp_Command': 'pay',
            'vnp_TmnCode': vnpayConfig.vnp_TmnCode,
            'vnp_Locale': 'vn',
            'vnp_CurrCode': 'VND',
            'vnp_TxnRef': txnRef,
            'vnp_OrderInfo': `Thanh toan lai don hang ${orderId}`,
            'vnp_OrderType': 'other',
            'vnp_Amount': Math.floor(order.tong_tien) * 100,
            'vnp_ReturnUrl': vnpayConfig.vnp_ReturnUrl,
            'vnp_IpAddr': ipAddr,
            'vnp_CreateDate': createDate,
            'vnp_BankCode': 'NCB'
        };

        vnp_Params = sortObject(vnp_Params);

        let signDataArr = [];
        for (let key in vnp_Params) {
            if (vnp_Params.hasOwnProperty(key) && vnp_Params[key] !== null && vnp_Params[key] !== '') {
                signDataArr.push(key + '=' + vnp_Params[key]);
            }
        }
        const signDataString = signDataArr.join('&');

        const hmac = crypto.createHmac("sha512", vnpayConfig.vnp_HashSecret);
        const signed = hmac.update(Buffer.from(signDataString, 'utf-8')).digest("hex");
        vnp_Params['vnp_SecureHash'] = signed;

        let urlDataArr = [];
        for (let key in vnp_Params) {
            if (vnp_Params.hasOwnProperty(key) && vnp_Params[key] !== null && vnp_Params[key] !== '') {
                urlDataArr.push(key + '=' + encodeURIComponent(vnp_Params[key]));
            }
        }
        const paymentUrl = vnpayConfig.vnp_Url + '?' + urlDataArr.join('&');

        console.log('🔄 Retry Payment URL created for order:', orderId);

        // Tạo bản ghi thanh toán mới
        await db.query(
            `INSERT INTO thanh_toan (ma_don_hang, so_tien, phuong_thuc, ma_giao_dich, trang_thai)
             VALUES (?, ?, 'vnpay', ?, 'pending')`,
            [orderId, order.tong_tien, txnRef]
        );

        res.json({
            success: true,
            data: {
                paymentUrl: paymentUrl,
                txnRef: txnRef
            }
        });

    } catch (error) {
        console.error('Lỗi thanh toán lại:', error);
        res.status(500).json({
            success: false,
            message: 'Lỗi server',
            error: error.message
        });
    }
});

// TEST ENDPOINT - Simulate VNPay callback (chỉ dùng khi VNPay sandbox không hoạt động)
router.get('/test-callback/:txnRef', async (req, res) => {
    try {
        const { txnRef } = req.params;
        const { status } = req.query; // success hoặc failed

        // Tạo params giả lập từ VNPay
        const orderId = txnRef.split('_')[0];
        const now = new Date();
        const payDate = now.toISOString().replace(/[-:T.]/g, '').slice(0, 14);

        const vnp_Params = {
            vnp_Amount: '10000000', // 100,000 VND
            vnp_BankCode: 'NCB',
            vnp_BankTranNo: 'VNP' + Date.now(),
            vnp_CardType: 'ATM',
            vnp_OrderInfo: `Thanh toan don hang ${orderId}`,
            vnp_PayDate: payDate,
            vnp_ResponseCode: status === 'success' ? '00' : '24',
            vnp_TmnCode: vnpayConfig.vnp_TmnCode,
            vnp_TransactionNo: Date.now().toString(),
            vnp_TransactionStatus: status === 'success' ? '00' : '02',
            vnp_TxnRef: txnRef
        };

        // Sắp xếp params
        const sortedParams = sortObject(vnp_Params);

        // Tạo chữ ký
        let signDataArr = [];
        for (let key in sortedParams) {
            if (sortedParams.hasOwnProperty(key)) {
                signDataArr.push(key + '=' + sortedParams[key]);
            }
        }
        const signDataString = signDataArr.join('&');
        const hmac = crypto.createHmac("sha512", vnpayConfig.vnp_HashSecret);
        const signed = hmac.update(Buffer.from(signDataString, 'utf-8')).digest("hex");

        // Thêm chữ ký
        vnp_Params.vnp_SecureHash = signed;

        // Redirect đến vnpay-return với params
        const queryString = new URLSearchParams(vnp_Params).toString();
        res.redirect(`/api/payment/vnpay-return?${queryString}`);

    } catch (error) {
        console.error('Lỗi test callback:', error);
        res.status(500).json({
            success: false,
            message: 'Lỗi test callback',
            error: error.message
        });
    }
});

module.exports = router;
