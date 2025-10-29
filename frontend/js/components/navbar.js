// Navigation Bar Component
ComponentManager.register('navbar', (data = {}) => {
    const { currentPage = 'index' } = data;
    
    const isActive = (page) => currentPage === page ? 'text-orange-600 font-medium' : 'text-gray-700 hover:text-orange-600';
    
    return `
        <nav id="navbar" class="fixed w-full top-0 z-50 transition-all duration-300 bg-white shadow-md">
            <div class="container mx-auto px-4">
                <div class="flex items-center justify-between h-20">
                    <!-- Logo -->
                    <div class="flex items-center space-x-3">
                        <i class="fas fa-utensils text-3xl text-orange-600"></i>
                        <div>
                            <h1 class="font-playfair text-2xl font-bold text-gray-800">Phương Nam</h1>
                            <p class="text-xs text-gray-600">Vĩnh Long</p>
                        </div>
                    </div>

                    <!-- Desktop Menu -->
                    <div class="hidden lg:flex items-center space-x-8">
                        <a href="index.html" class="${isActive('index')} transition">
                            <i class="fas fa-home mr-1"></i> Trang chủ
                        </a>
                        <a href="gioi-thieu.html" class="${isActive('about')} transition">
                            <i class="fas fa-info-circle mr-1"></i> Giới thiệu
                        </a>
                        <a href="tin-tuc.html" class="${isActive('news')} transition">
                            <i class="fas fa-newspaper mr-1"></i> Tin tức
                        </a>
                        <a href="album.html" class="${isActive('album')} transition">
                            <i class="fas fa-images mr-1"></i> Album ảnh
                        </a>
                        <a href="thuc-don.html" class="${isActive('menu')} transition">
                            <i class="fas fa-book-open mr-1"></i> Thực đơn
                        </a>
                        <a href="dat-ban.html" class="${isActive('booking')} transition">
                            <i class="fas fa-calendar-check mr-1"></i> Đặt bàn
                        </a>
                        <a href="lien-he.html" class="${isActive('contact')} transition">
                            <i class="fas fa-phone mr-1"></i> Liên hệ
                        </a>
                    </div>

                    <!-- Right Menu -->
                    <div class="hidden lg:flex items-center space-x-4">
                        <!-- Search -->
                        <button class="text-gray-700 hover:text-orange-600 transition" onclick="toggleSearch()">
                            <i class="fas fa-search text-xl"></i>
                        </button>

                        <!-- Cart -->
                        <a href="gio-hang.html" class="relative text-gray-700 hover:text-orange-600 transition">
                            <i class="fas fa-shopping-cart text-xl"></i>
                            <span class="absolute cart-badge bg-orange-600 text-white text-xs rounded-full flex items-center justify-center">0</span>
                        </a>

                        <!-- User Menu -->
                        <div class="relative group">
                            <button class="text-gray-700 hover:text-orange-600 transition">
                                <i class="fas fa-user text-xl"></i>
                            </button>
                            <div class="absolute right-0 mt-2 w-48 bg-white rounded-lg shadow-lg opacity-0 invisible group-hover:opacity-100 group-hover:visible transition-all duration-300">
                                <a href="dang-nhap.html" class="block px-4 py-3 text-gray-700 hover:bg-orange-50 hover:text-orange-600">
                                    <i class="fas fa-sign-in-alt mr-2"></i> Đăng nhập
                                </a>
                                <a href="dang-ky.html" class="block px-4 py-3 text-gray-700 hover:bg-orange-50 hover:text-orange-600">
                                    <i class="fas fa-user-plus mr-2"></i> Đăng ký
                                </a>
                                <a href="admin/index.html" class="block px-4 py-3 text-gray-700 hover:bg-orange-50 hover:text-orange-600">
                                    <i class="fas fa-user-shield mr-2"></i> Quản trị
                                </a>
                            </div>
                        </div>
                    </div>

                    <!-- Mobile Menu Button -->
                    <button id="mobile-menu-btn" class="lg:hidden text-gray-700 text-2xl">
                        <i class="fas fa-bars"></i>
                    </button>
                </div>

                <!-- Mobile Menu -->
                <div id="mobile-menu" class="hidden lg:hidden pb-4">
                    <a href="index.html" class="block py-2 ${isActive('index')}">Trang chủ</a>
                    <a href="gioi-thieu.html" class="block py-2 ${isActive('about')}">Giới thiệu</a>
                    <a href="tin-tuc.html" class="block py-2 ${isActive('news')}">Tin tức</a>
                    <a href="album.html" class="block py-2 ${isActive('album')}">Album ảnh</a>
                    <a href="thuc-don.html" class="block py-2 ${isActive('menu')}">Thực đơn</a>
                    <a href="dat-ban.html" class="block py-2 ${isActive('booking')}">Đặt bàn</a>
                    <a href="lien-he.html" class="block py-2 ${isActive('contact')}">Liên hệ</a>
                    <a href="gio-hang.html" class="block py-2 text-gray-700 hover:text-orange-600">Giỏ hàng</a>
                    <a href="dang-nhap.html" class="block py-2 text-gray-700 hover:text-orange-600">Đăng nhập</a>
                    <a href="dang-ky.html" class="block py-2 text-gray-700 hover:text-orange-600">Đăng ký</a>
                </div>
            </div>
        </nav>
    `;
});

// Initialize navbar when loaded
function initNavbar() {
    const mobileMenuBtn = document.getElementById('mobile-menu-btn');
    const mobileMenu = document.getElementById('mobile-menu');
    
    if (mobileMenuBtn) {
        mobileMenuBtn.addEventListener('click', () => {
            mobileMenu.classList.toggle('hidden');
        });
    }
}

// Auto-initialize after component is rendered
document.addEventListener('DOMContentLoaded', () => {
    setTimeout(initNavbar, 100);
});
