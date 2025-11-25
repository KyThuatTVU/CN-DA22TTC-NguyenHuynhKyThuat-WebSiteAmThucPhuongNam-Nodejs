// Script để test API check-session
const fetch = require('node-fetch');

(async () => {
    try {
        console.log('🔍 Testing check-session API...');
        console.log('URL: http://localhost:3000/api/admin-auth/check-session');
        console.log('');

        const response = await fetch('http://localhost:3000/api/admin-auth/check-session', {
            method: 'GET',
            credentials: 'include',
            headers: {
                'Content-Type': 'application/json'
            }
        });

        const result = await response.json();
        
        console.log('📦 Response Status:', response.status);
        console.log('📦 Response Data:');
        console.log(JSON.stringify(result, null, 2));
        
        if (result.isAuthenticated && result.data) {
            console.log('');
            console.log('✅ Session active');
            console.log('👤 Admin info:');
            console.log('  - ID:', result.data.ma_admin);
            console.log('  - Tài khoản:', result.data.tai_khoan);
            console.log('  - Tên:', result.data.ten_hien_thi);
            console.log('  - Email:', result.data.email);
            console.log('  - Avatar:', result.data.anh_dai_dien || '(chưa có)');
            console.log('  - Quyền:', result.data.quyen);
        } else {
            console.log('');
            console.log('⚠️ No active session');
        }

    } catch (error) {
        console.error('❌ Error:', error.message);
    }
})();
