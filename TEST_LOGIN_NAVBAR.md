# 🧪 TEST NAVBAR LOGIN - HƯỚNG DẪN

## 🎯 Kiểm tra nhanh:

### Bước 1: Mở Console
```
Nhấn F12 → Tab Console
```

### Bước 2: Kiểm tra localStorage
```javascript
// Copy và paste vào Console:
console.log('User:', localStorage.getItem('user'));
console.log('Token:', localStorage.getItem('token'));
```

**Kết quả mong đợi:**
- Nếu đã đăng nhập: Sẽ thấy thông tin user và token
- Nếu chưa đăng nhập: Sẽ thấy `null`

### Bước 3: Kiểm tra function
```javascript
// Copy và paste vào Console:
console.log('renderUserMenu:', typeof window.renderUserMenu);
```

**Kết quả mong đợi:** `"function"`

### Bước 4: Force render navbar
```javascript
// Copy và paste vào Console:
window.renderUserMenu();
```

**Kết quả:** Navbar sẽ cập nhật ngay lập tức!

---

## 🔧 Nếu vẫn không hiển thị:

### Test 1: Kiểm tra container
```javascript
// Copy và paste vào Console:
console.log('Container:', document.getElementById('user-menu-container'));
```

**Nếu null:** Navbar chưa load xong, đợi 1 giây rồi chạy lại

### Test 2: Xem log
```javascript
// Navbar sẽ tự động log khi render
// Xem trong Console có thấy:
// 🔄 renderUserMenu() called
// ✅ User menu rendered for: [Tên]
```

### Test 3: Manual login test
```javascript
// Tạo user test:
localStorage.setItem('user', JSON.stringify({
    ma_nguoi_dung: 1,
    ten_nguoi_dung: 'Test User',
    email: 'test@example.com',
    anh_dai_dien: null
}));
localStorage.setItem('token', 'test-token-123');

// Render lại:
window.renderUserMenu();
```

---

## ✅ Giải pháp nhanh:

### Thêm vào cuối trang HTML (trước </body>):
```html
<script>
// Auto refresh navbar after login
window.addEventListener('load', function() {
    setTimeout(function() {
        if (typeof window.renderUserMenu === 'function') {
            window.renderUserMenu();
            console.log('✅ Navbar auto-refreshed');
        }
    }, 1000);
});
</script>
```

---

## 🎯 Test đầy đủ:

### 1. Đăng nhập
```
1. Mở: frontend/dang-nhap.html
2. Đăng nhập với tài khoản
3. Sau khi chuyển về trang chủ
4. Mở Console (F12)
5. Xem có log: "✅ User menu rendered for: [Tên]"
```

### 2. Kiểm tra navbar
```
1. Nhìn lên navbar (góc phải)
2. Phải thấy: [Avatar/Icon] [Tên] [▼]
3. Click vào → Thấy dropdown menu
```

### 3. Nếu không thấy
```
1. Mở Console
2. Gõ: window.renderUserMenu()
3. Nhấn Enter
4. Navbar sẽ cập nhật ngay!
```

---

## 📋 Checklist Debug:

- [ ] Console không có lỗi màu đỏ
- [ ] localStorage có `user` và `token`
- [ ] `window.renderUserMenu` là function
- [ ] `user-menu-container` tồn tại trong DOM
- [ ] Thấy log "🔄 renderUserMenu() called"
- [ ] Thấy log "✅ User menu rendered"

---

## 🚀 Quick Fix:

**Nếu đã đăng nhập nhưng navbar không hiển thị:**

```javascript
// Chạy trong Console:
window.renderUserMenu();
```

**Hoặc refresh trang:**
```
Ctrl + F5 (Windows)
Cmd + Shift + R (Mac)
```

---

**Hãy thử và báo kết quả nhé!** 🎉
