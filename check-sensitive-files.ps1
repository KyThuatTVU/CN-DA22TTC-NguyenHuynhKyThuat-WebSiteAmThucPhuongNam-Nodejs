# Script kiểm tra file nhạy cảm trong Git (PowerShell)

Write-Host "`n🔍 Kiểm tra file nhạy cảm trong Git..." -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

# Danh sách file nhạy cảm
$sensitiveFiles = @(
    ".env",
    "backend/.env",
    "frontend/.env",
    "*.env"
)

Write-Host "`n📋 File đang được Git track:" -ForegroundColor Yellow
Write-Host ""

$foundSensitive = $false
$trackedFiles = git ls-files

foreach ($file in $sensitiveFiles) {
    $pattern = $file -replace '\*', '.*'
    $matches = $trackedFiles | Where-Object { $_ -match $pattern }
    
    if ($matches) {
        Write-Host "❌ CẢNH BÁO: $file đang được track!" -ForegroundColor Red
        foreach ($match in $matches) {
            Write-Host "   - $match" -ForegroundColor Red
        }
        $foundSensitive = $true
    }
}

if (-not $foundSensitive) {
    Write-Host "✅ Không tìm thấy file nhạy cảm nào được track" -ForegroundColor Green
}

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "🔍 Kiểm tra .gitignore:" -ForegroundColor Yellow
Write-Host ""

if (Test-Path .gitignore) {
    $gitignoreContent = Get-Content .gitignore -Raw
    if ($gitignoreContent -match "\.env") {
        Write-Host "✅ .gitignore có chứa .env" -ForegroundColor Green
    } else {
        Write-Host "❌ CẢNH BÁO: .gitignore không có .env" -ForegroundColor Red
    }
} else {
    Write-Host "❌ CẢNH BÁO: Không tìm thấy file .gitignore" -ForegroundColor Red
}

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "📝 Các file .env trong project:" -ForegroundColor Yellow
Write-Host ""

$envFiles = Get-ChildItem -Path . -Filter ".env" -Recurse -File -ErrorAction SilentlyContinue | 
    Where-Object { $_.FullName -notmatch "node_modules" -and $_.FullName -notmatch "\.git" }

if ($envFiles) {
    foreach ($file in $envFiles) {
        $relativePath = $file.FullName.Replace((Get-Location).Path, ".")
        Write-Host "   📄 $relativePath" -ForegroundColor Cyan
    }
} else {
    Write-Host "   (Không tìm thấy file .env nào)" -ForegroundColor Gray
}

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "✅ Hoàn tất kiểm tra!`n" -ForegroundColor Green
