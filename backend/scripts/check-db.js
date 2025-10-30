const db = require('../config/database');

async function checkDatabase() {
  try {
    console.log('🔍 Đang kiểm tra kết nối database...\n');
    
    // Kiểm tra kết nối
    const [connection] = await db.query('SELECT DATABASE() as db_name');
    console.log('✅ Kết nối thành công!');
    console.log('📊 Database hiện tại:', connection[0].db_name);
    console.log('');
    
    // Lấy danh sách bảng
    const [tables] = await db.query('SHOW TABLES');
    console.log('📋 Các bảng trong database:');
    tables.forEach((table, index) => {
      const tableName = Object.values(table)[0];
      console.log(`   ${index + 1}. ${tableName}`);
    });
    console.log('');
    
    // Đếm số lượng records trong mỗi bảng
    console.log('📊 Số lượng dữ liệu:');
    for (const table of tables) {
      const tableName = Object.values(table)[0];
      const [count] = await db.query(`SELECT COUNT(*) as total FROM ${tableName}`);
      console.log(`   ${tableName}: ${count[0].total} records`);
    }
    
    process.exit(0);
  } catch (error) {
    console.error('❌ Lỗi:', error.message);
    console.error('Chi tiết:', error);
    process.exit(1);
  }
}

checkDatabase();
