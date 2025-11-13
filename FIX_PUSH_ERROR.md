# 🔧 Sửa lỗi "push declined due to repository rule violations"

## ❌ Lỗi

```
! [remote rejected] main -> main (push declined due to repository rule violations)
error: failed to push some refs
```

## 🔍 Nguyên nhân

Repository trên GitHub có **Branch Protection Rules** cho branch `main`:
- Yêu cầu Pull Request
- Yêu cầu review
- Không cho phép push trực tiếp

---

## ✅ Giải pháp

### Cách 1: Tạo Pull Request (Recommended)

#### Bước 1: Tạo branch mới
```bash
# Tạo branch mới từ main hiện tại
git checkout -b feature/google-oauth-auth

# Push branch mới lên GitHub
git push origin feature/google-oauth-auth
```

#### Bước 2: Tạo Pull Request trên GitHub
1. Vào repository trên GitHub
2. Click nút **"Compare & pull request"**
3. Điền title và description
4. Click **"Create pull request"**
5. Merge Pull Request (nếu bạn là owner)

---

### Cách 2: Tắt Branch Protection (Nếu bạn là owner)

#### Bước 1: Vào GitHub Settings
1. Vào repository: https://github.com/KyThuatTVU/CN-DA22TTC-NguyenHuynhKyThuat-WebSiteAmThucPhuongNam-Nodejs
2. Click **Settings** (tab trên cùng)
3. Click **Branches** (menu bên trái)

#### Bước 2: Tắt Protection Rules
1. Tìm **Branch protection rules**
2. Tìm rule cho branch `main`
3. Click **Edit** hoặc **Delete**
4. Bỏ check các options hoặc xóa rule
5. Click **Save changes**

#### Bước 3: Push lại
```bash
git push origin main
```

#### Bước 4: Bật lại Protection (Optional)
Sau khi push xong, có thể bật lại protection rules

---

### Cách 3: Force Push (Không khuyến khích)

⚠️ **CẢNH BÁO**: Chỉ dùng nếu bạn chắc chắn và là owner duy nhất!

```bash
git push -f origin main
```

**Lưu ý**: Force push có thể ghi đè lịch sử commit trên remote!

---

## 🎯 Khuyến nghị: Dùng Cách 1 (Pull Request)

### Lệnh đầy đủ:

```bash
# 1. Tạo branch mới
git checkout -b feature/google-oauth-implementation

# 2. Push branch lên GitHub
git push origin feature/google-oauth-implementation

# 3. Vào GitHub tạo Pull Request
# URL: https://github.com/KyThuatTVU/CN-DA22TTC-NguyenHuynhKyThuat-WebSiteAmThucPhuongNam-Nodejs/compare

# 4. Sau khi merge, pull về local
git checkout main
git pull origin main

# 5. Xóa branch cũ
git branch -d feature/google-oauth-implementation
```

---

## 📋 Chi tiết từng bước

### Bước 1: Tạo và push branch mới

```bash
# Đảm bảo đang ở branch main
git branch

# Tạo branch mới
git checkout -b feature/google-oauth-implementation

# Kiểm tra branch hiện tại
git branch
# * feature/google-oauth-implementation
#   main

# Push branch mới lên GitHub
git push origin feature/google-oauth-implementation
```

### Bước 2: Tạo Pull Request trên GitHub

1. Mở browser, vào:
   ```
   https://github.com/KyThuatTVU/CN-DA22TTC-NguyenHuynhKyThuat-WebSiteAmThucPhuongNam-Nodejs
   ```

2. Bạn sẽ thấy banner màu vàng:
   ```
   feature/google-oauth-implementation had recent pushes
   [Compare & pull request]
   ```

3. Click **"Compare & pull request"**

4. Điền thông tin:
   ```
   Title: Implement Google OAuth Authentication for Admin
   
   Description:
   ## Changes
   - Add Google OAuth login for admin
   - Configure passport and express-session
   - Update admin authentication routes
   - Fix redirect URI to /api/admin-auth/google/callback
   - Update frontend to use new API endpoints
   - Remove sensitive files from git tracking
   
   ## Testing
   - Tested Google OAuth flow
   - Verified session management
   - Confirmed .env is not tracked
   
   ## Documentation
   - Added API endpoints documentation
   - Added OAuth setup guide
   - Added Git commands guide
   ```

5. Click **"Create pull request"**

6. Nếu bạn là owner, click **"Merge pull request"** → **"Confirm merge"**

### Bước 3: Pull về local và cleanup

```bash
# Chuyển về branch main
git checkout main

# Pull changes từ GitHub
git pull origin main

# Xóa branch local
git branch -d feature/google-oauth-implementation

# Xóa branch remote (optional)
git push origin --delete feature/google-oauth-implementation
```

---

## 🔍 Kiểm tra Branch Protection Rules

### Xem rules hiện tại:

1. Vào: https://github.com/KyThuatTVU/CN-DA22TTC-NguyenHuynhKyThuat-WebSiteAmThucPhuongNam-Nodejs/settings/branches

2. Xem các rules đang bật:
   - ☑️ Require a pull request before merging
   - ☑️ Require approvals
   - ☑️ Require status checks to pass
   - ☑️ Require conversation resolution before merging
   - ☑️ Require signed commits
   - ☑️ Require linear history
   - ☑️ Include administrators

---

## 🛠️ Script tự động

Tạo file `create-pr-branch.ps1`:

```powershell
# Script tạo branch và push cho Pull Request

$branchName = Read-Host "Nhập tên branch (vd: feature/new-feature)"

if ([string]::IsNullOrWhiteSpace($branchName)) {
    Write-Host "❌ Tên branch không được để trống!" -ForegroundColor Red
    exit 1
}

Write-Host "`n🌿 Tạo branch mới: $branchName" -ForegroundColor Cyan

# Tạo branch mới
git checkout -b $branchName

if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Không thể tạo branch!" -ForegroundColor Red
    exit 1
}

Write-Host "✅ Đã tạo branch: $branchName" -ForegroundColor Green

# Push lên GitHub
Write-Host "`n🚀 Push branch lên GitHub..." -ForegroundColor Cyan
git push origin $branchName

if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Push thất bại!" -ForegroundColor Red
    exit 1
}

Write-Host "✅ Push thành công!" -ForegroundColor Green

# Hiển thị URL tạo PR
$repoUrl = git remote get-url origin
$repoUrl = $repoUrl -replace '\.git$', ''
$prUrl = "$repoUrl/compare/$branchName"

Write-Host "`n📝 Tạo Pull Request tại:" -ForegroundColor Yellow
Write-Host $prUrl -ForegroundColor Cyan
Write-Host ""
```

Chạy script:
```powershell
.\create-pr-branch.ps1
```

---

## ✅ Tóm tắt

### Nếu repository có Branch Protection:
1. ✅ Tạo branch mới
2. ✅ Push branch lên GitHub
3. ✅ Tạo Pull Request
4. ✅ Merge Pull Request
5. ✅ Pull về local

### Nếu muốn push trực tiếp:
1. ✅ Tắt Branch Protection Rules
2. ✅ Push
3. ✅ Bật lại Protection (optional)

---

## 🎯 Lệnh nhanh

```bash
# Tạo branch và push
git checkout -b feature/google-oauth
git push origin feature/google-oauth

# Sau khi merge PR trên GitHub
git checkout main
git pull origin main
git branch -d feature/google-oauth
```

Good luck! 🚀
