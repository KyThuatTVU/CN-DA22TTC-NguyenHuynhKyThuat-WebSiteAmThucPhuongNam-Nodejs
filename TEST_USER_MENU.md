# Test User Menu Display After Login

## Những thay đổi đã thực hiện:

### 1. **Cập nhật `components/navbar.html`**
- Thêm `<div id="user-menu-container">` để chứa user menu động
- Thêm `<div id="mobile-user-menu">` cho mobile menu động

### 2. **Cập nhật `js/load-components.js`**
- Thêm hàm `updateUserMenu()` để cập nhật user menu dựa trên trạng thái đăng nhập
- Hàm này kiểm tra `localStorage` để lấy thông tin user
- Nếu đã đăng nhập: hiển thị tên user, avatar, và dropdown menu
- Nếu chưa đăng nhập: hiển thị menu guest (Đăng nhập, Đăng ký)
- Thêm hàm `renderGuestMenu()` để render menu cho khách
- Thêm hàm `window.handleLogout()` để xử lý đăng xuất
- Gọi `updateUserMenu()` trong `initializeComponents()`

### 3. **Cập nhật `js/auth.js`**
- Cập nhật `updateNavbarWithUser()` để sử dụng `window.updateUserMenu()` thay vì `window.renderUserMenu()`

## Cách hoạt động:

1. **Khi tải trang:**
   - `load-components.js` load navbar từ `components/navbar.html`
   - Sau khi load xong, gọi `initializeComponents()`
   - `initializeComponents()` gọi `updateUserMenu()`
   - `updateUserMenu()` kiểm tra localStorage và render menu phù hợp

2. **Khi đăng nhập thành công:**
   - `auth.js` lưu thông tin user vào localStorage
   - Gọi `updateNavbarWithUser()` 
   - `updateNavbarWithUser()` gọi `window.updateUserMenu()`
   - User menu được cập nhật với tên và avatar của user

3. **Khi đăng xuất:**
   - `handleLogout()` xóa thông tin user khỏi localStorage
   - Chuyển hướng về trang chủ
   - Trang chủ load lại và hiển thị menu guest

## Cách test:

1. **Test khi chưa đăng nhập:**
   ```
   - Mở trang http://localhost:5500/frontend/index.html
   - Kiểm tra user icon ở navbar
   - Hover vào icon → Phải hiển thị: Đăng nhập, Đăng ký, Quản trị
   ```

2. **Test đăng nhập:**
   ```
   - Click vào "Đăng nhập"
   - Nhập email và mật khẩu
   - Sau khi đăng nhập thành công:
     + Navbar phải hiển thị username (vd: "Nguyễn Văn A")
     + Hiển thị avatar (nếu có) hoặc icon user
     + Hover vào → Hiển thị: Tên, Email, Tài khoản, Đặt bàn, Đăng xuất
   ```

3. **Test mobile menu:**
   ```
   - Thu nhỏ cửa sổ browser (< 1024px)
   - Click vào icon hamburger menu
   - Kiểm tra user menu trong mobile drawer
   ```

4. **Test đăng xuất:**
   ```
   - Click vào "Đăng xuất"
   - Confirm đăng xuất
   - Phải chuyển về trang chủ và hiển thị lại menu guest
   ```

## Debug trong Console:

Mở DevTools Console để xem log:
- `🔄 Updating user menu...` - Khi cập nhật menu
- `✅ User menu updated for: [tên user]` - Khi render thành công menu user
- `👤 No user logged in, showing guest menu` - Khi render menu guest

## Kiểm tra localStorage:

```javascript
// Trong DevTools Console:
localStorage.getItem('user')    // Phải trả về object user JSON
localStorage.getItem('token')   // Phải trả về JWT token
```

## Troubleshooting:

1. **Nếu username không hiển thị:**
   - Mở DevTools Console
   - Kiểm tra xem có log "✅ User menu updated for: ..."
   - Kiểm tra localStorage có chứa user và token không
   - Refresh lại trang

2. **Nếu có lỗi "user-menu-container not found":**
   - Kiểm tra navbar.html đã có `<div id="user-menu-container">` chưa
   - Kiểm tra component đã load xong chưa

3. **Nếu menu không cập nhật sau login:**
   - Kiểm tra auth.js có gọi `updateNavbarWithUser()` không
   - Kiểm tra timing - có thể cần tăng setTimeout delay
