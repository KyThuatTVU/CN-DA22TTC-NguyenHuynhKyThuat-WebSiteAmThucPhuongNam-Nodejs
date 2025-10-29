// Dữ liệu tin tức mẫu cho 4 bài viết
const newsData = {
    1: {
        title: "Khai Trương Chi Nhánh Mới Tại Vĩnh Long",
        date: "10 Tháng 10, 2025",
        views: "1,234",
        image: "images/tt2.jpg",
        content: `
            <p class="text-lg text-gray-700 leading-relaxed mb-6">
                Chúng tôi vô cùng vui mừng và tự hào thông báo về sự kiện khai trương chi nhánh thứ 5 
                của Nhà hàng Phương Nam tại trung tâm thành phố Vĩnh Long. Đây là một cột mốc quan trọng 
                trong hành trình phát triển của chúng tôi.
            </p>

            <h2 class="text-2xl font-bold text-gray-800 mb-4 mt-8">Không Gian Hiện Đại & Sang Trọng</h2>
            <p class="text-gray-700 leading-relaxed mb-6">
                Chi nhánh mới được thiết kế với không gian rộng rãi lên đến 500m², có thể phục vụ 
                đồng thời 200 thực khách. Nội thất được chọn lọc kỹ lưỡng, kết hợp giữa phong cách 
                hiện đại và nét truyền thống miền Tây Nam Bộ.
            </p>

            <div class="bg-orange-50 border-l-4 border-orange-600 p-6 my-8 rounded-r-lg">
                <p class="text-gray-700 italic">
                    "Chúng tôi luôn đặt sự hài lòng của khách hàng lên hàng đầu. Chi nhánh mới không 
                    chỉ là nơi thưởng thức ẩm thực mà còn là không gian để gia đình, bạn bè sum họp."
                </p>
                <p class="text-orange-600 font-semibold mt-2">- Ông Nguyễn Văn A, Giám đốc điều hành</p>
            </div>

            <h2 class="text-2xl font-bold text-gray-800 mb-4 mt-8">Ưu Đãi Khai Trương Đặc Biệt</h2>
            <div class="bg-gradient-to-r from-orange-100 to-red-100 p-6 rounded-lg mb-6">
                <h3 class="text-xl font-bold text-orange-600 mb-4">🎉 Chương trình khuyến mãi:</h3>
                <ul class="space-y-3 text-gray-700">
                    <li class="flex items-start">
                        <i class="fas fa-check-circle text-orange-600 mt-1 mr-3"></i>
                        <span><strong>Giảm 30%</strong> cho tất cả món ăn trong tuần đầu tiên</span>
                    </li>
                    <li class="flex items-start">
                        <i class="fas fa-check-circle text-orange-600 mt-1 mr-3"></i>
                        <span><strong>Tặng voucher 200.000đ</strong> cho 100 khách hàng đầu tiên</span>
                    </li>
                    <li class="flex items-start">
                        <i class="fas fa-check-circle text-orange-600 mt-1 mr-3"></i>
                        <span><strong>Miễn phí</strong> món tráng miệng khi đặt bàn trước</span>
                    </li>
                </ul>
            </div>

            <h2 class="text-2xl font-bold text-gray-800 mb-4 mt-8">Thông Tin Liên Hệ</h2>
            <div class="grid grid-cols-1 md:grid-cols-2 gap-6 mb-8">
                <div class="border rounded-lg p-6">
                    <h4 class="font-bold text-lg mb-3 text-orange-600">
                        <i class="fas fa-map-marker-alt mr-2"></i>Địa chỉ
                    </h4>
                    <p class="text-gray-700">123 Đường Phạm Thái Bường, Phường 4, TP. Vĩnh Long</p>
                </div>
                <div class="border rounded-lg p-6">
                    <h4 class="font-bold text-lg mb-3 text-orange-600">
                        <i class="fas fa-phone mr-2"></i>Hotline
                    </h4>
                    <p class="text-gray-700">1900 xxxx - 0123 456 789</p>
                </div>
            </div>

            <div class="text-center my-8">
                <a href="dat-ban.html" class="inline-block bg-gradient-to-r from-orange-600 to-red-600 text-white px-8 py-4 rounded-lg font-bold text-lg hover:shadow-lg transition transform hover:scale-105">
                    <i class="fas fa-calendar-check mr-2"></i>Đặt Bàn Ngay
                </a>
            </div>
        `
    },
    2: {
        title: "Ra Mắt Thực Đơn Mùa Thu 2025",
        date: "8 Tháng 10, 2025",
        views: "856",
        image: "images/tt1.jpg",
        content: `
            <p class="text-lg text-gray-700 leading-relaxed mb-6">
                Nhà hàng Phương Nam tự hào giới thiệu thực đơn mùa thu 2025 với những món ăn đặc biệt, 
                kết hợp hương vị truyền thống miền Tây và phong cách chế biến hiện đại, mang đến trải nghiệm 
                ẩm thực độc đáo cho thực khách.
            </p>

            <h2 class="text-2xl font-bold text-gray-800 mb-4 mt-8">Điểm Nhấn Thực Đơn Mùa Thu</h2>
            <p class="text-gray-700 leading-relaxed mb-6">
                Mùa thu là thời điểm lý tưởng để thưởng thức những món ăn đậm đà, ấm áp. Đội ngũ đầu bếp 
                của chúng tôi đã nghiên cứu và tạo ra thực đơn đặc biệt với nguyên liệu tươi ngon theo mùa, 
                đảm bảo chất lượng và hương vị tuyệt hảo.
            </p>

            <h2 class="text-2xl font-bold text-gray-800 mb-4 mt-8">Các Món Ăn Nổi Bật</h2>
            
            <div class="space-y-6 mb-8">
                <div class="border-l-4 border-orange-500 pl-4">
                    <h3 class="text-xl font-bold text-gray-800 mb-2">🍲 Lẩu Cá Kèo Lá Giang</h3>
                    <p class="text-gray-700">
                        Món ăn đặc trưng miền Tây với cá kèo tươi ngon, nước lẩu thanh ngọt từ lá giang, 
                        kết hợp rau đồng quê tươi mát. Giá: <strong>350.000đ/nồi</strong>
                    </p>
                </div>

                <div class="border-l-4 border-orange-500 pl-4">
                    <h3 class="text-xl font-bold text-gray-800 mb-2">🍗 Gà Nướng Mật Ong</h3>
                    <p class="text-gray-700">
                        Gà ta nguyên con ướp gia vị đặc biệt, nướng vàng ươm với lớp da giòn tan, 
                        thịt mềm ngọt thấm đều mật ong. Giá: <strong>280.000đ/con</strong>
                    </p>
                </div>

                <div class="border-l-4 border-orange-500 pl-4">
                    <h3 class="text-xl font-bold text-gray-800 mb-2">🦐 Tôm Sú Nướng Muối Ớt</h3>
                    <p class="text-gray-700">
                        Tôm sú size lớn, tươi sống từ biển, nướng với muối ớt thơm nồng, 
                        giữ nguyên độ ngọt tự nhiên của tôm. Giá: <strong>450.000đ/kg</strong>
                    </p>
                </div>

                <div class="border-l-4 border-orange-500 pl-4">
                    <h3 class="text-xl font-bold text-gray-800 mb-2">🍚 Cơm Chiên Dương Châu Đặc Biệt</h3>
                    <p class="text-gray-700">
                        Công thức độc quyền với tôm, xúc xích, trứng và rau củ tươi ngon, 
                        cơm chiên vàng ươm, hạt cơm tơi bời. Giá: <strong>85.000đ/phần</strong>
                    </p>
                </div>
            </div>

            <img src="https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=800" 
                 alt="Món ăn đặc sản" 
                 class="w-full h-64 object-cover rounded-lg my-8">

            <h2 class="text-2xl font-bold text-gray-800 mb-4 mt-8">Món Tráng Miệng Mùa Thu</h2>
            <ul class="list-disc list-inside space-y-2 text-gray-700 mb-6 ml-4">
                <li><strong>Chè Bưởi:</strong> Thanh mát, giải nhiệt - 35.000đ</li>
                <li><strong>Bánh Flan Caramen:</strong> Mềm mịn, ngọt dịu - 30.000đ</li>
                <li><strong>Trái Cây Theo Mùa:</strong> Tươi ngon, giàu vitamin - 45.000đ</li>
            </ul>

            <h2 class="text-2xl font-bold text-gray-800 mb-4 mt-8">Ưu Đãi Đặc Biệt</h2>
            <div class="bg-gradient-to-r from-orange-100 to-red-100 p-6 rounded-lg mb-6">
                <h3 class="text-xl font-bold text-orange-600 mb-4">🎁 Chương trình khuyến mãi:</h3>
                <ul class="space-y-3 text-gray-700">
                    <li class="flex items-start">
                        <i class="fas fa-check-circle text-orange-600 mt-1 mr-3"></i>
                        <span><strong>Giảm 15%</strong> cho tất cả món trong thực đơn mùa thu</span>
                    </li>
                    <li class="flex items-start">
                        <i class="fas fa-check-circle text-orange-600 mt-1 mr-3"></i>
                        <span><strong>Tặng món tráng miệng</strong> khi đặt bàn trước qua website</span>
                    </li>
                    <li class="flex items-start">
                        <i class="fas fa-check-circle text-orange-600 mt-1 mr-3"></i>
                        <span>Áp dụng từ <strong>08/10 - 31/10/2025</strong></span>
                    </li>
                </ul>
            </div>

            <div class="bg-orange-50 border-l-4 border-orange-600 p-6 my-8 rounded-r-lg">
                <p class="text-gray-700 italic">
                    "Thực đơn mùa thu của chúng tôi là sự kết hợp hoàn hảo giữa truyền thống và hiện đại, 
                    mang đến cho thực khách những trải nghiệm ẩm thực khó quên."
                </p>
                <p class="text-orange-600 font-semibold mt-2">- Đầu bếp Nguyễn Văn B, Bếp trưởng</p>
            </div>

            <div class="text-center my-8">
                <a href="dat-ban.html" class="inline-block bg-gradient-to-r from-orange-600 to-red-600 text-white px-8 py-4 rounded-lg font-bold text-lg hover:shadow-lg transition transform hover:scale-105">
                    <i class="fas fa-calendar-check mr-2"></i>Đặt Bàn Ngay
                </a>
            </div>

            <p class="text-gray-700 leading-relaxed text-center">
                Hãy đến và thưởng thức những món ăn tuyệt vời trong không gian ấm cúng của 
                Nhà hàng Phương Nam. Chúng tôi cam kết mang đến cho bạn trải nghiệm ẩm thực đáng nhớ!
            </p>
        `
    },
    3: {
        title: "Giảm Giá 20% Tất Cả Món Ăn Cuối Tuần",
        date: "5 Tháng 10, 2025",
        views: "1,542",
        image: "images/tt2.1.jpg",
        content: `
            <p class="text-lg text-gray-700 leading-relaxed mb-6">
                Nhà hàng Phương Nam tri ân khách hàng thân thiết với chương trình khuyến mãi đặc biệt: 
                <strong class="text-orange-600 text-2xl">GIẢM 20%</strong> tất cả món ăn vào cuối tuần 
                (Thứ 7 & Chủ nhật). Đây là cơ hội tuyệt vời để sum họp gia đình, bạn bè với chi phí tiết kiệm!
            </p>

            <div class="bg-gradient-to-r from-red-500 to-orange-500 text-white p-8 rounded-xl my-8 text-center">
                <h2 class="text-3xl font-bold mb-4">🎉 GIẢM GIÁ 20% 🎉</h2>
                <p class="text-xl">Áp dụng cho TẤT CẢ món ăn</p>
                <p class="text-lg mt-2">Thứ 7 & Chủ nhật hàng tuần</p>
            </div>

            <h2 class="text-2xl font-bold text-gray-800 mb-4 mt-8">Điều Kiện Áp Dụng</h2>
            <div class="bg-gradient-to-r from-orange-100 to-red-100 p-6 rounded-lg mb-6">
                <ul class="space-y-3 text-gray-700">
                    <li class="flex items-start">
                        <i class="fas fa-check-circle text-orange-600 mt-1 mr-3"></i>
                        <span>Áp dụng cho <strong>tất cả các món ăn</strong> trong thực đơn</span>
                    </li>
                    <li class="flex items-start">
                        <i class="fas fa-check-circle text-orange-600 mt-1 mr-3"></i>
                        <span><strong>Đặt bàn trước</strong> qua hotline <strong>1900 xxxx</strong> hoặc website</span>
                    </li>
                    <li class="flex items-start">
                        <i class="fas fa-check-circle text-orange-600 mt-1 mr-3"></i>
                        <span>Áp dụng cho hóa đơn từ <strong>500.000đ</strong> trở lên</span>
                    </li>
                    <li class="flex items-start">
                        <i class="fas fa-check-circle text-orange-600 mt-1 mr-3"></i>
                        <span>Không áp dụng đồng thời với chương trình khuyến mãi khác</span>
                    </li>
                    <li class="flex items-start">
                        <i class="fas fa-check-circle text-orange-600 mt-1 mr-3"></i>
                        <span>Áp dụng tại <strong>tất cả chi nhánh</strong> của Nhà hàng Phương Nam</span>
                    </li>
                </ul>
            </div>

            <h2 class="text-2xl font-bold text-gray-800 mb-4 mt-8">Thời Gian Áp Dụng</h2>
            <div class="grid grid-cols-1 md:grid-cols-2 gap-6 mb-8">
                <div class="border-2 border-orange-500 rounded-lg p-6 text-center">
                    <i class="fas fa-calendar-alt text-4xl text-orange-600 mb-3"></i>
                    <h3 class="font-bold text-lg mb-2">Thời gian</h3>
                    <p class="text-gray-700">05/10/2025 - 31/12/2025</p>
                </div>
                <div class="border-2 border-orange-500 rounded-lg p-6 text-center">
                    <i class="fas fa-clock text-4xl text-orange-600 mb-3"></i>
                    <h3 class="font-bold text-lg mb-2">Ngày áp dụng</h3>
                    <p class="text-gray-700">Thứ 7 & Chủ nhật hàng tuần</p>
                </div>
            </div>

            <h2 class="text-2xl font-bold text-gray-800 mb-4 mt-8">Ví Dụ Tính Giảm Giá</h2>
            <div class="bg-white border-2 border-gray-200 rounded-lg p-6 mb-8">
                <div class="space-y-4">
                    <div class="flex justify-between items-center pb-3 border-b">
                        <span class="text-gray-700">Lẩu Cá Kèo Lá Giang</span>
                        <span class="text-gray-700">350.000đ</span>
                    </div>
                    <div class="flex justify-between items-center pb-3 border-b">
                        <span class="text-gray-700">Gà Nướng Mật Ong</span>
                        <span class="text-gray-700">280.000đ</span>
                    </div>
                    <div class="flex justify-between items-center pb-3 border-b">
                        <span class="text-gray-700">Tôm Sú Nướng (500g)</span>
                        <span class="text-gray-700">225.000đ</span>
                    </div>
                    <div class="flex justify-between items-center pb-3 border-b font-bold">
                        <span>Tổng cộng:</span>
                        <span>855.000đ</span>
                    </div>
                    <div class="flex justify-between items-center pb-3 border-b text-red-600">
                        <span>Giảm 20%:</span>
                        <span>- 171.000đ</span>
                    </div>
                    <div class="flex justify-between items-center text-xl font-bold text-orange-600">
                        <span>Thanh toán:</span>
                        <span>684.000đ</span>
                    </div>
                </div>
            </div>

            <h2 class="text-2xl font-bold text-gray-800 mb-4 mt-8">Cách Đặt Bàn</h2>
            <div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">
                <div class="text-center p-6 bg-orange-50 rounded-lg">
                    <div class="w-16 h-16 bg-orange-600 text-white rounded-full flex items-center justify-center text-2xl font-bold mx-auto mb-4">1</div>
                    <h3 class="font-bold mb-2">Gọi điện</h3>
                    <p class="text-sm text-gray-700">Hotline: 1900 xxxx</p>
                </div>
                <div class="text-center p-6 bg-orange-50 rounded-lg">
                    <div class="w-16 h-16 bg-orange-600 text-white rounded-full flex items-center justify-center text-2xl font-bold mx-auto mb-4">2</div>
                    <h3 class="font-bold mb-2">Đặt online</h3>
                    <p class="text-sm text-gray-700">Qua website hoặc app</p>
                </div>
                <div class="text-center p-6 bg-orange-50 rounded-lg">
                    <div class="w-16 h-16 bg-orange-600 text-white rounded-full flex items-center justify-center text-2xl font-bold mx-auto mb-4">3</div>
                    <h3 class="font-bold mb-2">Nhận ưu đãi</h3>
                    <p class="text-sm text-gray-700">Giảm 20% khi thanh toán</p>
                </div>
            </div>

            <div class="bg-orange-50 border-l-4 border-orange-600 p-6 my-8 rounded-r-lg">
                <p class="text-gray-700 font-bold mb-2">
                    <i class="fas fa-exclamation-circle mr-2"></i>Lưu ý quan trọng:
                </p>
                <ul class="list-disc list-inside space-y-2 text-gray-700 ml-4">
                    <li>Vui lòng đặt bàn trước ít nhất 2 giờ</li>
                    <li>Xuất trình tin nhắn xác nhận đặt bàn khi đến nhà hàng</li>
                    <li>Chương trình có thể kết thúc sớm nếu hết suất</li>
                </ul>
            </div>

            <div class="text-center my-8">
                <a href="dat-ban.html" class="inline-block bg-gradient-to-r from-orange-600 to-red-600 text-white px-8 py-4 rounded-lg font-bold text-lg hover:shadow-lg transition transform hover:scale-105">
                    <i class="fas fa-calendar-check mr-2"></i>Đặt Bàn Ngay - Giảm 20%
                </a>
            </div>

            <p class="text-gray-700 leading-relaxed text-center">
                Đừng bỏ lỡ cơ hội tuyệt vời này! Hãy đặt bàn ngay hôm nay để tận hưởng bữa ăn ngon 
                với giá ưu đãi cùng gia đình và bạn bè tại Nhà hàng Phương Nam.
            </p>
        `
    },
    4: {
        title: "Tổ Chức Lớp Học Nấu Ăn Miễn Phí",
        date: "1 Tháng 10, 2025",
        views: "623",
        image: "images/tt3.jpg",
        content: `
            <p class="text-lg text-gray-700 leading-relaxed mb-6">
                Nhà hàng Phương Nam tổ chức lớp học nấu ăn <strong class="text-orange-600 text-2xl">HOÀN TOÀN MIỄN PHÍ</strong> 
                với chủ đề "Bí quyết nấu món ăn miền Tây đậm đà". Đây là cơ hội tuyệt vời để học hỏi 
                trực tiếp từ các đầu bếp chuyên nghiệp với hơn 20 năm kinh nghiệm.
            </p>

            <div class="bg-gradient-to-r from-green-500 to-teal-500 text-white p-8 rounded-xl my-8 text-center">
                <h2 class="text-3xl font-bold mb-4">👨‍🍳 LỚP HỌC NẤU ĂN MIỄN PHÍ 👨‍🍳</h2>
                <p class="text-xl">Học từ đầu bếp chuyên nghiệp</p>
                <p class="text-lg mt-2">Giới hạn 20 học viên - Đăng ký ngay!</p>
            </div>

            <h2 class="text-2xl font-bold text-gray-800 mb-4 mt-8">Giới Thiệu Khóa Học</h2>
            <p class="text-gray-700 leading-relaxed mb-6">
                Món ăn miền Tây nổi tiếng với hương vị đậm đà, đặc trưng từ nguyên liệu tươi ngon 
                và cách chế biến truyền thống. Trong lớp học này, bạn sẽ được học cách nấu những 
                món ăn đặc sản miền Tây một cách chuyên nghiệp, từ khâu chọn nguyên liệu đến kỹ 
                thuật chế biến và trang trí món ăn.
            </p>

            <h2 class="text-2xl font-bold text-gray-800 mb-4 mt-8">Nội Dung Khóa Học Chi Tiết</h2>
            
            <div class="space-y-6 mb-8">
                <div class="bg-orange-50 p-6 rounded-lg">
                    <h3 class="text-xl font-bold text-orange-600 mb-3">
                        <i class="fas fa-shopping-basket mr-2"></i>Phần 1: Chọn Nguyên Liệu (30 phút)
                    </h3>
                    <ul class="list-disc list-inside space-y-2 text-gray-700 ml-4">
                        <li>Cách nhận biết cá tươi, tôm tươi</li>
                        <li>Chọn rau củ quả theo mùa</li>
                        <li>Bảo quản nguyên liệu đúng cách</li>
                        <li>Mẹo mua sắm tiết kiệm</li>
                    </ul>
                </div>

                <div class="bg-blue-50 p-6 rounded-lg">
                    <h3 class="text-xl font-bold text-blue-600 mb-3">
                        <i class="fas fa-cut mr-2"></i>Phần 2: Kỹ Thuật Sơ Chế (30 phút)
                    </h3>
                    <ul class="list-disc list-inside space-y-2 text-gray-700 ml-4">
                        <li>Làm sạch và khử mùi tanh cá</li>
                        <li>Sơ chế rau củ đúng cách</li>
                        <li>Ướp gia vị để món ăn thấm đều</li>
                        <li>An toàn vệ sinh thực phẩm</li>
                    </ul>
                </div>

                <div class="bg-green-50 p-6 rounded-lg">
                    <h3 class="text-xl font-bold text-green-600 mb-3">
                        <i class="fas fa-fire mr-2"></i>Phần 3: Thực Hành Nấu 3 Món (90 phút)
                    </h3>
                    
                    <div class="space-y-4 mt-4">
                        <div class="border-l-4 border-green-500 pl-4">
                            <h4 class="font-bold text-lg mb-2">🍲 Món 1: Lẩu Mắm Miền Tây</h4>
                            <p class="text-gray-700">
                                Học cách nấu nước lẩu mắm đúng vị, cách bố trí nguyên liệu, 
                                và bí quyết để nước lẩu không bị tanh.
                            </p>
                        </div>

                        <div class="border-l-4 border-green-500 pl-4">
                            <h4 class="font-bold text-lg mb-2">🐟 Món 2: Cá Lóc Nướng Trui</h4>
                            <p class="text-gray-700">
                                Kỹ thuật nướng cá lóc trên lửa rơm để có vị thơm đặc trưng, 
                                cách làm nước mắm chấm chuẩn vị.
                            </p>
                        </div>

                        <div class="border-l-4 border-green-500 pl-4">
                            <h4 class="font-bold text-lg mb-2">🥗 Món 3: Gỏi Cuốn Tôm Thịt</h4>
                            <p class="text-gray-700">
                                Cách cuốn gỏi đẹp mắt, chọn bánh tráng phù hợp, 
                                và làm nước chấm đậm đà.
                            </p>
                        </div>
                    </div>
                </div>

                <div class="bg-purple-50 p-6 rounded-lg">
                    <h3 class="text-xl font-bold text-purple-600 mb-3">
                        <i class="fas fa-palette mr-2"></i>Phần 4: Trang Trí & Trình Bày (30 phút)
                    </h3>
                    <ul class="list-disc list-inside space-y-2 text-gray-700 ml-4">
                        <li>Cách bày biện món ăn đẹp mắt</li>
                        <li>Tỉa hoa từ rau củ</li>
                        <li>Chọn đĩa và phụ kiện phù hợp</li>
                        <li>Chụp ảnh món ăn đẹp</li>
                    </ul>
                </div>
            </div>

            <h2 class="text-2xl font-bold text-gray-800 mb-4 mt-8">Thông Tin Lớp Học</h2>
            <div class="grid grid-cols-1 md:grid-cols-2 gap-6 mb-8">
                <div class="border-2 border-orange-500 rounded-lg p-6">
                    <h4 class="font-bold text-lg mb-3 text-orange-600">
                        <i class="fas fa-calendar mr-2"></i>Thời gian
                    </h4>
                    <p class="text-gray-700 text-lg">
                        <strong>Chủ nhật, 15/10/2025</strong><br>
                        9:00 - 12:00 (3 giờ)
                    </p>
                </div>
                <div class="border-2 border-orange-500 rounded-lg p-6">
                    <h4 class="font-bold text-lg mb-3 text-orange-600">
                        <i class="fas fa-map-marker-alt mr-2"></i>Địa điểm
                    </h4>
                    <p class="text-gray-700 text-lg">
                        Nhà hàng Phương Nam<br>
                        <strong>Chi nhánh Vĩnh Long</strong>
                    </p>
                </div>
                <div class="border-2 border-orange-500 rounded-lg p-6">
                    <h4 class="font-bold text-lg mb-3 text-orange-600">
                        <i class="fas fa-users mr-2"></i>Số lượng
                    </h4>
                    <p class="text-gray-700 text-lg">
                        Giới hạn <strong>20 học viên</strong><br>
                        (Đăng ký sớm để có chỗ)
                    </p>
                </div>
                <div class="border-2 border-orange-500 rounded-lg p-6">
                    <h4 class="font-bold text-lg mb-3 text-orange-600">
                        <i class="fas fa-money-bill-wave mr-2"></i>Học phí
                    </h4>
                    <p class="text-gray-700 text-lg">
                        <strong class="text-green-600 text-2xl">MIỄN PHÍ 100%</strong><br>
                        (Bao gồm nguyên liệu)
                    </p>
                </div>
            </div>

            <h2 class="text-2xl font-bold text-gray-800 mb-4 mt-8">Quà Tặng Cho Học Viên</h2>
            <div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">
                <div class="text-center p-6 bg-gradient-to-br from-orange-100 to-red-100 rounded-lg">
                    <i class="fas fa-book text-4xl text-orange-600 mb-3"></i>
                    <h3 class="font-bold mb-2">Tạp Dề Cao Cấp</h3>
                    <p class="text-sm text-gray-700">Logo Phương Nam</p>
                </div>
                <div class="text-center p-6 bg-gradient-to-br from-orange-100 to-red-100 rounded-lg">
                    <i class="fas fa-ticket-alt text-4xl text-orange-600 mb-3"></i>
                    <h3 class="font-bold mb-2">Voucher 100.000đ</h3>
                    <p class="text-sm text-gray-700">Dùng tại nhà hàng</p>
                </div>
                <div class="text-center p-6 bg-gradient-to-br from-orange-100 to-red-100 rounded-lg">
                    <i class="fas fa-file-alt text-4xl text-orange-600 mb-3"></i>
                    <h3 class="font-bold mb-2">Tài Liệu Công Thức</h3>
                    <p class="text-sm text-gray-700">Chi tiết từng món</p>
                </div>
            </div>

            <h2 class="text-2xl font-bold text-gray-800 mb-4 mt-8">Giảng Viên</h2>
            <div class="bg-white border-2 border-gray-200 rounded-lg p-6 mb-8 flex items-start gap-6">
                <img src="https://ui-avatars.com/api/?name=Chef+Nguyen&size=120&background=f97316&color=fff" 
                     alt="Chef" 
                     class="w-24 h-24 rounded-full">
                <div class="flex-1">
                    <h3 class="text-xl font-bold text-gray-800 mb-2">Đầu bếp Nguyễn Văn C</h3>
                    <p class="text-orange-600 font-semibold mb-3">Bếp trưởng - 25 năm kinh nghiệm</p>
                    <ul class="list-disc list-inside space-y-1 text-gray-700">
                        <li>Chứng chỉ Đầu bếp Quốc tế</li>
                        <li>Từng làm việc tại các nhà hàng 5 sao</li>
                        <li>Chuyên gia về ẩm thực miền Tây</li>
                    </ul>
                </div>
            </div>

            <h2 class="text-2xl font-bold text-gray-800 mb-4 mt-8">Cách Đăng Ký</h2>
            <div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">
                <div class="text-center p-6 bg-orange-50 rounded-lg">
                    <div class="w-16 h-16 bg-orange-600 text-white rounded-full flex items-center justify-center text-2xl font-bold mx-auto mb-4">1</div>
                    <h3 class="font-bold mb-2">Gọi điện</h3>
                    <p class="text-sm text-gray-700">Hotline: <strong>1900 xxxx</strong></p>
                </div>
                <div class="text-center p-6 bg-orange-50 rounded-lg">
                    <div class="w-16 h-16 bg-orange-600 text-white rounded-full flex items-center justify-center text-2xl font-bold mx-auto mb-4">2</div>
                    <h3 class="font-bold mb-2">Email</h3>
                    <p class="text-sm text-gray-700"><strong>contact@phuongnam.vn</strong></p>
                </div>
                <div class="text-center p-6 bg-orange-50 rounded-lg">
                    <div class="w-16 h-16 bg-orange-600 text-white rounded-full flex items-center justify-center text-2xl font-bold mx-auto mb-4">3</div>
                    <h3 class="font-bold mb-2">Trực tiếp</h3>
                    <p class="text-sm text-gray-700">Tại nhà hàng</p>
                </div>
            </div>

            <div class="bg-red-50 border-l-4 border-red-600 p-6 my-8 rounded-r-lg">
                <p class="text-red-700 font-bold mb-3 text-lg">
                    <i class="fas fa-exclamation-triangle mr-2"></i>Lưu ý quan trọng:
                </p>
                <ul class="list-disc list-inside space-y-2 text-gray-700 ml-4">
                    <li><strong>Hạn đăng ký:</strong> Trước 10/10/2025</li>
                    <li><strong>Số lượng:</strong> Chỉ nhận 20 học viên (ai nhanh tay trước)</li>
                    <li><strong>Yêu cầu:</strong> Từ 16 tuổi trở lên, yêu thích nấu ăn</li>
                    <li><strong>Trang phục:</strong> Mặc thoải mái, mang tạp dề (nếu có)</li>
                    <li><strong>Đến sớm:</strong> 15 phút trước giờ học để chuẩn bị</li>
                </ul>
            </div>

            <div class="text-center my-8">
                <a href="tel:1900xxxx" class="inline-block bg-gradient-to-r from-green-600 to-teal-600 text-white px-8 py-4 rounded-lg font-bold text-lg hover:shadow-lg transition transform hover:scale-105 mr-4">
                    <i class="fas fa-phone mr-2"></i>Gọi Ngay: 1900 xxxx
                </a>
                <a href="mailto:contact@phuongnam.vn" class="inline-block bg-gradient-to-r from-orange-600 to-red-600 text-white px-8 py-4 rounded-lg font-bold text-lg hover:shadow-lg transition transform hover:scale-105">
                    <i class="fas fa-envelope mr-2"></i>Đăng Ký Qua Email
                </a>
            </div>

            <p class="text-gray-700 leading-relaxed text-center text-lg">
                Đừng bỏ lỡ cơ hội học nấu ăn miễn phí từ đầu bếp chuyên nghiệp! 
                Số lượng có hạn, đăng ký ngay hôm nay để đảm bảo chỗ của bạn.
            </p>
        `
    }
};

// Load và hiển thị tin tức dựa trên ID
function loadNewsDetail() {
    const urlParams = new URLSearchParams(window.location.search);
    const newsId = urlParams.get('id') || '1';

    const news = newsData[newsId];

    if (news) {
        // Update title
        document.title = `${news.title} - Nhà hàng Phương Nam Vĩnh Long`;

        // Update breadcrumb
        const breadcrumb = document.querySelector('.breadcrumb-current');
        if (breadcrumb) breadcrumb.textContent = news.title;

        // Update date
        const dateElements = document.querySelectorAll('.news-date');
        dateElements.forEach(el => el.textContent = news.date);

        // Update views
        const viewsElements = document.querySelectorAll('.news-views');
        viewsElements.forEach(el => el.textContent = news.views);

        // Update title
        const titleElements = document.querySelectorAll('.news-title');
        titleElements.forEach(el => el.textContent = news.title);

        // Update image
        const images = document.querySelectorAll('.news-featured-image');
        images.forEach(img => img.src = news.image);

        // Update content
        const contentDiv = document.querySelector('.news-content');
        if (contentDiv) {
            contentDiv.innerHTML = news.content;
        }
    }
}

// Initialize khi trang load
document.addEventListener('DOMContentLoaded', loadNewsDetail);
