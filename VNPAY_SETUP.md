# Hướng dẫn cấu hình VNPay

## 1. Đăng ký tài khoản VNPay Sandbox

1. Truy cập: https://sandbox.vnpayment.vn/devreg
2. Đăng ký tài khoản demo
3. Sau khi đăng ký thành công, bạn sẽ nhận được:
   - `vnp_TmnCode`: Mã website/merchant
   - `vnp_HashSecret`: Chuỗi bí mật để mã hóa

## 2. Cấu hình Backend

Mở file `backend/.env` và cập nhật các thông tin VNPay:

```env
# VNPay Configuration
VNP_TMN_CODE=YOUR_TMN_CODE        # Thay bằng mã TMN Code của bạn
VNP_HASH_SECRET=YOUR_HASH_SECRET  # Thay bằng Hash Secret của bạn
VNP_URL=https://sandbox.vnpayment.vn/paymentv2/vpcpay.html
VNP_API=https://sandbox.vnpayment.vn/merchant_webapi/api/transaction
VNP_RETURN_URL=http://localhost:3000/api/payment/vnpay-return
```

## 3. Thông tin thẻ test (Sandbox)

Khi thanh toán trên môi trường sandbox, sử dụng thông tin thẻ test sau:

### Thẻ nội địa (ATM)
- Ngân hàng: NCB
- Số thẻ: 9704198526191432198
- Tên chủ thẻ: NGUYEN VAN A
- Ngày phát hành: 07/15
- Mật khẩu OTP: 123456

### Thẻ quốc tế (Visa/Mastercard)
- Số thẻ: 4456530000001096 (Visa)
- Tên chủ thẻ: NGUYEN VAN A
- Ngày hết hạn: 12/25
- CVV: 123

## 4. Flow thanh toán

1. **Khách hàng**: Chọn VNPay làm phương thức thanh toán và đặt hàng
2. **Backend**: Tạo đơn hàng và gọi API VNPay để tạo URL thanh toán
3. **Frontend**: Redirect khách hàng đến cổng thanh toán VNPay
4. **Khách hàng**: Nhập thông tin thẻ và xác nhận thanh toán tại VNPay
5. **VNPay**: Xử lý thanh toán và redirect về website (vnp_ReturnUrl)
6. **Backend**: Nhận callback, xác thực chữ ký, cập nhật trạng thái đơn hàng
7. **Frontend**: Hiển thị kết quả thanh toán cho khách hàng

## 5. API Endpoints

### Tạo thanh toán VNPay
```
POST /api/payment/vnpay/create-payment
Authorization: Bearer <token>

Body:
{
  "orderId": 123,
  "amount": 500000,
  "orderInfo": "Thanh toan don hang 123",
  "bankCode": "" // Optional, để trống để hiện danh sách ngân hàng
}

Response:
{
  "success": true,
  "data": {
    "paymentUrl": "https://sandbox.vnpayment.vn/paymentv2/vpcpay.html?...",
    "txnRef": "123_1234567890"
  }
}
```

### Callback VNPay (Return URL)
```
GET /api/payment/vnpay-return?vnp_Amount=...&vnp_ResponseCode=...
```

### IPN (Instant Payment Notification)
```
GET /api/payment/vnpay-ipn?vnp_Amount=...&vnp_ResponseCode=...
```

### Kiểm tra trạng thái thanh toán
```
GET /api/payment/check-payment-status/:orderId
Authorization: Bearer <token>
```

## 6. Mã response code VNPay

- `00`: Giao dịch thành công
- `07`: Trừ tiền thành công. Giao dịch bị nghi ngờ (liên quan tới lừa đảo, giao dịch bất thường).
- `09`: Giao dịch không thành công do: Thẻ/Tài khoản của khách hàng chưa đăng ký dịch vụ InternetBanking tại ngân hàng.
- `10`: Giao dịch không thành công do: Khách hàng xác thực thông tin thẻ/tài khoản không đúng quá 3 lần
- `11`: Giao dịch không thành công do: Đã hết hạn chờ thanh toán. Xin quý khách vui lòng thực hiện lại giao dịch.
- `12`: Giao dịch không thành công do: Thẻ/Tài khoản của khách hàng bị khóa.
- `13`: Giao dịch không thành công do Quý khách nhập sai mật khẩu xác thực giao dịch (OTP).
- `24`: Giao dịch không thành công do: Khách hàng hủy giao dịch
- `51`: Giao dịch không thành công do: Tài khoản của quý khách không đủ số dư để thực hiện giao dịch.
- `65`: Giao dịch không thành công do: Tài khoản của Quý khách đã vượt quá hạn mức giao dịch trong ngày.
- `75`: Ngân hàng thanh toán đang bảo trì.
- `79`: Giao dịch không thành công do: KH nhập sai mật khẩu thanh toán quá số lần quy định.
- `99`: Các lỗi khác

## 7. Testing

1. Khởi động server: `cd backend && npm start`
2. Truy cập: http://localhost:5500/frontend/thanh-toan.html
3. Chọn phương thức thanh toán VNPay
4. Hoàn tất đặt hàng
5. Tại trang VNPay, sử dụng thông tin thẻ test ở trên
6. Xác nhận thanh toán và kiểm tra kết quả

## 8. Cài đặt tài khoản ngân hàng nhận tiền (CHỦ DOANH NGHIỆP)

### 📌 Nơi cài đặt: Trong hệ thống VNPay Merchant Portal

Sau khi đăng ký VNPay thành công, bạn sẽ được cung cấp:
- **VNPay Merchant Portal**: https://merchant.vnpay.vn
- Tài khoản đăng nhập quản lý

### 🏦 Các bước cài đặt tài khoản ngân hàng:

#### **Bước 1: Đăng nhập Merchant Portal**
```
URL: https://merchant.vnpay.vn
→ Đăng nhập bằng tài khoản được VNPay cấp
```

#### **Bước 2: Vào mục "Cài đặt tài khoản nhận tiền"**
```
Menu: Cài đặt → Tài khoản nhận tiền → Thêm tài khoản
```

#### **Bước 3: Điền thông tin tài khoản ngân hàng**

**Thông tin cần cung cấp:**
- ✅ Tên ngân hàng: (VD: Vietcombank, BIDV, ACB, Techcombank...)
- ✅ Số tài khoản: Tài khoản doanh nghiệp (không dùng tài khoản cá nhân)
- ✅ Tên chủ tài khoản: Phải trùng với tên doanh nghiệp đã đăng ký
- ✅ Chi nhánh: Chi nhánh ngân hàng mở tài khoản
- ✅ Upload chứng từ: 
  - Ảnh/scan sao kê tài khoản
  - Giấy xác nhận tài khoản từ ngân hàng

#### **Bước 4: VNPay xác thực**
- VNPay sẽ kiểm tra và xác thực thông tin (1-3 ngày làm việc)
- Có thể yêu cầu bổ sung giấy tờ nếu cần
- Sau khi xác thực, tài khoản sẽ được kích hoạt

#### **Bước 5: Cài đặt chu kỳ chuyển tiền**
Trong Merchant Portal, bạn có thể chọn:
- **T+1**: Nhận tiền sau 1 ngày làm việc
- **T+2**: Nhận tiền sau 2 ngày làm việc  
- **T+3**: Nhận tiền sau 3 ngày làm việc
- **Tuần**: Nhận tiền 1 lần/tuần
- **Tháng**: Nhận tiền 1 lần/tháng

### 📋 Giấy tờ cần chuẩn bị:

**Cho doanh nghiệp/công ty:**
1. ✅ Giấy phép kinh doanh (bản sao công chứng)
2. ✅ Quyết định thành lập công ty
3. ✅ Giấy tờ pháp nhân (CMND/CCCD Giám đốc)
4. ✅ Giấy xác nhận tài khoản ngân hàng doanh nghiệp
5. ✅ Hợp đồng thuê văn phòng (nếu có)

**Cho hộ kinh doanh/cá nhân:**
1. ✅ Giấy chứng nhận đăng ký hộ kinh doanh
2. ✅ CMND/CCCD chủ hộ
3. ✅ Tài khoản ngân hàng (có thể là tài khoản cá nhân)

### 💡 Lưu ý quan trọng:

⚠️ **Tài khoản ngân hàng PHẢI:**
- Thuộc chủ doanh nghiệp đã đăng ký với VNPay
- Là tài khoản thanh toán (không phải tài khoản tiết kiệm)
- Đang hoạt động bình thường

⚠️ **KHÔNG được:**
- Dùng tài khoản người thân, bạn bè
- Dùng tài khoản không khớp tên doanh nghiệp
- Dùng tài khoản ở nước ngoài

### 📊 Ví dụ cụ thể:

```
Tên doanh nghiệp: CÔNG TY TNHH ẨM THỰC PHƯƠNG NAM
Tài khoản ngân hàng:
- Ngân hàng: Vietcombank
- Chi nhánh: Vĩnh Long
- Số tài khoản: 1234567890
- Tên tài khoản: CONG TY TNHH AM THUC PHUONG NAM
- Chu kỳ nhận tiền: T+2

→ Sau 2 ngày làm việc kể từ khi khách thanh toán,
  tiền sẽ được VNPay chuyển vào tài khoản này
```

### 📞 Liên hệ hỗ trợ:

Nếu gặp khó khăn khi cài đặt:
- **Hotline VNPay**: 1900 55 55 77
- **Email**: merchant@vnpay.vn
- **Zalo OA**: @vnpaymerchant

## 9. Chuyển sang môi trường Production

Khi chuyển sang production:

1. Đăng ký tài khoản VNPay chính thức tại: https://vnpay.vn
2. Ký hợp đồng và hoàn tất thủ tục pháp lý
3. **Cài đặt tài khoản ngân hàng nhận tiền** (theo hướng dẫn mục 8)
4. Nhận thông tin production từ VNPay
5. Cập nhật file `.env`:
```env
VNP_URL=https://vnpayment.vn/paymentv2/vpcpay.html
VNP_API=https://vnpayment.vn/merchant_webapi/api/transaction
VNP_RETURN_URL=https://yourdomain.com/api/payment/vnpay-return
```

## 10. Bảo mật

- ⚠️ KHÔNG commit file `.env` lên Git
- ⚠️ KHÔNG chia sẻ `vnp_HashSecret` cho bất kỳ ai
- ✅ Luôn xác thực chữ ký từ VNPay
- ✅ Sử dụng HTTPS trong production
- ✅ Log tất cả giao dịch để tra cứu

## 11. Hỗ trợ

- Tài liệu VNPay: https://sandbox.vnpayment.vn/apis/docs/huong-dan-tich-hop/
- Email hỗ trợ: support@vnpay.vn
- Hotline: 1900 55 55 77
