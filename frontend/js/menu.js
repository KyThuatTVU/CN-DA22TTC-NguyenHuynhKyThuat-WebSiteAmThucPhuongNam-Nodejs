// Sample menu data
const menuProducts = [
    { id: 1, name: 'Cá Lóc Nướng Trui', price: 200000, oldPrice: 250000, image: 'https://images.unsplash.com/photo-1559847844-5315695dadae?w=400', rating: 5, reviews: 128, discount: 20 },
    { id: 2, name: 'Lẩu Mắm Miền Tây', price: 350000, oldPrice: null, image: 'https://images.unsplash.com/photo-1625944525533-473f1a3d54e7?w=400', rating: 4.5, reviews: 95 },
    { id: 3, name: 'Gỏi Cuốn Tôm Thịt', price: 85000, oldPrice: 100000, image: 'https://images.unsplash.com/photo-1534422298391-e4f8c172dddb?w=400', rating: 4, reviews: 67, discount: 15 },
    { id: 4, name: 'Bánh Xèo Miền Tây', price: 120000, oldPrice: null, image: 'https://images.unsplash.com/photo-1563379091339-03b21ab4a4f8?w=400', rating: 5, reviews: 145 },
    { id: 5, name: 'Hủ Tiếu Nam Vang', price: 65000, oldPrice: null, image: 'https://images.unsplash.com/photo-1582878826629-29b7ad1cdc43?w=400', rating: 4.5, reviews: 89 },
    { id: 6, name: 'Bánh Tằm Bì', price: 55000, oldPrice: 70000, image: 'https://images.unsplash.com/photo-1569562211093-4ed0d0758f12?w=400', rating: 4, reviews: 56, discount: 21 },
    { id: 7, name: 'Canh Chua Cá Lóc', price: 180000, oldPrice: null, image: 'https://images.unsplash.com/photo-1604329760661-e71dc83f8f26?w=400', rating: 5, reviews: 112 },
    { id: 8, name: 'Gà Nướng Mật Ong', price: 280000, oldPrice: null, image: 'https://images.unsplash.com/photo-1598103442097-8b74394b95c6?w=400', rating: 4.5, reviews: 98 },
    { id: 9, name: 'Tôm Sú Nướng', price: 450000, oldPrice: 500000, image: 'https://images.unsplash.com/photo-1633504581786-316c8002b1b9?w=400', rating: 5, reviews: 134, discount: 10 },
    { id: 10, name: 'Cơm Chiên Dương Châu', price: 75000, oldPrice: null, image: 'https://images.unsplash.com/photo-1603133872878-684f208fb84b?w=400', rating: 4, reviews: 78 },
    { id: 11, name: 'Mì Xào Hải Sản', price: 95000, oldPrice: null, image: 'https://images.unsplash.com/photo-1612874742237-6526221588e3?w=400', rating: 4.5, reviews: 65 },
    { id: 12, name: 'Cá Kho Tộ', price: 160000, oldPrice: 180000, image: 'https://images.unsplash.com/photo-1534604973900-c43ab4c2e0ab?w=400', rating: 5, reviews: 103, discount: 11 },
    { id: 13, name: 'Bò Lúc Lắc', price: 220000, oldPrice: null, image: 'https://images.unsplash.com/photo-1544025162-d76694265947?w=400', rating: 4.5, reviews: 91 },
    { id: 14, name: 'Rau Muống Xào Tỏi', price: 45000, oldPrice: null, image: 'https://images.unsplash.com/photo-1576045057995-568f588f82fb?w=400', rating: 4, reviews: 45 },
    { id: 15, name: 'Ốc Hương Xào Bơ', price: 180000, oldPrice: 200000, image: 'https://images.unsplash.com/photo-1599421258361-ca2f5e2f03c7?w=400', rating: 5, reviews: 87, discount: 10 },
    { id: 16, name: 'Chả Giò Rế', price: 80000, oldPrice: null, image: 'https://images.unsplash.com/photo-1601050690597-df0568f70950?w=400', rating: 4.5, reviews: 72 },
    { id: 17, name: 'Nước Dừa Tươi', price: 25000, oldPrice: null, image: 'https://images.unsplash.com/photo-1585217732046-e5f69f92a046?w=400', rating: 5, reviews: 156 },
    { id: 18, name: 'Trà Đá Chanh', price: 15000, oldPrice: null, image: 'https://images.unsplash.com/photo-1556679343-c7306c1976bc?w=400', rating: 4, reviews: 89 }
];

// Render products
function renderMenuProducts() {
    const container = document.getElementById('menu-products');
    if (!container) return;

    container.innerHTML = menuProducts.map(product => `
        <div class="card-hover bg-white rounded-xl overflow-hidden shadow-sm">
            <div class="relative">
                <img src="${product.image}" alt="${product.name}" class="w-full h-48 object-cover">
                ${product.discount ? `<span class="absolute top-3 left-3 badge-discount text-white px-3 py-1 rounded-full text-sm font-medium">-${product.discount}%</span>` : ''}
                <button class="absolute top-3 right-3 bg-white w-10 h-10 rounded-full flex items-center justify-center text-gray-600 hover:text-red-500 transition">
                    <i class="far fa-heart"></i>
                </button>
            </div>
            <div class="p-4">
                <h3 class="font-medium text-lg mb-2 text-gray-800">${product.name}</h3>
                <div class="flex items-center mb-2">
                    <div class="text-yellow-400 text-sm">
                        ${generateStars(product.rating)}
                    </div>
                    <span class="text-gray-500 text-sm ml-2">(${product.reviews})</span>
                </div>
                <div class="flex items-center justify-between">
                    <div>
                        <span class="text-orange-600 font-bold text-xl">${formatPrice(product.price)}</span>
                        ${product.oldPrice ? `<span class="text-gray-400 line-through text-sm ml-2">${formatPrice(product.oldPrice)}</span>` : ''}
                    </div>
                    <button onclick="addToCart(${product.id})" class="bg-orange-600 text-white w-10 h-10 rounded-full hover:bg-orange-700 transition">
                        <i class="fas fa-plus"></i>
                    </button>
                </div>
            </div>
        </div>
    `).join('');
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
document.addEventListener('DOMContentLoaded', renderMenuProducts);
