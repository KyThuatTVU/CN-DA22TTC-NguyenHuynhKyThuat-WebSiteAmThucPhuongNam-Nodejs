# Script push code lên Git an toàn

Write-Host "`n🔒 GIT SAFE PUSH SCRIPT" -ForegroundColor Cyan
Write-Host "=" * 60 -ForegroundColor Cyan

# 1. Kiểm tra file nhạy cảm
Write-Host "`n📋 Bước 1: Kiểm tra file nhạy cảm..." -ForegroundColor Yellow

$trackedFiles = git ls-files
$sensitivePatterns = @("\.env$", "node_modules", "package-lock\.json")
$foundSensitive = $false

foreach ($pattern in $sensitivePatterns) {
    $matches = $trackedFiles | Where-Object { $_ -match $pattern }
    if ($matches) {
        Write-Host "❌ CẢNH BÁO: Tìm thấy file nhạy cảm được track!" -ForegroundColor Red
        foreach ($match in $matches) {
            Write-Host "   - $match" -ForegroundColor Red
        }
        $foundSensitive = $true
    }
}

if ($foundSensitive) {
    Write-Host "`n❌ Không thể push! Vui lòng xóa file nhạy cảm trước." -ForegroundColor Red
    Write-Host "Chạy lệnh: git rm --cached <file>" -ForegroundColor Yellow
    exit 1
}

Write-Host "✅ Không có file nhạy cảm" -ForegroundColor Green

# 2. Kiểm tra git status
Write-Host "`n📋 Bước 2: Kiểm tra trạng thái Git..." -ForegroundColor Yellow
git status --short

# 3. Hỏi xác nhận
Write-Host "`n❓ Bạn có muốn tiếp tục?" -ForegroundColor Yellow
Write-Host "   1. Add tất cả file (trừ file trong .gitignore)" -ForegroundColor Cyan
Write-Host "   2. Commit với message" -ForegroundColor Cyan
Write-Host "   3. Push lên remote" -ForegroundColor Cyan
Write-Host ""
$confirm = Read-Host "Nhấn Y để tiếp tục, N để hủy (Y/N)"

if ($confirm -ne "Y" -and $confirm -ne "y") {
    Write-Host "`n❌ Đã hủy!" -ForegroundColor Red
    exit 0
}

# 4. Add files
Write-Host "`n📋 Bước 3: Add files..." -ForegroundColor Yellow
git add .

# 5. Nhập commit message
Write-Host "`n📋 Bước 4: Nhập commit message..." -ForegroundColor Yellow
$message = Read-Host "Commit message"

if ([string]::IsNullOrWhiteSpace($message)) {
    $message = "chore: update code"
}

# 6. Commit
Write-Host "`n📋 Bước 5: Commit..." -ForegroundColor Yellow
git commit -m "$message"

if ($LASTEXITCODE -ne 0) {
    Write-Host "`n❌ Commit thất bại!" -ForegroundColor Red
    exit 1
}

Write-Host "✅ Commit thành công!" -ForegroundColor Green

# 7. Push
Write-Host "`n📋 Bước 6: Push lên remote..." -ForegroundColor Yellow
$branch = git branch --show-current
Write-Host "Branch hiện tại: $branch" -ForegroundColor Cyan

git push origin $branch

if ($LASTEXITCODE -ne 0) {
    Write-Host "`n❌ Push thất bại!" -ForegroundColor Red
    Write-Host "Có thể cần pull trước: git pull origin $branch" -ForegroundColor Yellow
    exit 1
}

Write-Host "`n✅ Push thành công!" -ForegroundColor Green
Write-Host "=" * 60 -ForegroundColor Cyan
Write-Host "🎉 Hoàn tất!`n" -ForegroundColor Green
