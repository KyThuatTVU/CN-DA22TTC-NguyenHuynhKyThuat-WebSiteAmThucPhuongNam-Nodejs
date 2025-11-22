// VNPay Configuration
require('dotenv').config();

// Chế độ test: true = dùng trang test local, false = dùng VNPay thật
const TEST_MODE = process.env.VNPAY_TEST_MODE === 'true';

module.exports = {
    vnp_TmnCode: process.env.VNP_TMN_CODE || 'YOUR_TMN_CODE', // Mã website tại VNPay
    vnp_HashSecret: process.env.VNP_HASH_SECRET || 'YOUR_HASH_SECRET', // Chuỗi bí mật
    vnp_Url: TEST_MODE 
        ? 'http://localhost:3000/vnpay-test.html' // Test mode: redirect đến trang test local
        : (process.env.VNP_URL || 'https://sandbox.vnpayment.vn/paymentv2/vpcpay.html'), // Production: VNPay thật
    vnp_Api: process.env.VNP_API || 'https://sandbox.vnpayment.vn/merchant_webapi/api/transaction',
    vnp_ReturnUrl: process.env.VNP_RETURN_URL || 'http://localhost:3000/api/payment/vnpay-return', // URL trả về sau khi thanh toán
};
