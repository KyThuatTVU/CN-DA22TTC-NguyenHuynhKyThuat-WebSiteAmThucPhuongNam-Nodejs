const db = require('../config/database');
const fs = require('fs');
const path = require('path');

async function fixImagePaths() {
  try {
    console.log('🔧 Đang sửa đường dẫn hình ảnh...\n');
    
    // Lấy tất cả món ăn
    const [dishes] = await db.query('SELECT ma_mon, ten_mon, anh_mon FROM mon_an');
    
    // Lấy danh sách file thực tế
    const imagesDir = path.join(__dirname, '../images');
    const actualFiles = fs.readdirSync(imagesDir).map(f => f.toLowerCase());
    
    let fixed = 0;
    let notFound = 0;
    
    for (const dish of dishes) {
      if (!dish.anh_mon) continue;
      
      const dbImagePath = dish.anh_mon.replace('/images/', '');
      const fullPath = path.join(imagesDir, dbImagePath);
      
      // Nếu file không tồn tại, tìm file tương tự
      if (!fs.existsSync(fullPath)) {
        const fileName = path.basename(dbImagePath).toLowerCase();
        
        // Tìm file có tên gần giống
        const similarFile = actualFiles.find(f => {
          const similarity = f.includes(fileName.slice(0, -4)) || fileName.includes(f.slice(0, -4));
          return similarity;
        });
        
        if (similarFile) {
          const newPath = `/images/${similarFile}`;
          await db.query('UPDATE mon_an SET anh_mon = ? WHERE ma_mon = ?', [newPath, dish.ma_mon]);
          console.log(`✅ ${dish.ten_mon}`);
          console.log(`   Cũ: ${dish.anh_mon}`);
          console.log(`   Mới: ${newPath}\n`);
          fixed++;
        } else {
          console.log(`❌ Không tìm thấy ảnh cho: ${dish.ten_mon} (${dbImagePath})\n`);
          notFound++;
        }
      }
    }
    
    console.log(`\n📊 Kết quả:`);
    console.log(`   ✅ Đã sửa: ${fixed} món`);
    console.log(`   ❌ Không tìm thấy: ${notFound} món`);
    
    process.exit(0);
  } catch (error) {
    console.error('❌ Lỗi:', error.message);
    process.exit(1);
  }
}

fixImagePaths();
