const db = require('../config/database');

async function checkUsersTable() {
  try {
    // Kiểm tra các bảng có chứa từ "user" hoặc "nguoi"
    const [tables] = await db.query('SHOW TABLES');
    console.log('📋 Tất cả các bảng trong database:');
    console.log(tables);
    
    // Tìm bảng người dùng
    const tableKey = Object.keys(tables[0])[0];
    const tableNames = tables.map(t => t[tableKey]);
    const userTable = tableNames.find(name => 
      name.toLowerCase().includes('user') || 
      name.toLowerCase().includes('nguoi') ||
      name.toLowerCase().includes('khach')
    );
    
    if (userTable) {
      console.log(`\n✅ Tìm thấy bảng: ${userTable}`);
      
      // Lấy cấu trúc bảng
      const [structure] = await db.query(`DESCRIBE ${userTable}`);
      console.log('\n📊 Cấu trúc bảng:');
      console.table(structure);
      
      // Lấy dữ liệu mẫu
      const [sample] = await db.query(`SELECT * FROM ${userTable} LIMIT 3`);
      console.log('\n📝 Dữ liệu mẫu:');
      console.table(sample);
    } else {
      console.log('\n❌ Không tìm thấy bảng người dùng');
      console.log('Các bảng có sẵn:', tableNames);
    }
    
    process.exit(0);
  } catch (error) {
    console.error('❌ Lỗi:', error.message);
    process.exit(1);
  }
}

checkUsersTable();
