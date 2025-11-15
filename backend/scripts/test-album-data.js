const db = require('../config/database');

async function testAlbumAPI() {
    try {
        console.log('🔍 Testing Album API - Lấy dữ liệu từ database...\n');
        
        // Test 1: Lấy tất cả album
        console.log('📋 TEST 1: Lấy tất cả album');
        console.log('━'.repeat(70));
        const [allAlbums] = await db.query('SELECT * FROM album_anh ORDER BY ngay_tao DESC LIMIT 10');
        console.log(`✅ Tìm thấy ${allAlbums.length} album`);
        allAlbums.forEach((album, index) => {
            console.log(`${index + 1}. [${album.loai_anh}] ${album.mo_ta}`);
        });
        
        // Test 2: Lấy theo loại món ăn
        console.log('\n📋 TEST 2: Lấy album món ăn');
        console.log('━'.repeat(70));
        const [monAn] = await db.query('SELECT * FROM album_anh WHERE loai_anh = ?', ['mon_an']);
        console.log(`✅ Có ${monAn.length} ảnh món ăn`);
        monAn.slice(0, 3).forEach(album => {
            console.log(`   - ${album.mo_ta}`);
        });
        
        // Test 3: Lấy theo loại không gian
        console.log('\n📋 TEST 3: Lấy album không gian');
        console.log('━'.repeat(70));
        const [khongGian] = await db.query('SELECT * FROM album_anh WHERE loai_anh = ?', ['khong_gian']);
        console.log(`✅ Có ${khongGian.length} ảnh không gian`);
        khongGian.slice(0, 3).forEach(album => {
            console.log(`   - ${album.mo_ta}`);
        });
        
        // Test 4: Thống kê theo loại
        console.log('\n📊 TEST 4: Thống kê album theo loại');
        console.log('━'.repeat(70));
        const [stats] = await db.query(`
            SELECT loai_anh, COUNT(*) as so_luong 
            FROM album_anh 
            GROUP BY loai_anh 
            ORDER BY so_luong DESC
        `);
        
        const categoryNames = {
            'mon_an': 'Món ăn',
            'khong_gian': 'Không gian',
            'su_kien': 'Sự kiện',
            'khach_hang': 'Khách hàng',
            'khong_ro': 'Khác'
        };
        
        stats.forEach(stat => {
            const name = categoryNames[stat.loai_anh] || stat.loai_anh;
            console.log(`   ${name}: ${stat.so_luong} ảnh`);
        });
        
        // Test 5: Kiểm tra API endpoint format
        console.log('\n🌐 TEST 5: Format dữ liệu API');
        console.log('━'.repeat(70));
        const [albums] = await db.query('SELECT * FROM album_anh LIMIT 3');
        const apiResponse = {
            success: true,
            data: albums.map(album => ({
                ma_album: album.ma_album,
                duong_dan_anh: album.duong_dan_anh,
                loai_anh: album.loai_anh,
                mo_ta: album.mo_ta,
                ngay_tao: album.ngay_tao
            })),
            pagination: {
                page: 1,
                limit: 12,
                total: allAlbums.length,
                totalPages: Math.ceil(allAlbums.length / 12)
            }
        };
        
        console.log('✅ API Response Format:');
        console.log(JSON.stringify(apiResponse, null, 2));
        
        console.log('\n✅ TẤT CẢ TESTS HOÀN THÀNH!');
        console.log('━'.repeat(70));
        console.log('📌 Dữ liệu đã sẵn sàng cho API:');
        console.log('   GET /api/albums - Lấy tất cả album');
        console.log('   GET /api/albums/category/mon_an - Lấy album món ăn');
        console.log('   GET /api/albums/category/khong_gian - Lấy album không gian');
        console.log('   GET /api/albums/categories/list - Thống kê');
        
    } catch (error) {
        console.error('❌ LỖI:', error.message);
        console.error(error);
    } finally {
        process.exit();
    }
}

testAlbumAPI();
