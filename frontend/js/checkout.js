// Render checkout items
function renderCheckoutItems() {
    const container = document.getElementById('checkout-items');
    if (!container) return;

    if (cart.length === 0) {
        container.innerHTML = '<p class="text-gray-500 text-center">Giỏ hàng trống</p>';
        return;
    }

    container.innerHTML = cart.map(item => `
        <div class="flex items-center gap-3">
            <div class="relative">
                <img src="${item.image}" alt="${item.name}" class="w-16 h-16 object-cover rounded">
                <span class="absolute -top-2 -right-2 bg-orange-600 text-white w-6 h-6 rounded-full text-xs flex items-center justify-center">
                    ${item.quantity}
                </span>
            </div>
            <div class="flex-1">
                <p class="font-medium text-sm">${item.name}</p>
                <p class="text-orange-600 text-sm">${formatCurrency(item.price)}</p>
            </div>
            <p class="font-bold">${formatCurrency(item.price * item.quantity)}</p>
        </div>
    `).join('');

    updateCheckoutSummary();
}

// Update checkout summary
function updateCheckoutSummary() {
    const subtotal = cart.reduce((sum, item) => sum + (item.price * item.quantity), 0);
    const shipping = subtotal > 0 ? 30000 : 0;
    const discount = 0;
    const total = subtotal + shipping - discount;

    const subtotalEl = document.getElementById('checkout-subtotal');
    const shippingEl = document.getElementById('checkout-shipping');
    const discountEl = document.getElementById('checkout-discount');
    const totalEl = document.getElementById('checkout-total');

    if (subtotalEl) subtotalEl.textContent = formatCurrency(subtotal);
    if (shippingEl) shippingEl.textContent = formatCurrency(shipping);
    if (discountEl) discountEl.textContent = `-${formatCurrency(discount)}`;
    if (totalEl) totalEl.textContent = formatCurrency(total);
}

// Handle payment method change
document.addEventListener('DOMContentLoaded', function() {
    renderCheckoutItems();

    // Payment method toggle
    const paymentOptions = document.querySelectorAll('.payment-option');
    const qrSection = document.getElementById('qr-code-section');
    
    paymentOptions.forEach(option => {
        option.addEventListener('click', function() {
            paymentOptions.forEach(opt => opt.classList.remove('active'));
            this.classList.add('active');
            
            const radio = this.querySelector('input[type="radio"]');
            if (radio) radio.checked = true;
            
            // Show QR code if QR payment selected
            if (radio && radio.value === 'qr') {
                qrSection.classList.remove('hidden');
            } else {
                qrSection.classList.add('hidden');
            }
        });
    });
});

// Submit order
function submitOrder() {
    const form = document.getElementById('checkout-form');
    
    if (!form.checkValidity()) {
        form.reportValidity();
        return;
    }

    if (cart.length === 0) {
        alert('Giỏ hàng trống!');
        return;
    }

    // Get selected payment method
    const paymentMethod = document.querySelector('input[name="payment"]:checked').value;
    
    // Show loading
    showNotification('Đang xử lý đơn hàng...', 'info');

    // Simulate order processing
    setTimeout(() => {
        // Clear cart
        cart = [];
        localStorage.setItem('cart', JSON.stringify(cart));
        updateCartBadge();
        
        // Show success message
        showNotification('Đặt hàng thành công!', 'success');
        
        // Redirect to success page
        setTimeout(() => {
            window.location.href = 'dat-hang-thanh-cong.html';
        }, 1500);
    }, 2000);
}

function showNotification(message, type = 'success') {
    const bgColor = type === 'success' ? 'bg-green-500' : type === 'info' ? 'bg-blue-500' : 'bg-red-500';
    const notification = document.createElement('div');
    notification.className = `fixed top-24 right-6 z-50 px-6 py-4 rounded-lg shadow-lg transform transition-all duration-300 ${bgColor} text-white`;
    notification.innerHTML = `
        <div class="flex items-center space-x-3">
            <i class="fas fa-${type === 'success' ? 'check' : 'info'}-circle text-xl"></i>
            <span>${message}</span>
        </div>
    `;
    
    document.body.appendChild(notification);
    
    setTimeout(() => {
        notification.style.opacity = '0';
        setTimeout(() => notification.remove(), 300);
    }, 3000);
}
