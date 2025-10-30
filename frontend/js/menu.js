// API Configuration
const API_URL = 'http://localhost:3000/api';

// State
let menuProducts = [];
let categories = [];
let selectedCategory = null;

// Fetch categories from API
async function fetchCategories() {
    try {
        const response = await fetch(`${API_URL}/categories`);
        const result = await response.json();
        if (result.success) {
            categories = result.data;
            renderCategoryFilters();
        }
    } catch (error) {
        console.error('Lỗi khi tải danh mục:', error);
    }
}

// Fetch menu products from API
async function fetchMenuProducts(categoryId = null) {
    try {
        showLoading();
        
        const url = categoryId 
            ? `${API_URL}/menu/category/${categoryId}`
            : `${API_URL}/menu`;
        
        const response = await fetch(url);
        const result = await response.json();
        
        if (result.success) {
            menuProducts = result.data;
            
            // Simulate loading for smooth transition
            setTimeout(() => {
                renderMenuProducts();
                updateProductCount();
            }, 300);
        }
    } catch (error) {
        console.error('Lỗi khi tải món ăn:', error);
        showError();
    }
}

// Render category filters
function renderCategoryFilters() {
    const categoryContainer = document.querySelector('.space-y-2');
    if (!categoryContainer) return;

    const categoryHTML = `
        <label class="flex items-center cursor-pointer">
            <input type="checkbox" class="w-4 h-4 text-orange-600 rounded category-filter" 
                   data-category="all" ${!selectedCategory ? 'checked' : ''}>
            <span class="ml-2 text-gray-700">Tất cả</span>
        </label>
        ${categories.map(cat => `
            <label class="flex items-center cursor-pointer">
                <input type="checkbox" class="w-4 h-4 text-orange-600 rounded category-filter" 
                       data-category="${cat.ma_danh_muc}" 
                       ${selectedCategory === cat.ma_danh_muc ? 'checked' : ''}>
                <span class="ml-2 text-gray-700">${cat.ten_danh_muc}</span>
            </label>
        `).join('')}
    `;
    
    categoryContainer.innerHTML = categoryHTML;

    // Add event listeners
    document.querySelectorAll('.category-filter').forEach(checkbox => {
        checkbox.addEventListener('change', function() {
            // Uncheck all others
            document.querySelectorAll('.category-filter').forEach(cb => {
                if (cb !== this) cb.checked = false;
            });
            
            const category = this.dataset.category;
            selectedCategory = category === 'all' ? null : parseInt(category);
            fetchMenuProducts(selectedCategory);
            
            // Smooth scroll to products
            if (typeof window.smoothScrollToProducts === 'function') {
                window.smoothScrollToProducts();
            }
        });
    });
}

// Render products
function renderMenuProducts() {
    const container = document.getElementById('menu-products');
    if (!container) return;

    if (menuProducts.length === 0) {
        container.innerHTML = `
            <div class="col-span-full text-center py-12">
                <i class="fas fa-utensils text-6xl text-gray-300 mb-4"></i>
                <p class="text-gray-500 text-lg">Không tìm thấy món ăn nào</p>
            </div>
        `;
        return;
    }

    container.innerHTML = menuProducts.map(product => `
        <div class="dish-card bg-white rounded-2xl overflow-hidden shadow-md">
            <!-- Image Container -->
            <div class="dish-image-container">
                <img src="http://localhost:3000${product.anh_mon || '/images/placeholder.jpg'}" 
                     alt="${product.ten_mon}" 
                     class="dish-image"
                     loading="lazy"
                     onerror="this.onerror=null; this.src='images/placeholder.svg'; this.style.objectFit='contain';">
                
                <!-- Overlay -->
                <div class="image-overlay"></div>
                
                <!-- Badges -->
                <div class="absolute top-3 left-3 flex flex-col gap-2">
                    ${product.trang_thai === 0 || product.so_luong_ton === 0 
                        ? `<span class="badge-status text-white px-3 py-1.5 rounded-full text-xs font-semibold">
                            <i class="fas fa-times-circle mr-1"></i>Hết hàng
                           </span>` 
                        : product.so_luong_ton < 10 
                        ? `<span class="badge-status bg-yellow-500 text-white px-3 py-1.5 rounded-full text-xs font-semibold">
                            <i class="fas fa-exclamation-triangle mr-1"></i>Sắp hết
                           </span>`
                        : ''}
                    ${product.ten_danh_muc 
                        ? `<span class="category-badge text-orange-600 px-3 py-1.5 rounded-full text-xs font-semibold">
                            <i class="fas fa-tag mr-1"></i>${product.ten_danh_muc}
                           </span>`
                        : ''}
                </div>
                
                <!-- Favorite Button -->
                <button class="favorite-btn absolute top-3 right-3 bg-white w-11 h-11 rounded-full flex items-center justify-center text-gray-600 shadow-lg hover:shadow-xl">
                    <i class="far fa-heart text-lg"></i>
                </button>
            </div>
            
            <!-- Content -->
            <div class="p-5">
                <!-- Title -->
                <h3 class="font-bold text-lg mb-2 text-gray-800 line-clamp-1 hover:text-orange-600 transition cursor-pointer">
                    ${product.ten_mon}
                </h3>
                
                <!-- Description -->
                <p class="text-gray-500 text-sm mb-3 line-clamp-2 leading-relaxed">
                    ${product.mo_ta_chi_tiet || 'Món ăn đặc sắc, hương vị đậm đà'}
                </p>
                
                <!-- Rating -->
                <div class="flex items-center mb-3">
                    <div class="text-yellow-400 text-sm">
                        ${generateStars(4.5)}
                    </div>
                    <span class="text-gray-500 text-sm ml-2 font-medium">(${Math.floor(Math.random() * 100) + 20})</span>
                    <span class="text-gray-300 mx-2">•</span>
                    <span class="text-gray-500 text-xs">
                        <i class="fas fa-box-open mr-1"></i>${product.so_luong_ton} ${product.don_vi_tinh}
                    </span>
                </div>
                
                <!-- Price & Action -->
                <div class="flex items-center justify-between pt-3 border-t border-gray-100">
                    <div class="flex flex-col">
                        <span class="price-tag text-2xl font-bold">
                            ${formatPrice(parseFloat(product.gia_tien))}
                        </span>
                        <span class="text-xs text-gray-400 mt-0.5">
                            <i class="fas fa-shipping-fast mr-1"></i>Miễn phí ship
                        </span>
                    </div>
                    <button onclick="addToCart(${product.ma_mon})" 
                            ${product.trang_thai === 0 || product.so_luong_ton === 0 ? 'disabled' : ''}
                            class="add-to-cart-btn bg-gradient-to-r from-orange-500 to-red-500 text-white w-12 h-12 rounded-full hover:from-orange-600 hover:to-red-600 disabled:from-gray-300 disabled:to-gray-400 disabled:cursor-not-allowed disabled:transform-none flex items-center justify-center">
                        <i class="fas fa-shopping-cart text-lg"></i>
                    </button>
                </div>
            </div>
        </div>
    `).join('');
}

// Show loading skeleton
function showLoading() {
    const container = document.getElementById('menu-products');
    if (!container) return;
    
    const skeletonHTML = Array(6).fill(0).map(() => `
        <div class="bg-white rounded-2xl overflow-hidden shadow-md">
            <div class="skeleton h-64 w-full"></div>
            <div class="p-5">
                <div class="skeleton h-6 w-3/4 mb-3 rounded"></div>
                <div class="skeleton h-4 w-full mb-2 rounded"></div>
                <div class="skeleton h-4 w-2/3 mb-4 rounded"></div>
                <div class="flex justify-between items-center">
                    <div class="skeleton h-8 w-24 rounded"></div>
                    <div class="skeleton h-12 w-12 rounded-full"></div>
                </div>
            </div>
        </div>
    `).join('');
    
    container.innerHTML = skeletonHTML;
}

// Show error message
function showError() {
    const container = document.getElementById('menu-products');
    if (!container) return;
    
    container.innerHTML = `
        <div class="col-span-full text-center py-16">
            <div class="inline-block p-8 bg-red-50 rounded-2xl">
                <i class="fas fa-exclamation-triangle text-6xl text-red-400 mb-4"></i>
                <p class="text-gray-700 text-lg font-medium mb-2">Không thể tải dữ liệu</p>
                <p class="text-gray-500 text-sm mb-4">Vui lòng kiểm tra kết nối và thử lại</p>
                <button onclick="fetchMenuProducts()" class="bg-gradient-to-r from-orange-500 to-red-500 text-white px-6 py-3 rounded-lg hover:from-orange-600 hover:to-red-600 transition shadow-lg">
                    <i class="fas fa-redo mr-2"></i>Thử lại
                </button>
            </div>
        </div>
    `;
}

// Update product count
function updateProductCount() {
    const countElement = document.querySelector('.text-gray-600 strong');
    if (countElement) {
        countElement.textContent = menuProducts.length;
    }
}

// Generate stars
function generateStars(rating) {
    const fullStars = Math.floor(rating);
    const hasHalfStar = rating % 1 !== 0;
    let stars = '';
    
    for (let i = 0; i < fullStars; i++) {
        stars += '<i class="fas fa-star"></i>';
    }
    
    if (hasHalfStar) {
        stars += '<i class="fas fa-star-half-alt"></i>';
    }
    
    const emptyStars = 5 - Math.ceil(rating);
    for (let i = 0; i < emptyStars; i++) {
        stars += '<i class="far fa-star"></i>';
    }
    
    return stars;
}

// Format price
function formatPrice(price) {
    return new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' }).format(price);
}

// Initialize on page load
document.addEventListener('DOMContentLoaded', () => {
    fetchCategories();
    fetchMenuProducts();
});
