// API Configuration
if (typeof window.API_URL === 'undefined') {
    window.API_URL = 'http://localhost:3000/api';
}
const API_URL = window.API_URL;

// Cart management functions
class CartManager {
    constructor() {
        this.cart = {
            ma_gio_hang: null,
            items: [],
            tong_tien: 0,
            so_luong: 0
        };
        this.init();
    }

    init() {
        // Load cart from localStorage if available
        this.loadCartFromStorage();
        // Update UI
        this.updateCartBadge();
    }

    // Get authentication token
    getToken() {
        return localStorage.getItem('token') || sessionStorage.getItem('token');
    }

    // Check if user is authenticated
    isAuthenticated() {
        return !!this.getToken();
    }

    // API call wrapper with authentication
    async apiCall(endpoint, options = {}) {
        const token = this.getToken();
        if (!token) {
            throw new Error('Vui lòng đăng nhập để tiếp tục');
        }

        const defaultOptions = {
            headers: {
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${token}`
            }
        };

        const response = await fetch(`${API_URL}${endpoint}`, {
            ...defaultOptions,
            ...options,
            headers: {
                ...defaultOptions.headers,
                ...options.headers
            }
        });

        const data = await response.json();

        if (!response.ok) {
            throw new Error(data.message || 'Có lỗi xảy ra');
        }

        return data;
    }

    // Load cart from server
    async loadCart() {
        try {
            if (!this.isAuthenticated()) {
                this.cart = { ma_gio_hang: null, items: [], tong_tien: 0, so_luong: 0 };
                this.saveCartToStorage();
                this.updateCartBadge();
                return;
            }

            const response = await this.apiCall('/cart');
            if (response.success) {
                this.cart = response.data;
                this.saveCartToStorage();
                this.updateCartBadge();
            }
        } catch (error) {
            console.error('Lỗi tải giỏ hàng:', error);
            this.showNotification('Không thể tải giỏ hàng', 'error');
        }
    }

    // Add item to cart
    async addToCart(ma_mon, so_luong = 1) {
        try {
            if (!this.isAuthenticated()) {
                this.showNotification('Vui lòng đăng nhập để thêm vào giỏ hàng', 'warning');
                // Redirect to login page
                window.location.href = 'dang-nhap.html';
                return;
            }

            const response = await this.apiCall('/cart/add', {
                method: 'POST',
                body: JSON.stringify({ ma_mon, so_luong })
            });

            if (response.success) {
                this.showNotification('Đã thêm vào giỏ hàng!', 'success');
                // Reload cart to get updated data
                await this.loadCart();
            }
        } catch (error) {
            console.error('Lỗi thêm vào giỏ hàng:', error);
            this.showNotification(error.message, 'error');
        }
    }

    // Update cart item quantity
    async updateCartItem(ma_chi_tiet, so_luong) {
        try {
            const response = await this.apiCall('/cart/update', {
                method: 'PUT',
                body: JSON.stringify({ ma_chi_tiet, so_luong })
            });

            if (response.success) {
                this.showNotification('Đã cập nhật giỏ hàng!', 'success');
                await this.loadCart();
            }
        } catch (error) {
            console.error('Lỗi cập nhật giỏ hàng:', error);
            this.showNotification(error.message, 'error');
        }
    }

    // Remove item from cart
    async removeFromCart(ma_chi_tiet) {
        try {
            const response = await this.apiCall(`/cart/remove/${ma_chi_tiet}`, {
                method: 'DELETE'
            });

            if (response.success) {
                this.showNotification('Đã xóa khỏi giỏ hàng!', 'success');
                await this.loadCart();
            }
        } catch (error) {
            console.error('Lỗi xóa khỏi giỏ hàng:', error);
            this.showNotification(error.message, 'error');
        }
    }

    // Clear entire cart
    async clearCart() {
        try {
            const response = await this.apiCall('/cart/clear', {
                method: 'DELETE'
            });

            if (response.success) {
                this.showNotification('Đã xóa toàn bộ giỏ hàng!', 'success');
                await this.loadCart();
            }
        } catch (error) {
            console.error('Lỗi xóa giỏ hàng:', error);
            this.showNotification(error.message, 'error');
        }
    }

    // Get cart data
    getCart() {
        return this.cart;
    }

    // Save cart to localStorage for persistence
    saveCartToStorage() {
        localStorage.setItem('cart', JSON.stringify(this.cart));
    }

    // Load cart from localStorage
    loadCartFromStorage() {
        const savedCart = localStorage.getItem('cart');
        if (savedCart) {
            try {
                this.cart = JSON.parse(savedCart);
            } catch (error) {
                console.error('Lỗi tải giỏ hàng từ localStorage:', error);
                this.cart = { ma_gio_hang: null, items: [], tong_tien: 0, so_luong: 0 };
            }
        }
    }

    // Update cart badge in navbar
    updateCartBadge() {
        const cartBadge = document.getElementById('cart-badge');
        const cartBadgeMobile = document.getElementById('cart-badge-mobile');

        const count = this.cart.so_luong || 0;
        const displayStyle = count > 0 ? 'inline-block' : 'none';

        if (cartBadge) {
            cartBadge.textContent = count;
            cartBadge.style.display = displayStyle;
        }

        if (cartBadgeMobile) {
            cartBadgeMobile.textContent = count;
            cartBadgeMobile.style.display = displayStyle;
        }
    }

    // Show notification (requires auth.js showNotification function)
    showNotification(message, type = 'info') {
        if (typeof showNotification === 'function') {
            showNotification(message, type);
        } else {
            // Fallback notification
            console.log(`${type.toUpperCase()}: ${message}`);
            alert(message);
        }
    }

    // Format currency
    formatCurrency(amount) {
        return new Intl.NumberFormat('vi-VN', {
            style: 'currency',
            currency: 'VND'
        }).format(amount);
    }

    // Render cart items in a container
    renderCartItems(containerId) {
        const container = document.getElementById(containerId);
        if (!container) return;

        if (this.cart.items.length === 0) {
            container.innerHTML = `
                <div class="text-center py-8">
                    <i class="fas fa-shopping-cart text-4xl text-gray-300 mb-4"></i>
                    <p class="text-gray-500">Giỏ hàng trống</p>
                </div>
            `;
            return;
        }

        container.innerHTML = this.cart.items.map(item => `
            <div class="flex items-center justify-between p-4 border-b">
                <div class="flex items-center space-x-4">
                    <img src="${item.anh_mon || '/images/default-dish.jpg'}"
                         alt="${item.ten_mon}"
                         class="w-16 h-16 object-cover rounded">
                    <div>
                        <h4 class="font-medium">${item.ten_mon}</h4>
                        <p class="text-sm text-gray-500">${this.formatCurrency(item.gia_tai_thoi_diem)} / ${item.don_vi_tinh}</p>
                    </div>
                </div>
                <div class="flex items-center space-x-2">
                    <button onclick="cartManager.updateCartItem(${item.ma_chi_tiet}, ${item.so_luong - 1})"
                            class="w-8 h-8 bg-gray-200 rounded-full flex items-center justify-center hover:bg-gray-300">
                        <i class="fas fa-minus text-sm"></i>
                    </button>
                    <span class="w-8 text-center">${item.so_luong}</span>
                    <button onclick="cartManager.updateCartItem(${item.ma_chi_tiet}, ${item.so_luong + 1})"
                            class="w-8 h-8 bg-gray-200 rounded-full flex items-center justify-center hover:bg-gray-300">
                        <i class="fas fa-plus text-sm"></i>
                    </button>
                    <button onclick="cartManager.removeFromCart(${item.ma_chi_tiet})"
                            class="ml-4 text-red-500 hover:text-red-700">
                        <i class="fas fa-trash"></i>
                    </button>
                </div>
            </div>
        `).join('');

        // Add total section
        container.innerHTML += `
            <div class="p-4 bg-gray-50">
                <div class="flex justify-between items-center font-bold text-lg">
                    <span>Tổng cộng:</span>
                    <span>${this.formatCurrency(this.cart.tong_tien)}</span>
                </div>
            </div>
        `;
    }
}

// Global cart manager instance
const cartManager = new CartManager();

// Export for use in other modules
if (typeof module !== 'undefined' && module.exports) {
    module.exports = CartManager;
}
