# Script tạo branch và push cho Pull Request

Write-Host "`n🌿 TẠO BRANCH CHO PULL REQUEST" -ForegroundColor Cyan
Write-Host "=" * 60 -ForegroundColor Cyan

# Lấy tên branch
Write-Host "`n📝 Nhập tên branch (hoặc Enter để dùng tên mặc định)" -ForegroundColor Yellow
Write-Host "   Ví dụ: feature/google-oauth, fix/login-bug, docs/update-readme" -ForegroundColor Gray
Write-Host ""
$branchName = Read-Host "Tên branch"

if ([string]::IsNullOrWhiteSpace($branchName)) {
    $branchName = "feature/google-oauth-implementation"
    Write-Host "   Dùng tên mặc định: $branchName" -ForegroundColor Gray
}

# Kiểm tra branch đã tồn tại chưa
$existingBranch = git branch --list $branchName

if ($existingBranch) {
    Write-Host "`n⚠️  Branch '$branchName' đã tồn tại!" -ForegroundColor Yellow
    $choice = Read-Host "Bạn muốn: [1] Dùng branch này, [2] Nhập tên khác, [3] Hủy (1/2/3)"
    
    switch ($choice) {
        "1" {
            Write-Host "   Chuyển sang branch: $branchName" -ForegroundColor Cyan
            git checkout $branchName
        }
        "2" {
            Write-Host "`n📝 Nhập tên branch mới:" -ForegroundColor Yellow
            $branchName = Read-Host "Tên branch"
            if ([string]::IsNullOrWhiteSpace($branchName)) {
                Write-Host "❌ Tên branch không được để trống!" -ForegroundColor Red
                exit 1
            }
        }
        default {
            Write-Host "❌ Đã hủy!" -ForegroundColor Red
            exit 0
        }
    }
}

# Tạo branch mới
Write-Host "`n🌿 Tạo branch mới: $branchName" -ForegroundColor Cyan
git checkout -b $branchName 2>$null

if ($LASTEXITCODE -ne 0) {
    # Branch đã tồn tại, chuyển sang branch đó
    git checkout $branchName
}

Write-Host "✅ Đang ở branch: $branchName" -ForegroundColor Green

# Kiểm tra có thay đổi nào chưa
$status = git status --short

if ([string]::IsNullOrWhiteSpace($status)) {
    Write-Host "`n📋 Không có thay đổi nào để commit" -ForegroundColor Yellow
    
    # Kiểm tra xem branch đã được push chưa
    $remoteBranch = git ls-remote --heads origin $branchName
    
    if ($remoteBranch) {
        Write-Host "✅ Branch đã tồn tại trên GitHub" -ForegroundColor Green
        
        # Lấy repo URL
        $repoUrl = git remote get-url origin
        $repoUrl = $repoUrl -replace '\.git$', ''
        $repoUrl = $repoUrl -replace 'https://github.com/', ''
        $prUrl = "https://github.com/$repoUrl/compare/$branchName"
        
        Write-Host "`n📝 Tạo Pull Request tại:" -ForegroundColor Yellow
        Write-Host $prUrl -ForegroundColor Cyan
        
        # Mở browser
        $openBrowser = Read-Host "`nMở browser? (Y/N)"
        if ($openBrowser -eq "Y" -or $openBrowser -eq "y") {
            Start-Process $prUrl
        }
    } else {
        Write-Host "⚠️  Branch chưa được push lên GitHub" -ForegroundColor Yellow
        $pushNow = Read-Host "Push ngay bây giờ? (Y/N)"
        
        if ($pushNow -eq "Y" -or $pushNow -eq "y") {
            Write-Host "`n🚀 Push branch lên GitHub..." -ForegroundColor Cyan
            git push -u origin $branchName
            
            if ($LASTEXITCODE -eq 0) {
                Write-Host "✅ Push thành công!" -ForegroundColor Green
                
                # Lấy repo URL
                $repoUrl = git remote get-url origin
                $repoUrl = $repoUrl -replace '\.git$', ''
                $repoUrl = $repoUrl -replace 'https://github.com/', ''
                $prUrl = "https://github.com/$repoUrl/compare/$branchName"
                
                Write-Host "`n📝 Tạo Pull Request tại:" -ForegroundColor Yellow
                Write-Host $prUrl -ForegroundColor Cyan
                
                Start-Process $prUrl
            } else {
                Write-Host "❌ Push thất bại!" -ForegroundColor Red
            }
        }
    }
    
    exit 0
}

# Có thay đổi, hỏi có muốn commit không
Write-Host "`n📋 Các file đã thay đổi:" -ForegroundColor Yellow
git status --short

Write-Host ""
$shouldCommit = Read-Host "Commit các thay đổi này? (Y/N)"

if ($shouldCommit -ne "Y" -and $shouldCommit -ne "y") {
    Write-Host "❌ Đã hủy!" -ForegroundColor Red
    exit 0
}

# Add files
Write-Host "`n📦 Add files..." -ForegroundColor Cyan
git add .

# Nhập commit message
Write-Host "`n📝 Nhập commit message (hoặc Enter để dùng message mặc định):" -ForegroundColor Yellow
$commitMessage = Read-Host "Message"

if ([string]::IsNullOrWhiteSpace($commitMessage)) {
    $commitMessage = "feat: implement Google OAuth authentication"
    Write-Host "   Dùng message mặc định: $commitMessage" -ForegroundColor Gray
}

# Commit
Write-Host "`n💾 Commit..." -ForegroundColor Cyan
git commit -m "$commitMessage"

if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Commit thất bại!" -ForegroundColor Red
    exit 1
}

Write-Host "✅ Commit thành công!" -ForegroundColor Green

# Push lên GitHub
Write-Host "`n🚀 Push branch lên GitHub..." -ForegroundColor Cyan
git push -u origin $branchName

if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Push thất bại!" -ForegroundColor Red
    Write-Host "Thử lại với: git push -u origin $branchName" -ForegroundColor Yellow
    exit 1
}

Write-Host "✅ Push thành công!" -ForegroundColor Green

# Hiển thị URL tạo PR
$repoUrl = git remote get-url origin
$repoUrl = $repoUrl -replace '\.git$', ''
$repoUrl = $repoUrl -replace 'https://github.com/', ''
$prUrl = "https://github.com/$repoUrl/compare/$branchName"

Write-Host "`n" + "=" * 60 -ForegroundColor Cyan
Write-Host "✅ HOÀN TẤT!" -ForegroundColor Green
Write-Host "=" * 60 -ForegroundColor Cyan

Write-Host "`n📝 Bước tiếp theo: Tạo Pull Request" -ForegroundColor Yellow
Write-Host "`n🔗 URL:" -ForegroundColor Cyan
Write-Host $prUrl -ForegroundColor White

Write-Host "`n📋 Hoặc:" -ForegroundColor Yellow
Write-Host "   1. Vào GitHub repository" -ForegroundColor Gray
Write-Host "   2. Click nút 'Compare & pull request'" -ForegroundColor Gray
Write-Host "   3. Điền title và description" -ForegroundColor Gray
Write-Host "   4. Click 'Create pull request'" -ForegroundColor Gray
Write-Host "   5. Merge Pull Request" -ForegroundColor Gray

Write-Host ""
$openBrowser = Read-Host "Mở browser để tạo Pull Request? (Y/N)"

if ($openBrowser -eq "Y" -or $openBrowser -eq "y") {
    Start-Process $prUrl
    Write-Host "`n✅ Đã mở browser!" -ForegroundColor Green
}

Write-Host "`n🎉 Done!`n" -ForegroundColor Green
