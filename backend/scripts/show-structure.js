const db = require('../config/database');

async function showStructure() {
  try {
    const tables = ['danh_muc', 'mon_an', 'album_anh', 'anh_san_pham'];
    
    for (const table of tables) {
      console.log(`\n📋 Cấu trúc bảng: ${table}`);
      console.log('='.repeat(50));
      const [columns] = await db.query(`DESCRIBE ${table}`);
      columns.forEach(col => {
        console.log(`   ${col.Field} (${col.Type}) ${col.Key ? '[' + col.Key + ']' : ''}`);
      });
    }
    
    process.exit(0);
  } catch (error) {
    console.error('❌ Lỗi:', error.message);
    process.exit(1);
  }
}

showStructure();
