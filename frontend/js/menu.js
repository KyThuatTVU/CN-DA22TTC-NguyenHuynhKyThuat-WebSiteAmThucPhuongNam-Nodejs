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
        const url = categoryId 
            ? `${API_URL}/menu/category/${categoryId}`
            : `${API_URL}/menu`;
        
        const response = await fetch(url);
        const result = await response.json();
        
        if (result.success) {
            menuProducts = result.data;
            renderMenuProducts();
            updateProductCount();
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
        <div class="card-hover bg-white rounded-xl overflow-hidden shadow-sm">
            <div class="relative bg-gray-50">
                <img src="http://localhost:3000${product.anh_mon || '/images/placeholder.jpg'}" 
                     alt="${product.ten_mon}" 
                     class="w-full h-48 object-contain"
                     onerror="this.onerror=null; this.src='images/placeholder.jpg'">
                ${product.trang_thai === 0 ? `<span class="absolute top-3 left-3 bg-gray-500 text-white px-3 py-1 rounded-full text-sm font-medium">Hết hàng</span>` : ''}
                <button class="absolute top-3 right-3 bg-white w-10 h-10 rounded-full flex items-center justify-center text-gray-600 hover:text-red-500 transition">
                    <i class="far fa-heart"></i>
                </button>
            </div>
            <div class="p-4">
                <h3 class="font-medium text-lg mb-2 text-gray-800">${product.ten_mon}</h3>
                <p class="text-gray-500 text-sm mb-2 line-clamp-2">${product.mo_ta_chi_tiet || ''}</p>
                <div class="flex items-center mb-2">
                    <div class="text-yellow-400 text-sm">
                        ${generateStars(4.5)}
                    </div>
                    <span class="text-gray-500 text-sm ml-2">(${Math.floor(Math.random() * 100) + 20})</span>
                </div>
                <div class="flex items-center justify-between">
                    <div>
                        <span class="text-orange-600 font-bold text-xl">${formatPrice(parseFloat(product.gia_tien))}</span>
                        <div class="text-xs text-gray-500 mt-1">
                            <i class="fas fa-box"></i> ${product.so_luong_ton} ${product.don_vi_tinh}
                        </div>
                    </div>
                    <button onclick="addToCart(${product.ma_mon})" 
                            ${product.trang_thai === 0 || product.so_luong_ton === 0 ? 'disabled' : ''}
                            class="bg-orange-600 text-white w-10 h-10 rounded-full hover:bg-orange-700 transition disabled:bg-gray-400 disabled:cursor-not-allowed">
                        <i class="fas fa-plus"></i>
                    </button>
                </div>
            </div>
        </div>
    `).join('');
}

// Show error message
function showError() {
    const container = document.getElementById('menu-products');
    if (!container) return;
    
    container.innerHTML = `
        <div class="col-span-full text-center py-12">
            <i class="fas fa-exclamation-triangle text-6xl text-red-300 mb-4"></i>
            <p class="text-gray-500 text-lg">Không thể tải dữ liệu. Vui lòng thử lại sau.</p>
            <button onclick="fetchMenuProducts()" class="mt-4 bg-orange-600 text-white px-6 py-2 rounded-lg hover:bg-orange-700">
                Thử lại
            </button>
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
