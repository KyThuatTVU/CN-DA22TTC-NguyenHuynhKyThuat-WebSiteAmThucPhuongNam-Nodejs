// API Configuration
if (typeof window.API_URL === 'undefined') {
    window.API_URL = 'http://localhost:3000/api';
}

// Get product ID from URL
const urlParams = new URLSearchParams(window.location.search);
const productId = urlParams.get('id');

let currentProduct = null;
let relatedProducts = [];

// Format price
function formatPrice(price) {
    return new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' }).format(price);
}

// Fetch product detail
async function fetchProductDetail() {
    if (!productId) {
        console.warn('⚠️ Không có product ID, chuyển về trang thực đơn');
        window.location.href = 'thuc-don.html';
        return;
    }

    try {
        console.log('🔍 Đang tải chi tiết món ăn ID:', productId);
        showLoading();
        
        const url = `${window.API_URL}/menu/${productId}`;
        console.log('📡 API URL:', url);
        
        const response = await fetch(url);
        const result = await response.json();
        
        console.log('📦 Dữ liệu nhận được:', result);
        
        if (result.success) {
            currentProduct = result.data;
            console.log('✅ Món ăn:', currentProduct.ten_mon);
            console.log('💰 Giá:', currentProduct.gia_tien);
            console.log('🖼️ Ảnh:', currentProduct.anh_mon);
            console.log('📦 Tồn kho:', currentProduct.so_luong_ton, currentProduct.don_vi_tinh);
            
            renderProductDetail();
            fetchRelatedProducts(currentProduct.ma_danh_muc);
            fetchProductImages();
        } else {
            console.error('❌ API trả về lỗi:', result);
            showError();
        }
    } catch (error) {
        console.error('❌ Lỗi khi tải chi tiết món ăn:', error);
        showError();
    }
}

// Fetch product images
async function fetchProductImages() {
    try {
        console.log('🔍 Đang tải ảnh món ăn ID:', productId);
        
        const response = await fetch(`${window.API_URL}/albums/product/${productId}`);
        const result = await response.json();
        
        console.log('📦 Ảnh món ăn:', result);
        
        if (result.success && result.data.length > 0) {
            console.log('✅ Số lượng ảnh:', result.data.length);
            renderThumbnails(result.data);
        } else {
            console.log('ℹ️ Không có ảnh bổ sung, dùng ảnh chính');
            // Use main image only
            renderThumbnails([{ duong_dan_anh: currentProduct.anh_mon }]);
        }
    } catch (error) {
        console.error('❌ Lỗi khi tải ảnh:', error);
        renderThumbnails([{ duong_dan_anh: currentProduct.anh_mon }]);
    }
}

// Fetch related products
async function fetchRelatedProducts(categoryId) {
    try {
        console.log('🔍 Đang tải món ăn liên quan, danh mục:', categoryId);
        
        const response = await fetch(`${window.API_URL}/menu/category/${categoryId}`);
        const result = await response.json();
        
        console.log('📦 Món ăn liên quan:', result);
        
        if (result.success) {
            // Filter out current product and limit to 4
            relatedProducts = result.data
                .filter(p => p.ma_mon !== parseInt(productId))
                .slice(0, 4);
            
            console.log('✅ Số món liên quan:', relatedProducts.length);
            renderRelatedProducts();
        }
    } catch (error) {
        console.error('❌ Lỗi khi tải món ăn liên quan:', error);
    }
}

// Render product detail
function renderProductDetail() {
    if (!currentProduct) return;

    // Update page title
    document.title = `${currentProduct.ten_mon} - Nhà hàng Phương Nam`;
    
    // Breadcrumb
    const breadcrumbName = document.getElementById('breadcrumb-name');
    if (breadcrumbName) {
        breadcrumbName.textContent = currentProduct.ten_mon;
    }
    
    // Main image
    const mainImage = document.getElementById('main-image');
    if (mainImage) {
        mainImage.src = `http://localhost:3000${currentProduct.anh_mon}`;
        mainImage.alt = currentProduct.ten_mon;
        mainImage.onerror = function() {
            this.src = 'images/placeholder.svg';
        };
    }
    
    // Badges
    const badgesContainer = document.getElementById('image-badges');
    let badges = '';
    
    if (currentProduct.trang_thai === 0 || currentProduct.so_luong_ton === 0) {
        badges += `<span class="badge-tag bg-gray-800 text-white px-4 py-2 rounded-full text-sm font-semibold">
            <i class="fas fa-times-circle mr-1"></i>Hết hàng
        </span>`;
    } else if (currentProduct.so_luong_ton < 10) {
        badges += `<span class="badge-tag bg-yellow-500 text-white px-4 py-2 rounded-full text-sm font-semibold">
            <i class="fas fa-exclamation-triangle mr-1"></i>Sắp hết
        </span>`;
    }
    
    badgesContainer.innerHTML = badges;
    
    // Category badge
    const categoryBadge = document.getElementById('category-badge');
    if (categoryBadge && currentProduct.ten_danh_muc) {
        categoryBadge.innerHTML = `<i class="fas fa-tag mr-1"></i>${currentProduct.ten_danh_muc}`;
    }
    
    // Product name
    const productName = document.getElementById('product-name');
    if (productName) {
        productName.textContent = currentProduct.ten_mon;
    }
    
    // Price
    const productPrice = document.getElementById('product-price');
    if (productPrice) {
        productPrice.textContent = formatPrice(parseFloat(currentProduct.gia_tien));
    }
    
    // Stock
    const stockQuantity = document.getElementById('stock-quantity');
    const stockUnit = document.getElementById('stock-unit');
    if (stockQuantity) stockQuantity.textContent = currentProduct.so_luong_ton;
    if (stockUnit) stockUnit.textContent = currentProduct.don_vi_tinh;
    
    // Description
    const description = currentProduct.mo_ta_chi_tiet || 'Món ăn đặc sắc với hương vị đậm đà, được chế biến từ nguyên liệu tươi ngon, đảm bảo vệ sinh an toàn thực phẩm.';
    const productDesc = document.getElementById('product-description');
    if (productDesc) {
        productDesc.textContent = description;
    }
    
    // Update quantity max
    const quantityInput = document.getElementById('quantity');
    if (quantityInput) {
        quantityInput.max = currentProduct.so_luong_ton;
    }
    
    // Trigger animations
    if (typeof window.animateProductDetail === 'function') {
        setTimeout(() => window.animateProductDetail(), 100);
    }
}

// Render thumbnails
function renderThumbnails(images) {
    const container = document.getElementById('thumbnails');
    
    // Add main image first
    const allImages = [
        { duong_dan_anh: currentProduct.anh_mon },
        ...images.filter(img => img.duong_dan_anh !== currentProduct.anh_mon)
    ];
    
    container.innerHTML = allImages.slice(0, 4).map((img, index) => `
        <div class="thumbnail ${index === 0 ? 'thumbnail-active' : ''} rounded-lg overflow-hidden border-2 border-gray-200"
             onclick="changeMainImage('${img.duong_dan_anh}', this)">
            <img src="http://localhost:3000${img.duong_dan_anh}" 
                 alt="Ảnh ${index + 1}" 
                 class="w-full h-24 object-cover"
                 onerror="this.src='images/placeholder.svg'">
        </div>
    `).join('');
    
    // Animate thumbnails after render
    if (typeof window.animateProductDetail === 'function') {
        setTimeout(() => {
            const thumbnails = document.querySelectorAll('#thumbnails > div');
            if (thumbnails.length > 0) {
                gsap.from(thumbnails, {
                    opacity: 0,
                    y: 20,
                    duration: 0.5,
                    stagger: 0.1,
                    ease: 'power2.out'
                });
            }
        }, 100);
    }
}

// Change main image
function changeMainImage(imagePath, element) {
    const mainImage = document.getElementById('main-image');
    mainImage.src = `http://localhost:3000${imagePath}`;
    
    // Update active thumbnail
    document.querySelectorAll('.thumbnail').forEach(thumb => {
        thumb.classList.remove('thumbnail-active');
    });
    element.classList.add('thumbnail-active');
}

// Render related products
function renderRelatedProducts() {
    const container = document.getElementById('related-products');
    if (!container) return;
    
    if (relatedProducts.length === 0) {
        container.innerHTML = '<p class="col-span-full text-center text-gray-500">Không có món ăn liên quan</p>';
        return;
    }
    
    container.innerHTML = relatedProducts.map(product => `
        <a href="chitietmonan.html?id=${product.ma_mon}" class="related-card block bg-white rounded-xl overflow-hidden shadow-sm hover:shadow-md transition-all">
            <div class="relative bg-gray-50">
                <img src="http://localhost:3000${product.anh_mon}" 
                     alt="${product.ten_mon}" 
                     class="w-full h-40 sm:h-48 md:h-52 object-cover"
                     loading="lazy"
                     onerror="this.onerror=null; this.src='images/placeholder.svg';">
                ${product.trang_thai === 0 || product.so_luong_ton === 0 
                    ? '<span class="absolute top-2 left-2 bg-gray-800 bg-opacity-90 text-white px-2 py-1 rounded-full text-xs font-medium">Hết hàng</span>'
                    : ''}
            </div>
            <div class="p-3 md:p-4">
                <h3 class="font-semibold text-sm md:text-base mb-2 text-gray-800 line-clamp-2 hover:text-orange-600 transition">${product.ten_mon}</h3>
                <div class="flex items-center justify-between">
                    <span class="text-orange-600 font-bold text-base md:text-lg">${formatPrice(parseFloat(product.gia_tien))}</span>
                    <span class="text-yellow-400 text-sm flex items-center gap-1">
                        <i class="fas fa-star"></i>
                        <span class="text-gray-600 font-medium">4.5</span>
                    </span>
                </div>
            </div>
        </a>
    `).join('');
    
    console.log('✅ Rendered', relatedProducts.length, 'related products');
    
    // Animate related products
    if (typeof window.animateRelatedProducts === 'function') {
        setTimeout(() => {
            console.log('🎬 Animating related products...');
            window.animateRelatedProducts();
        }, 100);
    }
    
    // Debug: Check opacity after render
    setTimeout(() => {
        const cards = document.querySelectorAll('#related-products > a');
        cards.forEach((card, i) => {
            const styles = window.getComputedStyle(card);
            console.log(`Card ${i} opacity:`, styles.opacity);
        });
    }, 500);
}

// Quantity controls
function increaseQuantity() {
    const input = document.getElementById('quantity');
    const max = parseInt(input.max);
    const current = parseInt(input.value);
    
    if (current < max) {
        input.value = current + 1;
    }
}

function decreaseQuantity() {
    const input = document.getElementById('quantity');
    const min = parseInt(input.min);
    const current = parseInt(input.value);
    
    if (current > min) {
        input.value = current - 1;
    }
}

// Add to cart
function addToCart() {
    const quantity = parseInt(document.getElementById('quantity').value);

    if (!currentProduct) {
        console.error('Không có thông tin món ăn');
        return;
    }

    // Use cartManager if available
    if (typeof cartManager !== 'undefined') {
        cartManager.addToCart(currentProduct.ma_mon, quantity);
    } else {
        console.warn('CartManager not loaded, using fallback');
        // Fallback to old localStorage method
        let cart = JSON.parse(localStorage.getItem('cart') || '[]');

        const existingIndex = cart.findIndex(item => item.ma_mon === currentProduct.ma_mon);

        if (existingIndex > -1) {
            cart[existingIndex].quantity += quantity;
        } else {
            cart.push({
                ma_mon: currentProduct.ma_mon,
                ten_mon: currentProduct.ten_mon,
                gia_tien: currentProduct.gia_tien,
                anh_mon: currentProduct.anh_mon,
                quantity: quantity
            });
        }

        localStorage.setItem('cart', JSON.stringify(cart));

        if (typeof showNotification === 'function') {
            showNotification(`Đã thêm ${quantity} ${currentProduct.don_vi_tinh} ${currentProduct.ten_mon} vào giỏ hàng!`, 'success');
        }

        updateCartBadge();
    }
}

// Buy now
function buyNow() {
    addToCart();
    window.location.href = 'gio-hang.html';
}

// Update cart badge
function updateCartBadge() {
    // Use cartManager if available
    if (typeof cartManager !== 'undefined' && cartManager.updateCartBadge) {
        cartManager.updateCartBadge();
    } else {
        // Fallback to old method
        const cart = JSON.parse(localStorage.getItem('cart') || '[]');
        const totalItems = cart.reduce((sum, item) => sum + item.quantity, 0);

        const badge = document.querySelector('.cart-badge');
        if (badge) {
            badge.textContent = totalItems;
        }
    }
}

// Show loading
function showLoading() {
    const productName = document.getElementById('product-name');
    const productPrice = document.getElementById('product-price');
    const productDesc = document.getElementById('product-description');
    
    if (productName) productName.textContent = 'Đang tải...';
    if (productPrice) productPrice.textContent = '...';
    if (productDesc) productDesc.textContent = 'Đang tải thông tin món ăn...';
}

// Show error
function showError() {
    document.querySelector('.container').innerHTML = `
        <div class="text-center py-20">
            <i class="fas fa-exclamation-triangle text-6xl text-red-400 mb-4"></i>
            <h2 class="text-2xl font-bold text-gray-800 mb-2">Không tìm thấy món ăn</h2>
            <p class="text-gray-600 mb-6">Món ăn bạn tìm kiếm không tồn tại hoặc đã bị xóa</p>
            <a href="thuc-don.html" class="inline-block bg-orange-600 text-white px-6 py-3 rounded-lg hover:bg-orange-700 transition">
                <i class="fas fa-arrow-left mr-2"></i>Quay lại thực đơn
            </a>
        </div>
    `;
}

// Initialize
document.addEventListener('DOMContentLoaded', () => {
    fetchProductDetail();
    updateCartBadge();
});
