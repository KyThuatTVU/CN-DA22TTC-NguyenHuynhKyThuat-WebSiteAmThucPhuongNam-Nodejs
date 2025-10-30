const db = require('../config/database');

async function updateMissingImages() {
  try {
    console.log('🔧 Cập nhật ảnh còn thiếu...\n');
    
    // Sửa tên file sai
    const updates = [
      { old: '/images/banhuyenunong.jpg', new: '/images/banhuyenuong.jpg', name: 'Bánh Huyên Ướng Nướng' },
      { old: '/images/lamammiantay.jpg', new: '/images/laumammientay.jpg', name: 'Lẩu Mắm Miền Tây' }
    ];
    
    for (const update of updates) {
      const [result] = await db.query(
        'UPDATE mon_an SET anh_mon = ? WHERE anh_mon = ?',
        [update.new, update.old]
      );
      
      if (result.affectedRows > 0) {
        console.log(`✅ ${update.name}`);
        console.log(`   ${update.old} → ${update.new}\n`);
      }
    }
    
    console.log('✅ Hoàn tất!\n');
    
    // Kiểm tra lại
    const [dishes] = await db.query('SELECT ma_mon, ten_mon, anh_mon FROM mon_an WHERE anh_mon LIKE "%/images/%"');
    console.log(`📊 Tổng số món có ảnh: ${dishes.length}/25`);
    
    process.exit(0);
  } catch (error) {
    console.error('❌ Lỗi:', error.message);
    process.exit(1);
  }
}

updateMissingImages();
