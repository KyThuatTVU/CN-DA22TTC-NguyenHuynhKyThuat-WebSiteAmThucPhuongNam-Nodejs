const db = require('../config/database');
const fs = require('fs');
const path = require('path');

async function checkImages() {
  try {
    console.log('🔍 Kiểm tra hình ảnh món ăn...\n');
    
    // Lấy danh sách món ăn
    const [dishes] = await db.query('SELECT ma_mon, ten_mon, anh_mon FROM mon_an LIMIT 10');
    
    console.log('📋 Đường dẫn ảnh trong database:');
    dishes.forEach(dish => {
      console.log(`   ${dish.ma_mon}. ${dish.ten_mon}`);
      console.log(`      DB: ${dish.anh_mon}`);
      
      // Kiểm tra file có tồn tại không
      if (dish.anh_mon) {
        const imagePath = dish.anh_mon.replace('/images/', '');
        const fullPath = path.join(__dirname, '../images', imagePath);
        const exists = fs.existsSync(fullPath);
        console.log(`      File: ${exists ? '✅ Tồn tại' : '❌ Không tồn tại'} - ${fullPath}`);
      }
      console.log('');
    });
    
    // Kiểm tra thư mục images
    console.log('\n📁 Các file trong thư mục backend/images:');
    const imagesDir = path.join(__dirname, '../images');
    const files = fs.readdirSync(imagesDir);
    console.log(`   Tổng số file: ${files.length}`);
    files.slice(0, 10).forEach(file => {
      console.log(`   - ${file}`);
    });
    
    process.exit(0);
  } catch (error) {
    console.error('❌ Lỗi:', error.message);
    process.exit(1);
  }
}

checkImages();
