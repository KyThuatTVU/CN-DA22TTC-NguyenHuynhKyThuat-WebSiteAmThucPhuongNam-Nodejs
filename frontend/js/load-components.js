// Load Component Function
async function loadComponent(elementId, componentPath) {
    try {
        const response = await fetch(componentPath);
        if (!response.ok) {
            throw new Error(`HTTP error! status: ${response.status}`);
        }
        const html = await response.text();
        const element = document.getElementById(elementId);
        if (element) {
            element.innerHTML = html;
        }
    } catch (error) {
        console.error(`Error loading component ${componentPath}:`, error);
    }
}

// Load all common components
async function loadAllComponents() {
    const promises = [];
    
    // Only load navbar if it doesn't already exist
    if (!document.getElementById('navbar')) {
        promises.push(loadComponent('navbar-container', 'components/navbar.html'));
    }
    
    promises.push(loadComponent('footer-container', 'components/footer.html'));
    promises.push(loadComponent('chatbot-container', 'components/chatbot.html'));
    
    // Load page header if container exists
    if (document.getElementById('page-header-container')) {
        promises.push(loadComponent('page-header-container', 'components/page-header.html'));
    }
    
    await Promise.all(promises);
    
    // Initialize after components loaded
    initializeComponents();
}

// Initialize component functionality
function initializeComponents() {
    // Update cart badge after a short delay to ensure navbar is loaded
    setTimeout(() => {
        updateCartBadge();
    }, 100);
    
    // Update user menu with login status
    updateUserMenu();
    
    // Mobile menu toggle
    const mobileMenuBtn = document.getElementById('mobile-menu-btn');
    const mobileMenu = document.getElementById('mobile-menu');
    
    if (mobileMenuBtn && mobileMenu) {
        mobileMenuBtn.addEventListener('click', () => {
            mobileMenu.classList.toggle('hidden');
            const icon = mobileMenuBtn.querySelector('i');
            if (icon) {
                icon.classList.toggle('fa-bars');
                icon.classList.toggle('fa-times');
            }
        });
    }
    
    // Set active nav link
    setActiveNavLink();
    
    // Refresh cart when page becomes visible (user returns to tab)
    document.addEventListener('visibilitychange', () => {
        if (!document.hidden && typeof cartManager !== 'undefined') {
            console.log('🔄 Page became visible, refreshing cart');
            cartManager.loadCart().then(() => {
                setTimeout(() => {
                    updateCartBadge();
                }, 200);
            }).catch((error) => {
                console.error('❌ Error refreshing cart:', error);
            });
        }
    });
}

// Update cart badge count
function updateCartBadge() {
    // Use cartManager if available, otherwise fallback to old method
    if (typeof cartManager !== 'undefined' && cartManager.updateCartBadge) {
        cartManager.updateCartBadge();
    } else {
        // Fallback for old cart system
        const cartData = JSON.parse(localStorage.getItem('cart')) || [];
        let totalItems = 0;
        
        // Handle both old array format and new object format
        if (Array.isArray(cartData)) {
            // Old format: array of items with quantity property
            totalItems = cartData.reduce((sum, item) => sum + (item.quantity || 0), 0);
        } else if (cartData && typeof cartData === 'object' && cartData.so_luong !== undefined) {
            // New format: object with so_luong property
            totalItems = cartData.so_luong || 0;
        }
        
        const badges = document.querySelectorAll('.cart-badge');
        badges.forEach(badge => {
            badge.textContent = totalItems;
            if (totalItems > 0) {
                badge.classList.remove('hidden');
            } else {
                badge.classList.add('hidden');
            }
        });
    }
}

// Update user menu based on login status
function updateUserMenu() {
    const userMenuContainer = document.getElementById('user-menu-container');
    const mobileUserMenu = document.getElementById('mobile-user-menu');
    
    if (!userMenuContainer) {
        console.warn('user-menu-container not found');
        return;
    }

    // Check if user is logged in
    const userStr = localStorage.getItem('user');
    const token = localStorage.getItem('token');
    
    console.log('🔄 Updating user menu...', { hasUser: !!userStr, hasToken: !!token });

    if (userStr && token) {
        try {
            const user = JSON.parse(userStr);
            console.log('👤 User data in updateUserMenu:', { 
                name: user.ten_nguoi_dung, 
                avatar: user.anh_dai_dien,
                avatarType: typeof user.anh_dai_dien
            });
            
            // Xử lý avatar URL - kiểm tra null, undefined, và empty string
            let avatarUrl = null;
            if (user.anh_dai_dien && user.anh_dai_dien.trim() !== '') {
                // Nếu đường dẫn đã có http, giữ nguyên, nếu không thì thêm localhost:3000
                avatarUrl = user.anh_dai_dien.startsWith('http') 
                    ? user.anh_dai_dien 
                    : `http://localhost:3000${user.anh_dai_dien}`;
                console.log('🖼️ Avatar URL (load-components):', avatarUrl);
            } else {
                console.log('⚠️ No avatar found for user (load-components)');
            }

            // Desktop User Menu
            userMenuContainer.innerHTML = `
                <div class="relative group">
                    <button class="flex items-center space-x-2 text-gray-700 hover:text-orange-600 transition">
                        ${avatarUrl 
                            ? `<img src="${avatarUrl}" alt="${user.ten_nguoi_dung}" class="w-8 h-8 rounded-full object-cover border-2 border-orange-200" onerror="console.error('Failed to load avatar (load-components):', this.src); this.onerror=null; this.parentElement.innerHTML='<div class=\\'w-8 h-8 rounded-full bg-orange-100 flex items-center justify-center\\'><i class=\\'fas fa-user text-orange-600\\'></i></div>';\">`
                            : `<div class="w-8 h-8 rounded-full bg-orange-100 flex items-center justify-center">
                                <i class="fas fa-user text-orange-600"></i>
                               </div>`
                        }
                        <span class="hidden xl:inline font-medium">${user.ten_nguoi_dung}</span>
                        <i class="fas fa-chevron-down text-xs"></i>
                    </button>
                    <div class="absolute right-0 mt-2 w-56 bg-white rounded-lg shadow-lg opacity-0 invisible group-hover:opacity-100 group-hover:visible transition-all duration-300 z-50 border border-gray-100">
                        <div class="px-4 py-3 border-b border-gray-100">
                            <p class="text-sm font-medium text-gray-800">${user.ten_nguoi_dung}</p>
                            <p class="text-xs text-gray-500">${user.email}</p>
                        </div>
                        <a href="tai-khoan.html" class="block px-4 py-3 text-gray-700 hover:bg-orange-50 hover:text-orange-600">
                            <i class="fas fa-user-circle mr-2"></i> Tài khoản của tôi
                        </a>
                        <a href="dat-ban.html" class="block px-4 py-3 text-gray-700 hover:bg-orange-50 hover:text-orange-600">
                            <i class="fas fa-calendar-check mr-2"></i> Đặt bàn
                        </a>
                        <button onclick="handleLogout()" class="w-full text-left block px-4 py-3 text-red-600 hover:bg-red-50 border-t border-gray-100">
                            <i class="fas fa-sign-out-alt mr-2"></i> Đăng xuất
                        </button>
                    </div>
                </div>
            `;

            // Mobile User Menu
            if (mobileUserMenu) {
                mobileUserMenu.innerHTML = `
                    <div class="px-4 py-3 bg-orange-50 border-b border-orange-100">
                        <p class="text-sm font-medium text-gray-800">${user.ten_nguoi_dung}</p>
                        <p class="text-xs text-gray-500">${user.email}</p>
                    </div>
                    <a href="tai-khoan.html" class="block py-3 px-4 text-gray-800 hover:text-orange-600 hover:bg-orange-50 transition font-medium">
                        <i class="fas fa-user-circle mr-2"></i> Tài khoản của tôi
                    </a>
                    <a href="dat-ban.html" class="block py-3 px-4 text-gray-800 hover:text-orange-600 hover:bg-orange-50 transition font-medium">
                        <i class="fas fa-calendar-check mr-2"></i> Đặt bàn
                    </a>
                    <button onclick="handleLogout()" class="w-full text-left py-3 px-4 text-red-600 hover:bg-red-50 font-medium border-t border-gray-200">
                        <i class="fas fa-sign-out-alt mr-2"></i> Đăng xuất
                    </button>
                `;
            }

            console.log('✅ User menu updated for:', user.ten_nguoi_dung);
        } catch (error) {
            console.error('❌ Error parsing user data:', error);
            renderGuestMenu(userMenuContainer, mobileUserMenu);
        }
    } else {
        console.log('👤 No user logged in, showing guest menu');
        renderGuestMenu(userMenuContainer, mobileUserMenu);
    }
}

// Render menu for guests (not logged in)
function renderGuestMenu(userMenuContainer, mobileUserMenu) {
    if (userMenuContainer) {
        userMenuContainer.innerHTML = `
            <div class="relative group">
                <button class="text-gray-700 hover:text-orange-600 transition">
                    <i class="fas fa-user text-xl"></i>
                </button>
                <div class="absolute right-0 mt-2 w-48 bg-white rounded-lg shadow-lg opacity-0 invisible group-hover:opacity-100 group-hover:visible transition-all duration-300 z-50 border border-gray-100">
                    <a href="dang-nhap.html" class="block px-4 py-3 text-gray-700 hover:bg-orange-50 hover:text-orange-600">
                        <i class="fas fa-sign-in-alt mr-2"></i> Đăng nhập
                    </a>
                    <a href="dang-ky.html" class="block px-4 py-3 text-gray-700 hover:bg-orange-50 hover:text-orange-600">
                        <i class="fas fa-user-plus mr-2"></i> Đăng ký
                    </a>
                    <a href="admin/index.html" class="block px-4 py-3 text-gray-700 hover:bg-orange-50 hover:text-orange-600 border-t border-gray-100">
                        <i class="fas fa-user-shield mr-2"></i> Quản trị
                    </a>
                </div>
            </div>
        `;
    }

    if (mobileUserMenu) {
        mobileUserMenu.innerHTML = `
            <a href="dang-nhap.html" class="block py-3 px-4 text-gray-800 hover:text-orange-600 hover:bg-orange-50 transition font-medium">
                <i class="fas fa-sign-in-alt mr-2"></i> Đăng nhập
            </a>
            <a href="dang-ky.html" class="block py-3 px-4 text-gray-800 hover:text-orange-600 hover:bg-orange-50 transition font-medium">
                <i class="fas fa-user-plus mr-2"></i> Đăng ký
            </a>
        `;
    }
}

// Handle logout (global function)
window.handleLogout = function() {
    if (confirm('Bạn có chắc muốn đăng xuất?')) {
        localStorage.removeItem('user');
        localStorage.removeItem('token');
        window.location.href = 'index.html';
    }
}

// Set active navigation link based on current page
function setActiveNavLink() {
    // Get current page filename
    const currentPage = window.location.pathname.split('/').pop() || 'index.html';
    const pageName = currentPage.replace('.html', '');
    
    console.log('📍 Current page:', pageName);
    
    // Set active state for desktop nav links
    const navLinks = document.querySelectorAll('.nav-link');
    navLinks.forEach(link => {
        const linkPage = link.getAttribute('data-page');
        if (linkPage === pageName || (pageName === '' && linkPage === 'index')) {
            link.classList.add('active');
            console.log('✅ Active link set:', linkPage);
        } else {
            link.classList.remove('active');
        }
    });
    
    // Set active state for mobile nav links
    const mobileNavLinks = document.querySelectorAll('.nav-link-mobile');
    mobileNavLinks.forEach(link => {
        const linkPage = link.getAttribute('data-page');
        if (linkPage === pageName || (pageName === '' && linkPage === 'index')) {
            link.classList.add('active');
        } else {
            link.classList.remove('active');
        }
    });
}

// Load components when DOM is ready
if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', loadAllComponents);
} else {
    loadAllComponents();
}

// Initialize cart after components are loaded (only if cart.js is already loaded)
function initializeCart() {
    // Wait for cartManager to be available
    const checkCartManager = setInterval(() => {
        if (typeof cartManager !== 'undefined') {
            clearInterval(checkCartManager);
            console.log('✅ Initializing cart manager');
            
            // Load cart and update badge when done
            cartManager.loadCart().then(() => {
                // Update cart badge after cart is loaded
                setTimeout(() => {
                    updateCartBadge();
                }, 200);
            }).catch((error) => {
                console.error('❌ Error loading cart:', error);
                // Still update badge even if cart loading fails
                setTimeout(() => {
                    updateCartBadge();
                }, 200);
            });
        }
    }, 100);

    // Timeout after 5 seconds
    setTimeout(() => {
        clearInterval(checkCartManager);
        console.warn('⚠️ CartManager not found after 5 seconds');
    }, 5000);
}

// Call initialize cart
initializeCart();
