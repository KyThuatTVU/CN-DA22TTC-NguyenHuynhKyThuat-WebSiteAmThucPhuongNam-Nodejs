#!/usr/bin/env node

/**
 * Script kiểm tra cấu hình Google OAuth
 */

require('dotenv').config();

console.log('\n🔍 KIỂM TRA CẤU HÌNH GOOGLE OAUTH\n');
console.log('='.repeat(60));

// Kiểm tra các biến môi trường
const config = {
    GOOGLE_CLIENT_ID: process.env.GOOGLE_CLIENT_ID,
    GOOGLE_CLIENT_SECRET: process.env.GOOGLE_CLIENT_SECRET,
    GOOGLE_CALLBACK_URL: process.env.GOOGLE_CALLBACK_URL,
    PORT: process.env.PORT || 3000
};

let hasError = false;

// 1. Kiểm tra Client ID
console.log('\n1️⃣  Google Client ID:');
if (!config.GOOGLE_CLIENT_ID) {
    console.log('   ❌ THIẾU - Chưa cấu hình GOOGLE_CLIENT_ID');
    hasError = true;
} else {
    console.log(`   ✅ ${config.GOOGLE_CLIENT_ID}`);
}

// 2. Kiểm tra Client Secret
console.log('\n2️⃣  Google Client Secret:');
if (!config.GOOGLE_CLIENT_SECRET) {
    console.log('   ❌ THIẾU - Chưa cấu hình GOOGLE_CLIENT_SECRET');
    hasError = true;
} else {
    const masked = config.GOOGLE_CLIENT_SECRET.substring(0, 10) + '***';
    console.log(`   ✅ ${masked}`);
}

// 3. Kiểm tra Callback URL
console.log('\n3️⃣  Google Callback URL:');
if (!config.GOOGLE_CALLBACK_URL) {
    console.log('   ❌ THIẾU - Chưa cấu hình GOOGLE_CALLBACK_URL');
    hasError = true;
} else {
    console.log(`   ✅ ${config.GOOGLE_CALLBACK_URL}`);
    
    // Kiểm tra format
    const expectedUrl = `http://localhost:${config.PORT}/api/admin-auth/google/callback`;
    if (config.GOOGLE_CALLBACK_URL !== expectedUrl) {
        console.log(`   ⚠️  URL không khớp với cấu hình server`);
        console.log(`   📌 Nên là: ${expectedUrl}`);
    }
    
    // Kiểm tra các lỗi thường gặp
    if (config.GOOGLE_CALLBACK_URL.includes('/api/admin/auth/')) {
        console.log('   ❌ LỖI: Đang dùng URL CŨ /api/admin/auth/');
        console.log('   📌 Phải đổi thành: /api/admin-auth/');
        hasError = true;
    }
    
    if (config.GOOGLE_CALLBACK_URL.endsWith('/')) {
        console.log('   ⚠️  CẢNH BÁO: URL có dấu / ở cuối (nên bỏ)');
    }
}

// 4. Kiểm tra port
console.log('\n4️⃣  Server Port:');
console.log(`   ✅ ${config.PORT}`);

// Tổng kết
console.log('\n' + '='.repeat(60));
if (hasError) {
    console.log('\n❌ CÓ LỖI - Vui lòng sửa file .env\n');
    process.exit(1);
} else {
    console.log('\n✅ CẤU HÌNH HỢP LỆ\n');
    console.log('📋 BƯỚC TIẾP THEO:');
    console.log('   1. Vào Google Cloud Console');
    console.log('   2. Thêm URL này vào "Authorized redirect URIs":');
    console.log(`      ${config.GOOGLE_CALLBACK_URL}`);
    console.log('   3. Save và đợi 1-2 phút');
    console.log('   4. Thử đăng nhập lại\n');
    console.log('🔗 Google Cloud Console:');
    console.log('   https://console.cloud.google.com/apis/credentials\n');
}
