// Load Component Function
async function loadComponent(elementId, componentPath) {
    try {
        const element = document.getElementById(elementId);
        
        // Show loading placeholder if element exists
        if (element && typeof LoadingManager !== 'undefined') {
            element.innerHTML = `<div class="pulse-loading py-4 text-center text-gray-400"><i class="fas fa-spinner fa-spin"></i></div>`;
        }
        
        const response = await fetch(componentPath);
        if (!response.ok) {
            throw new Error(`HTTP error! status: ${response.status}`);
        }
        const html = await response.text();
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
    console.log('🔧 Initializing components...');
    
    // Update cart badge after a short delay to ensure navbar is loaded
    setTimeout(() => {
        updateCartBadge();
    }, 100);
    
    // Update user menu with login status
    updateUserMenu();
    
    // Initialize Chatbot
    initializeChatbot();
    
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
    
    // Set active nav link - call immediately and after delay
    setActiveNavLink();
    
    // Also set active link after a longer delay to ensure everything is loaded
    setTimeout(() => {
        console.log('🔄 Re-checking active nav link...');
        setActiveNavLink();
    }, 500);
    
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

// Hàm xử lý avatar URL - đảm bảo nhất quán giữa Google và local
function getAvatarUrl(avatarPath) {
    if (!avatarPath || (typeof avatarPath === 'string' && avatarPath.trim() === '')) {
        return null;
    }
    
    let url = avatarPath.trim();
    
    // Nếu là URL Google, giữ nguyên (đã được xử lý từ backend)
    if (url.includes('googleusercontent.com')) {
        // Chỉ sửa nếu URL bị lỗi (có chứa 'onerror' hoặc các ký tự lạ)
        if (url.includes('onerror') || url.includes('undefined')) {
            // Loại bỏ phần lỗi và thêm lại size
            url = url.replace(/=s\d+(-c)?(onerror|undefined)?.*$/gi, '');
            url = `${url}=s200-c`;
        }
        console.log('🖼️ Google Avatar URL:', url);
        return url;
    }
    
    // Nếu là URL đầy đủ khác (http/https), giữ nguyên
    if (url.startsWith('http://') || url.startsWith('https://')) {
        return url;
    }
    
    // Nếu là đường dẫn local, thêm base URL
    if (url.startsWith('/')) {
        return `http://localhost:3000${url}`;
    }
    
    return `http://localhost:3000/${url}`;
}

// Update user menu based on login status - lấy data từ API
async function updateUserMenu() {
    const userMenuContainer = document.getElementById('user-menu-container');
    const mobileUserMenu = document.getElementById('mobile-user-menu');
    
    if (!userMenuContainer) {
        console.warn('user-menu-container not found');
        return;
    }

    const token = localStorage.getItem('token');
    
    console.log('🔄 Updating user menu...', { hasToken: !!token });

    if (!token) {
        console.log('👤 No token, showing guest menu');
        renderGuestMenu(userMenuContainer, mobileUserMenu);
        return;
    }

    try {
        // Lấy thông tin user từ API (database) thay vì localStorage
        const response = await fetch('http://localhost:3000/api/auth/me', {
            headers: {
                'Authorization': `Bearer ${token}`
            }
        });

        const result = await response.json();

        if (!result.success || !result.data) {
            console.log('❌ Token invalid or user not found');
            // Token không hợp lệ, xóa và hiển thị guest menu
            localStorage.removeItem('token');
            localStorage.removeItem('user');
            renderGuestMenu(userMenuContainer, mobileUserMenu);
            return;
        }

        const user = result.data;
        console.log('👤 User data from API:', { 
            name: user.ten_nguoi_dung, 
            avatar: user.anh_dai_dien
        });

        // Cập nhật localStorage với data mới từ DB
        const localUser = localStorage.getItem('user');
        if (localUser) {
            const parsedUser = JSON.parse(localUser);
            parsedUser.ten_nguoi_dung = user.ten_nguoi_dung;
            parsedUser.anh_dai_dien = user.anh_dai_dien;
            parsedUser.email = user.email;
            localStorage.setItem('user', JSON.stringify(parsedUser));
        }
        
        // Xử lý avatar URL - sử dụng hàm helper
        const avatarUrl = getAvatarUrl(user.anh_dai_dien);
        if (avatarUrl) {
            console.log('🖼️ Avatar URL from DB:', avatarUrl);
        } else {
            console.log('⚠️ No avatar found for user');
        }
        
        // Lấy tên hiển thị - đảm bảo luôn có giá trị
        const displayName = user.ten_nguoi_dung || user.email || 'Người dùng';

        // Render user menu
        renderLoggedInMenu(userMenuContainer, mobileUserMenu, user, avatarUrl, displayName);
        console.log('✅ User menu updated for:', displayName);

    } catch (error) {
        console.error('❌ Error fetching user data:', error);
        // Fallback: sử dụng localStorage nếu API lỗi
        const userStr = localStorage.getItem('user');
        if (userStr) {
            try {
                const user = JSON.parse(userStr);
                const avatarUrl = getAvatarUrl(user.anh_dai_dien);
                const displayName = user.ten_nguoi_dung || user.email || 'Người dùng';
                renderLoggedInMenu(userMenuContainer, mobileUserMenu, user, avatarUrl, displayName);
                console.log('✅ User menu updated from localStorage (fallback)');
            } catch (e) {
                renderGuestMenu(userMenuContainer, mobileUserMenu);
            }
        } else {
            renderGuestMenu(userMenuContainer, mobileUserMenu);
        }
    }
}

// Render menu cho user đã đăng nhập - đồng nhất style cho cả Google và user thường
function renderLoggedInMenu(userMenuContainer, mobileUserMenu, user, avatarUrl, displayName) {
    // Desktop User Menu - xóa toàn bộ nội dung cũ và thay thế
    // Avatar size: w-9 h-9 (36px) - đồng nhất cho tất cả các trang
    userMenuContainer.innerHTML = `
        <div class="relative group" style="z-index: 9999;">
            <button class="flex items-center space-x-2 text-gray-700 hover:text-orange-600 transition">
                <div class="w-9 h-9 rounded-full overflow-hidden border-2 border-orange-200 bg-orange-100 flex items-center justify-center flex-shrink-0">
                    ${avatarUrl 
                        ? `<img src="${avatarUrl}" alt="${displayName}" class="w-full h-full object-cover" referrerpolicy="no-referrer" onerror="this.style.display='none'; this.nextElementSibling.style.display='flex';">
                           <i class="fas fa-user text-orange-600 text-sm" style="display:none;"></i>`
                        : `<i class="fas fa-user text-orange-600 text-sm"></i>`
                    }
                </div>
                <span class="hidden lg:inline font-medium text-sm max-w-[150px] truncate">${displayName}</span>
                <i class="fas fa-chevron-down text-xs hidden lg:inline ml-1"></i>
            </button>
            <div class="absolute right-0 mt-2 w-56 bg-white rounded-lg shadow-xl opacity-0 invisible group-hover:opacity-100 group-hover:visible transition-all duration-300 border border-gray-100" style="z-index: 9999;">
                <div class="px-4 py-3 border-b border-gray-100">
                    <p class="text-sm font-medium text-gray-800 truncate">${displayName}</p>
                    <p class="text-xs text-gray-500 truncate">${user.email || ''}</p>
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

    // Mobile User Menu - thêm avatar và đồng nhất style
    if (mobileUserMenu) {
        mobileUserMenu.innerHTML = `
            <div class="flex items-center px-4 py-3 bg-orange-50 border-b border-orange-100">
                <div class="w-10 h-10 rounded-full overflow-hidden border-2 border-orange-300 bg-orange-100 flex items-center justify-center flex-shrink-0">
                    ${avatarUrl 
                        ? `<img src="${avatarUrl}" alt="${displayName}" class="w-full h-full object-cover" referrerpolicy="no-referrer" onerror="this.style.display='none'; this.nextElementSibling.style.display='flex';">
                           <i class="fas fa-user text-orange-600" style="display:none;"></i>`
                        : `<i class="fas fa-user text-orange-600"></i>`
                    }
                </div>
                <div class="ml-3 overflow-hidden">
                    <p class="text-sm font-medium text-gray-800 truncate">${displayName}</p>
                    <p class="text-xs text-gray-500 truncate">${user.email || ''}</p>
                </div>
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
    // Wait a bit for navbar to be fully loaded
    setTimeout(() => {
        // Get current page filename
        const currentPage = window.location.pathname.split('/').pop() || 'index.html';
        const pageName = currentPage.replace('.html', '');
        
        console.log('📍 Current page:', pageName);
        console.log('📍 Full path:', window.location.pathname);
        
        // Set active state for desktop nav links
        const navLinks = document.querySelectorAll('.nav-link');
        console.log('🔍 Found nav links:', navLinks.length);
        
        navLinks.forEach(link => {
            const linkPage = link.getAttribute('data-page');
            console.log('🔗 Checking link:', linkPage, 'vs', pageName);
            
            // Remove active class first
            link.classList.remove('active');
            
            // Add active class if matches
            if (linkPage === pageName || (pageName === '' && linkPage === 'index')) {
                link.classList.add('active');
                console.log('✅ Active link set:', linkPage);
            }
        });
        
        // Set active state for mobile nav links
        const mobileNavLinks = document.querySelectorAll('.nav-link-mobile');
        console.log('🔍 Found mobile nav links:', mobileNavLinks.length);
        
        mobileNavLinks.forEach(link => {
            const linkPage = link.getAttribute('data-page');
            
            // Remove active class first
            link.classList.remove('active');
            
            // Add active class if matches
            if (linkPage === pageName || (pageName === '' && linkPage === 'index')) {
                link.classList.add('active');
                console.log('✅ Active mobile link set:', linkPage);
            }
        });
    }, 200); // Wait 200ms for navbar to load
}

// Load components when DOM is ready
if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', loadAllComponents);
} else {
    loadAllComponents();
}

// Initialize cart after components are loaded (only if cart.js is already loaded)
function initializeCart() {
    // Skip cart initialization on pages that don't need it
    const currentPage = window.location.pathname.split('/').pop() || 'index.html';
    const pagesWithoutCart = ['dat-hang-thanh-cong.html', 'dang-nhap.html', 'dang-ky.html', 'quen-mat-khau.html', 'dat-lai-mat-khau.html', 'xac-thuc-email.html'];
    
    if (pagesWithoutCart.includes(currentPage)) {
        console.log('ℹ️ Skipping cart initialization on', currentPage);
        // Still update badge with fallback
        updateCartBadge();
        return;
    }
    
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
        if (typeof cartManager === 'undefined') {
            clearInterval(checkCartManager);
            console.warn('⚠️ CartManager not found after 5 seconds - check if cart.js is loaded');
            // Still update badge with fallback
            updateCartBadge();
        }
    }, 5000);
}

// Call initialize cart
initializeCart();

// Initialize Chatbot functionality
function initializeChatbot() {
    const chatbotButton = document.getElementById('chatbotButton');
    const chatbotPanel = document.getElementById('chatbotPanel');
    const closeChatbot = document.getElementById('closeChatbot');
    
    if (chatbotButton && chatbotPanel) {
        console.log('🤖 Initializing chatbot...');
        
        const isMobile = () => window.innerWidth <= 640;
        
        // Toggle chat panel khi click vào button
        chatbotButton.addEventListener('click', function() {
            if (isMobile()) {
                // Mobile: fullscreen mode
                chatbotPanel.classList.toggle('mobile-open');
                document.body.style.overflow = chatbotPanel.classList.contains('mobile-open') ? 'hidden' : '';
            } else {
                // Desktop: popup mode
                chatbotPanel.classList.toggle('opacity-0');
                chatbotPanel.classList.toggle('scale-90');
                chatbotPanel.classList.toggle('pointer-events-none');
            }
            // Focus input
            setTimeout(() => document.getElementById('chatbotInput')?.focus(), 100);
        });
        
        // Đóng chat panel
        if (closeChatbot) {
            closeChatbot.addEventListener('click', function() {
                if (isMobile()) {
                    chatbotPanel.classList.remove('mobile-open');
                    document.body.style.overflow = '';
                } else {
                    chatbotPanel.classList.add('opacity-0', 'scale-90', 'pointer-events-none');
                }
            });
        }
        
        console.log('✅ Chatbot initialized successfully');
    }
}

// Gửi tin nhắn nhanh
window.chatbotSendQuick = function(message) {
    document.getElementById('chatbotInput').value = message;
    chatbotSendMessage();
};

// Session ID cho chatbot
const chatbotSessionId = 'session_' + Date.now() + '_' + Math.random().toString(36).substr(2, 9);

// Gửi tin nhắn chatbot
window.chatbotSendMessage = async function() {
    const input = document.getElementById('chatbotInput');
    const messages = document.getElementById('chatbotMessages');
    const text = input.value.trim();
    
    if (!text) return;
    
    // Thêm tin nhắn user
    const userMsg = document.createElement('div');
    userMsg.className = 'flex justify-end';
    userMsg.innerHTML = `
        <div class="bg-gradient-to-br from-green-400 to-blue-500 p-4 rounded-2xl rounded-tr-none max-w-[85%] shadow-md">
            <p class="text-white text-[15px]">${escapeHtmlChat(text)}</p>
        </div>
    `;
    messages.appendChild(userMsg);
    input.value = '';
    messages.scrollTop = messages.scrollHeight;
    
    // Hiển thị typing indicator
    const typingDiv = document.createElement('div');
    typingDiv.id = 'chatbot-typing';
    typingDiv.className = 'flex gap-3';
    typingDiv.innerHTML = `
        <div class="w-9 h-9 bg-gradient-to-br from-green-400 to-blue-500 rounded-full flex items-center justify-center flex-shrink-0">
            <i class="fas fa-robot text-white text-sm"></i>
        </div>
        <div class="bg-white p-4 rounded-2xl rounded-tl-none shadow-md">
            <div class="flex gap-1">
                <span class="w-2 h-2 bg-gray-400 rounded-full animate-bounce" style="animation-delay: 0s"></span>
                <span class="w-2 h-2 bg-gray-400 rounded-full animate-bounce" style="animation-delay: 0.2s"></span>
                <span class="w-2 h-2 bg-gray-400 rounded-full animate-bounce" style="animation-delay: 0.4s"></span>
            </div>
        </div>
    `;
    messages.appendChild(typingDiv);
    messages.scrollTop = messages.scrollHeight;
    
    try {
        const response = await fetch('http://localhost:3000/api/chatbot/chat', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ message: text })
        });
        
        const result = await response.json();
        document.getElementById('chatbot-typing')?.remove();
        
        let botResponse = result.success && result.data?.response 
            ? result.data.response 
            : (result.message || '❌ Không thể kết nối. Vui lòng thử lại!');
        
        addBotMessage(messages, botResponse);
        
    } catch (error) {
        console.error('Chatbot API error:', error);
        document.getElementById('chatbot-typing')?.remove();
        addBotMessage(messages, '❌ Lỗi kết nối. Vui lòng thử lại sau!');
    }
};

// Thêm tin nhắn bot
function addBotMessage(messages, response) {
    const botMsg = document.createElement('div');
    botMsg.className = 'flex gap-2';
    botMsg.innerHTML = `
        <div class="w-7 h-7 bg-gradient-to-br from-green-400 to-blue-500 rounded-full flex items-center justify-center flex-shrink-0">
            <i class="fas fa-robot text-white text-xs"></i>
        </div>
        <div class="chat-bubble-bot px-3 py-2 max-w-[85%]">
            <p class="text-gray-700 text-sm leading-relaxed">${response}</p>
        </div>
    `;
    messages.appendChild(botMsg);
    messages.scrollTop = messages.scrollHeight;
}

// Escape HTML
function escapeHtmlChat(text) {
    const div = document.createElement('div');
    div.textContent = text;
    return div.innerHTML;
}

// Export functions to window for global access
window.updateUserMenu = updateUserMenu;
window.getAvatarUrl = getAvatarUrl;
window.initializeChatbot = initializeChatbot;
