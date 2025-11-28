# 🎯 Hướng dẫn tích hợp MoMo Payment

## ✅ Ưu điểm MoMo

- ✅ **Phổ biến nhất VN**: 40+ triệu người dùng
- ✅ **API đơn giản**: Dễ tích hợp, tài liệu rõ ràng
- ✅ **Sandbox ổn định**: Test dễ dàng
- ✅ **Hỗ trợ tốt**: Response nhanh, nhiều kênh hỗ trợ
- ✅ **Phí hợp lý**: 1.5% - 2.5% mỗi giao dịch
- ✅ **Đăng ký nhanh**: Miễn phí, duyệt trong 1-2 ngày

## 📋 Bước 1: Đăng ký tài khoản MoMo Developer

### 1.1. Truy cập trang đăng ký
- Website: https://developers.momo.vn/
- Click **"Đăng ký"** ở góc trên bên phải

### 1.2. Điền thông tin đăng ký
- Email
- Số điện thoại
- Mật khẩu
- Xác nhận OTP

### 1.3. Tạo ứng dụng mới
1. Đăng nhập vào Developer Portal
2. Click **"Tạo ứng dụng mới"**
3. Điền thông tin:
   - Tên ứng dụng: `Nhà hàng Phương Nam`
   - Loại ứng dụng: `Website`
   - Mô tả: `Hệ thống đặt món ăn online`
   - Website: `http://localhost:3000` (test) hoặc domain thật
4. Click **"Tạo"**

### 1.4. Lấy thông tin xác thực
Sau khi tạo ứng dụng, bạn sẽ nhận được:
- **Partner Code**: Mã đối tác (ví dụ: `MOMOXXX`)
- **Access Key**: Khóa truy cập
- **Secret Key**: Khóa bí mật (giữ bí mật!)

## 📝 Bước 2: Cấu hình Backend

### 2.1. Cập nhật file `.env`
```env
# MoMo Payment Configuration
MOMO_PARTNER_CODE=YOUR_PARTNER_CODE
MOMO_ACCESS_KEY=YOUR_ACCESS_KEY
MOMO_SECRET_KEY=YOUR_SECRET_KEY
MOMO_ENDPOINT=https://test-payment.momo.vn/v2/gateway/api/create
MOMO_REDIRECT_URL=http://localhost:3000/api/payment/momo-return
MOMO_IPN_URL=http://localhost:3000/api/payment/momo-ipn
```

**Lưu ý:**
- Thay `YOUR_PARTNER_CODE`, `YOUR_ACCESS_KEY`, `YOUR_SECRET_KEY` bằng thông tin thật
- Môi trường test: `https://test-payment.momo.vn/v2/gateway/api/create`
- Môi trường production: `https://payment.momo.vn/v2/gateway/api/create`

### 2.2. Restart server
```bash
cd backend
npm start
```

## 🧪 Bước 3: Test thanh toán

### 3.1. Tạo đơn hàng
1. Truy cập: http://localhost:3000
2. Đăng nhập
3. Thêm món vào giỏ hàng
4. Vào trang thanh toán
5. Chọn phương thức: **MoMo**
6. Click **"Đặt hàng"**

### 3.2. Thanh toán trên MoMo Sandbox
Bạn sẽ được redirect đến trang MoMo test. Có 2 cách test:

#### Cách 1: Quét QR Code
- Mở app MoMo trên điện thoại
- Quét mã QR hiển thị trên màn hình
- Xác nhận thanh toán

#### Cách 2: Dùng tài khoản test
MoMo cung cấp tài khoản test:
- Số điện thoại: `0963181714`
- OTP: `123456`

### 3.3. Kiểm tra kết quả
- **Thành công**: Redirect về `/dat-hang-thanh-cong.html`
- **Thất bại**: Redirect về `/don-hang-cua-toi.html` với thông báo lỗi

## 🔍 Bước 4: Kiểm tra database

```sql
-- Kiểm tra thanh toán
SELECT * FROM thanh_toan 
WHERE phuong_thuc = 'momo' 
ORDER BY ma_thanh_toan DESC 
LIMIT 5;

-- Kiểm tra đơn hàng
SELECT dh.*, tt.trang_thai as trang_thai_thanh_toan
FROM don_hang dh
LEFT JOIN thanh_toan tt ON dh.ma_don_hang = tt.ma_don_hang
WHERE tt.phuong_thuc = 'momo'
ORDER BY dh.ma_don_hang DESC
LIMIT 5;
```

## 📊 Flow thanh toán MoMo

```
1. User chọn MoMo → Click "Đặt hàng"
   ↓
2. Backend tạo đơn hàng → Lưu vào database
   ↓
3. Backend gọi API MoMo → Nhận payUrl
   ↓
4. Frontend redirect → Trang thanh toán MoMo
   ↓
5. User thanh toán trên MoMo
   ↓
6. MoMo redirect về → /api/payment/momo-return
   ↓
7. Backend verify signature → Cập nhật database
   ↓
8. Redirect user → Trang thành công/thất bại
```

## 🔐 Bảo mật

### Signature Verification
MoMo sử dụng HMAC SHA256 để tạo chữ ký:

```javascript
const rawSignature = `accessKey=${accessKey}&amount=${amount}&extraData=${extraData}&ipnUrl=${ipnUrl}&orderId=${orderId}&orderInfo=${orderInfo}&partnerCode=${partnerCode}&redirectUrl=${redirectUrl}&requestId=${requestId}&requestType=${requestType}`;

const signature = crypto
    .createHmac('sha256', secretKey)
    .update(rawSignature)
    .digest('hex');
```

**Quan trọng:**
- Luôn verify signature từ MoMo
- Không tin tưởng dữ liệu từ client
- Lưu log tất cả giao dịch

## 🚀 Deploy Production

### 1. Đổi endpoint sang production
```env
MOMO_ENDPOINT=https://payment.momo.vn/v2/gateway/api/create
```

### 2. Cập nhật redirect URL
```env
MOMO_REDIRECT_URL=https://yourdomain.com/api/payment/momo-return
MOMO_IPN_URL=https://yourdomain.com/api/payment/momo-ipn
```

### 3. Cập nhật trong MoMo Developer Portal
- Đăng nhập: https://developers.momo.vn/
- Vào ứng dụng của bạn
- Cập nhật **Redirect URL** và **IPN URL**
- Lưu thay đổi

### 4. Test kỹ trước khi go-live
- Test thanh toán thành công
- Test thanh toán thất bại
- Test timeout
- Test IPN callback

## 📞 Hỗ trợ

### MoMo Support
- **Hotline**: 1900 54 54 41
- **Email**: support@momo.vn
- **Developer Portal**: https://developers.momo.vn/
- **Tài liệu API**: https://developers.momo.vn/v3/docs/payment/api/

### Các vấn đề thường gặp

#### 1. Lỗi "Invalid signature"
**Nguyên nhân**: Sai Secret Key hoặc cách tạo signature
**Giải pháp**: 
- Kiểm tra Secret Key trong `.env`
- Đảm bảo rawSignature đúng thứ tự params
- Không có khoảng trắng thừa

#### 2. Lỗi "Partner not found"
**Nguyên nhân**: Sai Partner Code
**Giải pháp**: Kiểm tra lại Partner Code trong Developer Portal

#### 3. Không redirect về sau khi thanh toán
**Nguyên nhân**: Redirect URL không đúng
**Giải pháp**: 
- Kiểm tra `MOMO_REDIRECT_URL` trong `.env`
- Đảm bảo server đang chạy
- Kiểm tra route `/api/payment/momo-return`

## ✅ Checklist

- [ ] Đăng ký tài khoản MoMo Developer
- [ ] Tạo ứng dụng mới
- [ ] Lấy Partner Code, Access Key, Secret Key
- [ ] Cập nhật `.env`
- [ ] Restart server
- [ ] Test thanh toán thành công
- [ ] Test thanh toán thất bại
- [ ] Kiểm tra database
- [ ] Kiểm tra IPN callback
- [ ] Chuẩn bị cho production

## 🎉 Kết luận

MoMo là lựa chọn tốt nhất cho thanh toán online tại Việt Nam:
- API đơn giản, dễ tích hợp
- Sandbox ổn định, không bug
- Hỗ trợ tốt, response nhanh
- Phổ biến, người dùng tin tưởng

Chúc bạn tích hợp thành công! 🚀
