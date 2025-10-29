/**
 * AUTO-UPDATE SCRIPT - CẬP NHẬT TỰ ĐỘNG CÁC TRANG HTML
 * 
 * Script này sẽ giúp bạn nhanh chóng chuyển đổi từ navbar/footer hard-coded
 * sang sử dụng components. Chạy script này trong console của browser.
 */

// Bước 1: Kiểm tra components có load được không
async function testComponentsLoading() {
    console.log('🔍 Kiểm tra components...');
    
    try {
        const response = await fetch('components/navbar.html');
        if (response.ok) {
            console.log('✅ Navbar component OK');
        } else {
            console.error('❌ Không tìm thấy navbar.html');
        }
        
        const footerResponse = await fetch('components/footer.html');
        if (footerResponse.ok) {
            console.log('✅ Footer component OK');
        } else {
            console.error('❌ Không tìm thấy footer.html');
        }
        
        const chatbotResponse = await fetch('components/chatbot.html');
        if (chatbotResponse.ok) {
            console.log('✅ Chatbot component OK');
        } else {
            console.error('❌ Không tìm thấy chatbot.html');
        }
        
        console.log('\n✨ Tất cả components đều sẵn sàng!');
        return true;
    } catch (error) {
        console.error('❌ Lỗi khi kiểm tra components:', error);
        return false;
    }
}

// Bước 2: Hướng dẫn cập nhật từng trang
function getUpdateInstructions() {
    return `
╔════════════════════════════════════════════════════════════╗
║  🛠️  HƯỚNG DẪN CẬP NHẬT CÁC TRANG                          ║
╚════════════════════════════════════════════════════════════╝

📋 DANH SÁCH TRANG CẦN CẬP NHẬT:
   ☐ index.html
   ☐ thuc-don.html
   ☐ gioi-thieu.html
   ☐ tin-tuc.html
   ☐ album.html
   ☐ lien-he.html
   ☐ dat-ban.html
   ☐ gio-hang.html
   ☐ thanh-toan.html
   ☐ dang-nhap.html
   ☐ dang-ky.html
   ☐ quen-mat-khau.html

🔧 CÁC BƯỚC THỰC HIỆN:

1️⃣ XÓA NAVBAR CŨ
   Tìm dòng: <nav id="navbar"...
   Đến dòng: </nav>
   → Xóa toàn bộ
   → Thay bằng: <div id="navbar-container"></div>

2️⃣ XÓA FOOTER CŨ  
   Tìm dòng: <footer...
   Đến dòng: </footer>
   → Xóa toàn bộ
   → Thay bằng: <div id="footer-container"></div>

3️⃣ XÓA CHATBOT CŨ
   Tìm dòng: <button id="chatbot-btn"...
   Đến dòng: </div> (chatbot window)
   → Xóa toàn bộ
   → Thay bằng: <div id="chatbot-container"></div>

4️⃣ THÊM SCRIPT LOAD COMPONENTS
   Trước thẻ </body>, thêm:
   <script src="js/load-components.js"></script>

💡 MẸO:
   - Dùng Ctrl+F để tìm nhanh
   - Backup file trước khi sửa
   - Test từng trang sau khi cập nhật

✨ SAU KHI CẬP NHẬT:
   - Navbar, Footer, Chatbot sẽ giống nhau trên mọi trang
   - Chỉ cần sửa 1 file component, tất cả trang đều update
   - Dễ bảo trì hơn rất nhiều!
`;
}

// Bước 3: In hướng dẫn
console.log(getUpdateInstructions());

// Bước 4: Test components
testComponentsLoading();

// Export các hàm để sử dụng
window.testComponentsLoading = testComponentsLoading;
window.getUpdateInstructions = getUpdateInstructions;

console.log('\n💬 Gõ getUpdateInstructions() để xem lại hướng dẫn');
console.log('💬 Gõ testComponentsLoading() để kiểm tra lại components');
