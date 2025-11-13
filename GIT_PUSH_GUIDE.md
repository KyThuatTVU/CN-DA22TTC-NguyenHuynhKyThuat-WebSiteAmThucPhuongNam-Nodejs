# 🚀 Hướng dẫn Push code lên Git/GitHub

## ✅ Đã hoàn thành

- ✅ Xóa `.env` khỏi Git tracking
- ✅ Xóa `node_modules` khỏi Git tracking
- ✅ Cập nhật `.gitignore`
- ✅ Commit thay đổi

---

## 📋 Bây giờ bạn có thể push!

### Cách 1: Push thủ công (Đơn giản)

```bash
# 1. Add tất cả file mới
git add .

# 2. Commit
git commit -m "feat: add Google OAuth and update authentication"

# 3. Push lên GitHub
git push origin main
```

### Cách 2: Dùng script tự động (Recommended)

```powershell
# Chạy script
.\git-safe-push.ps1
```

Script sẽ tự động:
- Kiểm tra file nhạy cảm
- Add files
- Hỏi commit message
- Commit và push

---

## 📝 Các file đã thay đổi

### Backend:
- ✅ `backend/server.js` - Thêm session, passport, admin-auth routes
- ✅ `backend/package.json` - Thêm dependencies mới
- ✅ `backend/.env.example` - Cập nhật callback URL
- ✅ `backend/routes/admin-auth.js` - Routes admin authentication
- ✅ `backend/config/passport.js` - Passport configuration

### Frontend:
- ✅ `frontend/admin/dang-nhap-admin.html` - Cập nhật Google OAuth URL
- ✅ `frontend/components/admin-login-modal.html` - Cập nhật URLs
- ✅ `frontend/admin/check-auth.js` - Cập nhật API endpoints

### Documentation:
- ✅ `QUICK_GIT_COMMANDS.md` - Hướng dẫn Git commands
- ✅ `GIT_IGNORE_ENV_GUIDE.md` - Hướng dẫn ignore .env
- ✅ `GOOGLE_OAUTH_FIX_STEPS.md` - Hướng dẫn sửa Google OAuth
- ✅ `backend/API_ENDPOINTS.md` - Danh sách API endpoints
- ✅ `backend/test-api.md` - Hướng dẫn test API

### Scripts:
- ✅ `git-safe-push.ps1` - Script push an toàn
- ✅ `check-sensitive-files.ps1` - Script kiểm tra file nhạy cảm
- ✅ `backend/check-oauth-config.js` - Script kiểm tra OAuth config

---

## 🔒 File KHÔNG được push

Các file này đã được ignore và KHÔNG được push lên Git:

- ❌ `backend/.env` - Chứa credentials
- ❌ `backend/node_modules/` - Dependencies (quá lớn)
- ❌ `frontend/node_modules/` - Dependencies
- ❌ `package-lock.json` - Auto-generated

---

## 🎯 Lệnh push đầy đủ

```bash
# 1. Kiểm tra trạng thái
git status

# 2. Add tất cả file (trừ file trong .gitignore)
git add .

# 3. Commit với message rõ ràng
git commit -m "feat: implement Google OAuth for admin login

- Add express-session and passport packages
- Configure Google OAuth strategy
- Update admin authentication routes
- Fix redirect URI to /api/admin-auth/google/callback
- Update frontend to use new API endpoints
- Add comprehensive documentation"

# 4. Push lên GitHub
git push origin main
```

---

## ⚠️ Nếu gặp lỗi

### Lỗi 1: "Updates were rejected"
```bash
# Pull trước, sau đó push
git pull origin main --rebase
git push origin main
```

### Lỗi 2: "Permission denied"
```bash
# Kiểm tra remote URL
git remote -v

# Nếu dùng HTTPS, có thể cần Personal Access Token
# Hoặc đổi sang SSH
```

### Lỗi 3: "Merge conflict"
```bash
# Xem file conflict
git status

# Sửa file conflict (mở file, tìm <<<<<<, ======, >>>>>>)
# Sau đó:
git add .
git commit -m "fix: resolve merge conflict"
git push origin main
```

### Lỗi 4: Vẫn thấy .env trong git status
```bash
# Xóa cache và thử lại
git rm --cached backend/.env
git add .gitignore
git commit -m "chore: remove .env from tracking"
```

---

## 📊 Kiểm tra sau khi push

### 1. Kiểm tra trên GitHub
- Vào repository trên GitHub
- Xem commit history
- Đảm bảo KHÔNG thấy file `.env`
- Đảm bảo KHÔNG thấy thư mục `node_modules`

### 2. Kiểm tra local
```bash
# Xem file được track
git ls-files | grep .env
# Không có kết quả = OK

git ls-files | grep node_modules
# Không có kết quả = OK
```

---

## 🎉 Sau khi push thành công

### Trên máy khác (hoặc teammate):

```bash
# 1. Clone repository
git clone https://github.com/username/repo.git
cd repo

# 2. Copy .env.example thành .env
cp backend/.env.example backend/.env

# 3. Điền thông tin vào .env
# (Mỗi người cần tự tạo .env riêng)

# 4. Install dependencies
cd backend
npm install

# 5. Chạy server
npm start
```

---

## 📝 Commit Message Best Practices

### Format:
```
<type>(<scope>): <subject>

<body>

<footer>
```

### Examples:
```bash
# Feature mới
git commit -m "feat(auth): add Google OAuth login for admin"

# Sửa lỗi
git commit -m "fix(auth): resolve redirect URI mismatch error"

# Documentation
git commit -m "docs: add API endpoints documentation"

# Chore (maintenance)
git commit -m "chore: remove .env from git tracking"

# Refactor
git commit -m "refactor(auth): simplify authentication logic"
```

---

## 🛡️ Security Checklist

Trước khi push, kiểm tra:

- [ ] File `.env` KHÔNG được track
- [ ] File `node_modules` KHÔNG được track
- [ ] Không có password trong code
- [ ] Không có API keys trong code
- [ ] Không có database credentials trong code
- [ ] File `.gitignore` đã được cập nhật
- [ ] Đã test code trên local
- [ ] Commit message rõ ràng

---

## 🚀 Ready to push!

Chạy lệnh này để push:

```bash
git add .
git commit -m "feat: implement Google OAuth authentication"
git push origin main
```

Hoặc dùng script:

```powershell
.\git-safe-push.ps1
```

Good luck! 🎉
