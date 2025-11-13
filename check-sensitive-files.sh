#!/bin/bash

# Script kiểm tra file nhạy cảm trong Git

echo "🔍 Kiểm tra file nhạy cảm trong Git..."
echo "========================================"

# Danh sách file nhạy cảm
SENSITIVE_FILES=(
    ".env"
    "backend/.env"
    "frontend/.env"
    "*.env"
    "config/secrets.js"
    "config/credentials.json"
)

echo ""
echo "📋 File đang được Git track:"
echo ""

FOUND_SENSITIVE=0

for file in "${SENSITIVE_FILES[@]}"; do
    if git ls-files | grep -q "$file"; then
        echo "❌ CẢNH BÁO: $file đang được track!"
        FOUND_SENSITIVE=1
    fi
done

if [ $FOUND_SENSITIVE -eq 0 ]; then
    echo "✅ Không tìm thấy file nhạy cảm nào được track"
fi

echo ""
echo "========================================"
echo "🔍 Kiểm tra .gitignore:"
echo ""

if [ -f .gitignore ]; then
    if grep -q ".env" .gitignore; then
        echo "✅ .gitignore có chứa .env"
    else
        echo "❌ CẢNH BÁO: .gitignore không có .env"
    fi
else
    echo "❌ CẢNH BÁO: Không tìm thấy file .gitignore"
fi

echo ""
echo "========================================"
echo "📝 Các file .env trong project:"
echo ""

find . -name ".env" -not -path "*/node_modules/*" -not -path "*/.git/*"

echo ""
echo "✅ Hoàn tất kiểm tra!"
