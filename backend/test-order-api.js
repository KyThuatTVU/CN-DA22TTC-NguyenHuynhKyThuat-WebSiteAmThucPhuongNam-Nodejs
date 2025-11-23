const fetch = require('node-fetch');

// Get token from localStorage (you need to replace this with actual token)
const token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJtYV9uZ3VvaV9kdW5nIjo2LCJlbWFpbCI6ImhvbGVxdWFuZ3ZpbmgwNDA0QGdtYWlsLmNvbSIsImlhdCI6MTczNzYxNTc5NywiZXhwIjoxNzM4MjIwNTk3fQ.Ql8vZQqYPqLqYqLqYqLqYqLqYqLqYqLqYqLqYqLqYqI';

async function testOrderAPI() {
    try {
        console.log('🧪 Testing Order API...\n');
        
        const response = await fetch('http://localhost:3000/api/orders/38', {
            headers: {
                'Authorization': `Bearer ${token}`
            }
        });
        
        console.log('Status:', response.status);
        
        const data = await response.json();
        console.log('\n📦 Response:');
        console.log(JSON.stringify(data, null, 2));
        
        if (data.success && data.data) {
            console.log('\n💰 Tổng tiền:');
            console.log('- Tạm tính:', data.data.tong_tien_hang);
            console.log('- Phí ship:', data.data.phi_van_chuyen);
            console.log('- Giảm giá:', data.data.tien_giam_gia);
            console.log('- TỔNG CỘNG:', data.data.tong_thanh_toan);
        }
        
    } catch (error) {
        console.error('❌ Error:', error.message);
    }
    
    process.exit(0);
}

testOrderAPI();
