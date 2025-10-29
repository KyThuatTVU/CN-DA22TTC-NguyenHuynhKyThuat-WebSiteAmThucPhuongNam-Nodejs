// Render cart
function renderCart() {
    const cartItemsContainer = document.getElementById('cart-items');
    const emptyCart = document.getElementById('empty-cart');
    const cartCount = document.getElementById('cart-count');
    const checkoutBtn = document.getElementById('checkout-btn');
    
    if (!cartItemsContainer) return;

    if (cart.length === 0) {
        cartItemsContainer.innerHTML = '';
        if (emptyCart) emptyCart.classList.remove('hidden');
        if (checkoutBtn) checkoutBtn.classList.add('opacity-50', 'pointer-events-none');
        updateCartSummary();
        return;
    }

    if (emptyCart) emptyCart.classList.add('hidden');
    if (checkoutBtn) checkoutBtn.classList.remove('opacity-50', 'pointer-events-none');
    
    if (cartCount) cartCount.textContent = cart.length;

    cartItemsContainer.innerHTML = cart.map(item => `
        <div class="flex gap-4 py-4 border-b last:border-b-0">
            <img src="${item.image}" alt="${item.name}" class="w-24 h-24 object-cover rounded-lg">
            <div class="flex-1">
                <h3 class="font-medium text-lg mb-1">${item.name}</h3>
                <p class="text-orange-600 font-bold mb-2">${formatCurrency(item.price)}</p>
                <div class="flex items-center space-x-3">
                    <button onclick="updateQuantity(${item.id}, -1)" class="w-8 h-8 rounded-full border flex items-center justify-center hover:bg-gray-100 transition">
                        <i class="fas fa-minus text-sm"></i>
                    </button>
                    <span class="font-medium w-8 text-center">${item.quantity}</span>
                    <button onclick="updateQuantity(${item.id}, 1)" class="w-8 h-8 rounded-full border flex items-center justify-center hover:bg-gray-100 transition">
                        <i class="fas fa-plus text-sm"></i>
                    </button>
                </div>
            </div>
            <div class="flex flex-col items-end justify-between">
                <button onclick="removeFromCart(${item.id})" class="text-red-500 hover:text-red-700 transition">
                    <i class="fas fa-trash"></i>
                </button>
                <p class="font-bold text-lg">${formatCurrency(item.price * item.quantity)}</p>
            </div>
        </div>
    `).join('');

    updateCartSummary();
}

// Update cart summary
function updateCartSummary() {
    const subtotal = cart.reduce((sum, item) => sum + (item.price * item.quantity), 0);
    const shipping = subtotal > 0 ? 30000 : 0;
    const discount = 0;
    const total = subtotal + shipping - discount;

    const subtotalEl = document.getElementById('subtotal');
    const shippingEl = document.getElementById('shipping');
    const discountEl = document.getElementById('discount');
    const totalEl = document.getElementById('total');

    if (subtotalEl) subtotalEl.textContent = formatCurrency(subtotal);
    if (shippingEl) shippingEl.textContent = subtotal > 0 ? formatCurrency(shipping) : 'Miễn phí';
    if (discountEl) discountEl.textContent = `-${formatCurrency(discount)}`;
    if (totalEl) totalEl.textContent = formatCurrency(total);
}

// Initialize cart page
document.addEventListener('DOMContentLoaded', function() {
    if (document.getElementById('cart-items')) {
        renderCart();
    }
});
