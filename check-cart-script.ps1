# PowerShell script to check which HTML files are missing cart.js

Write-Host "🔍 Checking HTML files for cart.js inclusion..." -ForegroundColor Cyan
Write-Host ""

$htmlFiles = Get-ChildItem -Path "frontend\*.html" -Exclude "test-*.html", "debug-*.html", "navbar-*.html", "userflow.html", "export-*.html"

$missingCart = @()
$hasCart = @()

foreach ($file in $htmlFiles) {
    $content = Get-Content $file.FullName -Raw
    
    # Check if file has cart.js
    if ($content -match 'cart\.js') {
        $hasCart += $file.Name
        Write-Host "✅ $($file.Name)" -ForegroundColor Green
    } else {
        # Check if file has navbar (likely needs cart.js)
        if ($content -match 'navbar-container') {
            $missingCart += $file.Name
            Write-Host "❌ $($file.Name) - HAS NAVBAR but MISSING cart.js" -ForegroundColor Red
        } else {
            Write-Host "⚪ $($file.Name) - No navbar" -ForegroundColor Gray
        }
    }
}

Write-Host ""
Write-Host "=" * 60 -ForegroundColor Yellow
Write-Host "📊 SUMMARY:" -ForegroundColor Yellow
Write-Host "=" * 60 -ForegroundColor Yellow
Write-Host "✅ Files with cart.js: $($hasCart.Count)" -ForegroundColor Green
Write-Host "❌ Files missing cart.js (but have navbar): $($missingCart.Count)" -ForegroundColor Red

if ($missingCart.Count -gt 0) {
    Write-Host ""
    Write-Host "⚠️  Files that need cart.js added:" -ForegroundColor Yellow
    foreach ($file in $missingCart) {
        Write-Host "   - $file" -ForegroundColor Red
    }
}
