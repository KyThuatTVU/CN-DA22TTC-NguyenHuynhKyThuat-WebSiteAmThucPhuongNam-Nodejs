const mysql = require('mysql2/promise');

async function checkDatabase() {
    let connection;
    try {
        console.log('🔌 Đang kết nối MySQL...');
        
        // Kết nối trực tiếp với thông tin từ .env
        connection = await mysql.createConnection({
            host: 'localhost',
            user: 'root',
            password: 'TVU@842004',
            database: 'amthuc_phuongnam',
            port: 3306
        });
        
        console.log('✅ Kết nối thành công!\n');
        
        // Kiểm tra database hiện tại
        const [dbResult] = await connection.query('SELECT DATABASE() as db_name');
        console.log('📁 Database:', dbResult[0].db_name);
        
        // Liệt kê tất cả các bảng
        const [tables] = await connection.query('SHOW TABLES');
        console.log('\n📋 DANH SÁCH CÁC BẢNG:');
        console.log('━'.repeat(50));
        
        let hasAlbum = false;
        tables.forEach((table, index) => {
            const tableName = Object.values(table)[0];
            if (tableName === 'album_anh') {
                console.log(`${index + 1}. ${tableName} ⭐ <-- BẢNG NÀY`);
                hasAlbum = true;
            } else {
                console.log(`${index + 1}. ${tableName}`);
            }
        });
        
        console.log('━'.repeat(50));
        console.log(`Tổng số: ${tables.length} bảng\n`);
        
        // Kiểm tra chi tiết bảng album_anh
        if (hasAlbum) {
            console.log('✅ Bảng album_anh TỒN TẠI\n');
            
            // Cấu trúc bảng
            const [structure] = await connection.query('DESCRIBE album_anh');
            console.log('🔧 CẤU TRÚC BẢNG album_anh:');
            console.log('━'.repeat(70));
            structure.forEach(col => {
                console.log(`${col.Field.padEnd(20)} | ${col.Type.padEnd(20)} | ${col.Null === 'NO' ? 'NOT NULL' : 'NULL    '} | ${col.Key}`);
            });
            console.log('━'.repeat(70));
            
            // Đếm số dòng
            const [count] = await connection.query('SELECT COUNT(*) as total FROM album_anh');
            console.log(`\n📊 Số lượng dòng dữ liệu: ${count[0].total}`);
            
            // Lấy 5 dòng đầu
            const [rows] = await connection.query('SELECT * FROM album_anh LIMIT 5');
            console.log('\n📸 5 DÒNG DỮ LIỆU ĐẦU TIÊN:');
            console.log('━'.repeat(70));
            rows.forEach(row => {
                console.log(`ID: ${row.ma_album} | Loại: ${row.loai_anh} | Mô tả: ${row.mo_ta}`);
            });
            console.log('━'.repeat(70));
            
        } else {
            console.log('❌ Bảng album_anh KHÔNG TỒN TẠI trong database!');
            console.log('\n💡 Giải pháp:');
            console.log('   1. Import file init.sql vào MySQL');
            console.log('   2. Hoặc tạo bảng thủ công từ init.sql');
        }
        
    } catch (error) {
        console.error('\n❌ LỖI:', error.message);
        console.error('Code lỗi:', error.code);
        
        if (error.code === 'ER_ACCESS_DENIED_ERROR') {
            console.log('\n💡 Lỗi quyền truy cập - Kiểm tra lại:');
            console.log('   - Username: root');
            console.log('   - Password: TVU@842004');
        } else if (error.code === 'ER_BAD_DB_ERROR') {
            console.log('\n💡 Database không tồn tại!');
            console.log('   - Tạo database: CREATE DATABASE amthuc_phuongnam;');
        }
        
    } finally {
        if (connection) {
            await connection.end();
            console.log('\n🔌 Đã đóng kết nối MySQL');
        }
        process.exit();
    }
}

checkDatabase();
