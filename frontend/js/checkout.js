// API Configuration
const API_URL = window.API_URL || 'http://localhost:3000/api';

// Get authentication token
function getToken() {
    return localStorage.getItem('token') || sessionStorage.getItem('token');
}

// Check if user is authenticated
function isAuthenticated() {
    return !!getToken();
}

// Render checkout items from cart manager
function renderCheckoutItems() {
    const container = document.getElementById('checkout-items');
    if (!container) return;

    // Get cart from cartManager if available, otherwise use localStorage fallback
    let cart = { items: [], tong_tien: 0, so_luong: 0 };

    if (typeof cartManager !== 'undefined') {
        cart = cartManager.getCart();
    } else {
        // Fallback to localStorage
        const savedCart = localStorage.getItem('cart');
        if (savedCart) {
            try {
                const oldCart = JSON.parse(savedCart);
                // Convert old format to new format
                cart.items = oldCart;
                cart.tong_tien = oldCart.reduce((sum, item) => sum + (item.price * item.quantity), 0);
                cart.so_luong = oldCart.reduce((sum, item) => sum + item.quantity, 0);
            } catch (e) {
                console.error('Error parsing cart:', e);
            }
        }
    }

    if (!cart.items || cart.items.length === 0) {
        container.innerHTML = '<p class="text-gray-500 text-center">Giỏ hàng trống</p>';
        updateCheckoutSummary();
        return;
    }

    container.innerHTML = cart.items.map(item => {
        const imageSrc = item.anh_mon
            ? (item.anh_mon.startsWith('http') ? item.anh_mon : `http://localhost:3000${item.anh_mon}`)
            : '/images/default-dish.jpg';

        return `
        <div class="flex items-center gap-3">
            <div class="relative">
                <img src="${imageSrc}" 
                     alt="${item.ten_mon || item.name}" 
                     class="w-16 h-16 object-cover rounded"
                     onerror="this.src='/images/default-dish.jpg'">
                <span class="absolute -top-2 -right-2 bg-orange-600 text-white w-6 h-6 rounded-full text-xs flex items-center justify-center">
                    ${item.so_luong || item.quantity}
                </span>
            </div>
            <div class="flex-1">
                <p class="font-medium text-sm">${item.ten_mon || item.name}</p>
                <p class="text-orange-600 text-sm">${formatCurrency(item.gia_tai_thoi_diem || item.price)}</p>
            </div>
            <p class="font-bold">${formatCurrency((item.gia_tai_thoi_diem || item.price) * (item.so_luong || item.quantity))}</p>
        </div>
    `;
    }).join('');

    updateCheckoutSummary();
}

// Update checkout summary
function updateCheckoutSummary() {
    // Get cart data
    let cart = { items: [], tong_tien: 0 };

    if (typeof cartManager !== 'undefined') {
        cart = cartManager.getCart();
    } else {
        const savedCart = localStorage.getItem('cart');
        if (savedCart) {
            try {
                const oldCart = JSON.parse(savedCart);
                cart.items = oldCart;
                cart.tong_tien = oldCart.reduce((sum, item) => sum + (item.price * item.quantity), 0);
            } catch (e) {
                console.error('Error parsing cart:', e);
            }
        }
    }

    const subtotal = cart.tong_tien || 0;
    const shipping = subtotal >= 150000 ? 0 : (subtotal > 0 ? 30000 : 0); // Free ship từ 150k
    const discount = 0; // Will be calculated with promo code
    const total = subtotal + shipping - discount;

    const subtotalEl = document.getElementById('checkout-subtotal');
    const shippingEl = document.getElementById('checkout-shipping');
    const discountEl = document.getElementById('checkout-discount');
    const totalEl = document.getElementById('checkout-total');

    if (subtotalEl) subtotalEl.textContent = formatCurrency(subtotal);
    if (shippingEl) {
        if (shipping === 0 && subtotal >= 150000) {
            shippingEl.innerHTML = '<span class="text-green-600">Miễn phí</span>';
        } else {
            shippingEl.textContent = formatCurrency(shipping);
        }
    }
    if (discountEl) discountEl.textContent = `-${formatCurrency(discount)}`;
    if (totalEl) totalEl.textContent = formatCurrency(total);
}

// Format currency
function formatCurrency(amount) {
    return new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' }).format(amount);
}

// Handle payment method change and initialization
document.addEventListener('DOMContentLoaded', function () {
    // Check authentication
    if (!isAuthenticated()) {
        showNotification('Vui lòng đăng nhập để thanh toán', 'warning');
        setTimeout(() => {
            window.location.href = 'dang-nhap.html?redirect=thanh-toan.html';
        }, 2000);
        return;
    }

    // Load cart from server if using cartManager
    if (typeof cartManager !== 'undefined') {
        cartManager.loadCart().then(() => {
            renderCheckoutItems();
        });
    } else {
        renderCheckoutItems();
    }

    // Prefill user info if logged in (chạy sau khi address selectors đã init)
    setTimeout(() => {
        prefillUserInfo();
    }, 500);

    // Attach submit button handler
    const submitBtn = document.getElementById('submit-order-btn');
    console.log('🔍 Submit button found:', submitBtn);
    if (submitBtn) {
        submitBtn.addEventListener('click', function (e) {
            console.log('🖱️ Button clicked!');
            submitOrder(e);
        });
        console.log('✅ Submit button event listener attached');
    } else {
        console.error('❌ Submit button not found!');
    }

    // Payment method toggle
    const paymentOptions = document.querySelectorAll('.payment-option');
    const qrSection = document.getElementById('qr-code-section');

    paymentOptions.forEach(option => {
        option.addEventListener('click', function () {
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
async function submitOrder(event) {
    console.log('🚀 submitOrder called!', event);

    if (event) event.preventDefault();

    const form = document.getElementById('checkout-form');
    console.log('📝 Form found:', form);

    if (!form.checkValidity()) {
        console.warn('⚠️ Form validation failed');
        form.reportValidity();
        return;
    }

    console.log('✅ Form validation passed');

    // Check authentication
    console.log('🔐 Checking authentication...');
    if (!isAuthenticated()) {
        console.warn('❌ User not authenticated');
        showNotification('Vui lòng đăng nhập để đặt hàng', 'warning');
        setTimeout(() => {
            window.location.href = 'dang-nhap.html?redirect=thanh-toan.html';
        }, 1500);
        return;
    }
    console.log('✅ User authenticated');

    // Get cart
    let cart = { items: [], tong_tien: 0 };
    if (typeof cartManager !== 'undefined') {
        cart = cartManager.getCart();
        console.log('🛒 Cart from cartManager:', cart);
    } else {
        console.warn('⚠️ cartManager not found, using fallback');
    }

    if (!cart.items || cart.items.length === 0) {
        console.error('❌ Cart is empty!');
        showNotification('Giỏ hàng trống!', 'error');
        setTimeout(() => {
            window.location.href = 'thuc-don.html';
        }, 1500);
        return;
    }
    console.log('✅ Cart has', cart.items.length, 'items');

    // Get form data
    console.log('📋 Collecting form data...');
    const formInputs = form.querySelectorAll('input, select, textarea');
    const formData = {};
    console.log('Found', formInputs.length, 'form inputs');

    formInputs.forEach(input => {
        if (input.name) {
            // For selects, get the display text from API data
            if (input.tagName === 'SELECT' && input.selectedOptions[0]) {
                const selectedOption = input.selectedOptions[0];
                if (input.name === 'province') {
                    formData.tinh_thanh = selectedOption.dataset.provinceName || selectedOption.textContent;
                } else if (input.name === 'district') {
                    formData.quan_huyen = selectedOption.dataset.districtName || selectedOption.textContent;
                } else if (input.name === 'ward') {
                    formData.phuong_xa = selectedOption.dataset.wardName || selectedOption.textContent;
                } else {
                    formData[input.name] = input.value;
                }
            } else {
                formData[input.name] = input.value;
            }
        } else {
            // Map unnamed inputs by placeholder/label
            const label = input.previousElementSibling?.textContent || '';
            if (label.includes('Họ và tên')) formData.ten_nguoi_nhan = input.value;
            else if (label.includes('Số điện thoại')) formData.so_dien_thoai = input.value;
            else if (label.includes('Email')) formData.email = input.value;
            else if (label.includes('Địa chỉ') && !label.includes('giao')) formData.dia_chi = input.value;
            else if (label.includes('Ghi chú')) formData.ghi_chu = input.value;
        }
    });

    // Get payment method
    const paymentMethod = document.querySelector('input[name="payment"]:checked')?.value;
    if (!paymentMethod) {
        showNotification('Vui lòng chọn phương thức thanh toán', 'error');
        return;
    }

    // Prepare order data
    const orderData = {
        ten_nguoi_nhan: formData.ten_nguoi_nhan,
        so_dien_thoai: formData.so_dien_thoai,
        email: formData.email,
        dia_chi: formData.dia_chi,
        tinh_thanh: formData.tinh_thanh,
        quan_huyen: formData.quan_huyen,
        phuong_xa: formData.phuong_xa,
        ghi_chu: formData.ghi_chu,
        phuong_thuc_thanh_toan: paymentMethod,
        ma_khuyen_mai: null // Add promo code support later
    };

    // Validate required fields
    console.log('🔍 Order data:', orderData);
    if (!orderData.ten_nguoi_nhan || !orderData.so_dien_thoai || !orderData.dia_chi ||
        !orderData.tinh_thanh || !orderData.quan_huyen || !orderData.phuong_xa) {
        console.error('❌ Missing required fields:', {
            ten_nguoi_nhan: orderData.ten_nguoi_nhan,
            so_dien_thoai: orderData.so_dien_thoai,
            dia_chi: orderData.dia_chi,
            tinh_thanh: orderData.tinh_thanh,
            quan_huyen: orderData.quan_huyen,
            phuong_xa: orderData.phuong_xa
        });
        showNotification('Vui lòng điền đầy đủ thông tin giao hàng', 'error');
        return;
    }

    // Show loading
    console.log('⏳ Submitting order to server...');
    showNotification('Đang xử lý đơn hàng...', 'info');

    try {
        const token = getToken();
        console.log('🔑 Token:', token ? 'Present' : 'Missing');
        console.log('🌐 API URL:', `${API_URL}/orders/create`);
        console.log('📤 Sending order data:', JSON.stringify(orderData, null, 2));

        const response = await fetch(`${API_URL}/orders/create`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${token}`
            },
            body: JSON.stringify(orderData)
        });

        console.log('📥 Response status:', response.status);
        const result = await response.json();
        console.log('📥 Response data:', result);

        if (response.ok && result.success) {
            const orderId = result.data.ma_don_hang;
            const totalAmount = cart.tong_tien + (cart.tong_tien >= 150000 ? 0 : 30000); // Include shipping

            // If payment method is MoMo, redirect to payment gateway
            if (paymentMethod === 'momo') {
                const gatewayName = 'MoMo';
                const endpoint = 'momo/create-payment';
                
                console.log(`💳 Processing ${gatewayName} payment...`);
                showNotification(`Đang chuyển đến cổng thanh toán ${gatewayName}...`, 'info');

                try {
                    const paymentResponse = await fetch(`${API_URL}/payment/${endpoint}`, {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/json',
                            'Authorization': `Bearer ${token}`
                        },
                        body: JSON.stringify({
                            orderId: orderId,
                            amount: totalAmount,
                            orderInfo: `Thanh toan don hang ${orderId}`
                        })
                    });

                    const paymentResult = await paymentResponse.json();
                    console.log('💳 Payment response:', paymentResult);

                    if (paymentResponse.ok && paymentResult.success) {
                        // KHÔNG xóa giỏ hàng ở đây - chỉ xóa khi thanh toán thành công
                        // Cart sẽ được xóa trong trang dat-hang-thanh-cong.html

                        // Lưu địa chỉ giao hàng để prefill lần sau
                        saveLastShippingAddress(orderData);

                        // Redirect to payment gateway
                        window.location.href = paymentResult.data.paymentUrl;
                    } else {
                        showNotification(paymentResult.message || `Không thể tạo thanh toán ${gatewayName}`, 'error');
                    }
                } catch (error) {
                    console.error(`Lỗi tạo thanh toán ${gatewayName}:`, error);
                    showNotification('Có lỗi xảy ra khi tạo thanh toán. Vui lòng thử lại.', 'error');
                }
            } else {
                // Other payment methods (COD, bank, etc.)
                showNotification('Đặt hàng thành công!', 'success');

                // Đánh dấu giỏ hàng đã đặt (tạo giỏ mới cho user)
                try {
                    await fetch(`${API_URL}/cart/mark-ordered`, {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/json',
                            'Authorization': `Bearer ${token}`
                        }
                    });
                    
                    // Reload cart để cập nhật UI
                    if (typeof cartManager !== 'undefined') {
                        await cartManager.loadCart();
                    }
                } catch (error) {
                    console.error('Error marking cart as ordered:', error);
                }

                // Lưu địa chỉ giao hàng để prefill lần sau
                saveLastShippingAddress(orderData);

                // Xóa localStorage cart backup
                localStorage.removeItem('cart');
                const user = JSON.parse(localStorage.getItem('user') || '{}');
                if (user.ma_nguoi_dung) {
                    localStorage.removeItem(`cart_${user.ma_nguoi_dung}`);
                }

                // Redirect to success page
                setTimeout(() => {
                    window.location.href = `dat-hang-thanh-cong.html?orderId=${orderId}`;
                }, 2000);
            }
        } else {
            showNotification(result.message || 'Đặt hàng thất bại', 'error');
        }
    } catch (error) {
        console.error('Lỗi đặt hàng:', error);
        showNotification('Có lỗi xảy ra khi đặt hàng. Vui lòng thử lại.', 'error');
    }
}

// Prefill user information
async function prefillUserInfo() {
    const user = JSON.parse(localStorage.getItem('user') || '{}');
    const lastShipping = getLastShippingAddress();
    
    console.log('📋 Prefilling user info:', user);
    console.log('📦 Last shipping address:', lastShipping);

    // Ưu tiên dùng địa chỉ giao hàng đã lưu, nếu không có thì dùng thông tin user
    const prefillData = lastShipping || user;

    // Prefill họ tên
    const nameInput = document.querySelector('input[type="text"][placeholder*="Nguyễn Văn A"]');
    if (nameInput) {
        nameInput.value = lastShipping?.ten_nguoi_nhan || user.ten_nguoi_dung || '';
    }

    // Prefill số điện thoại
    const phoneInput = document.querySelector('input[type="tel"]');
    if (phoneInput) {
        phoneInput.value = lastShipping?.so_dien_thoai || user.so_dien_thoai || '';
    }

    // Prefill email
    const emailInput = document.querySelector('input[type="email"]');
    if (emailInput) {
        emailInput.value = lastShipping?.email || user.email || '';
    }

    // Prefill địa chỉ chi tiết
    const addressInput = document.querySelector('input[type="text"][placeholder*="Số nhà"]');
    if (addressInput) {
        addressInput.value = lastShipping?.dia_chi || user.dia_chi || '';
    }

    // Prefill địa chỉ tỉnh/huyện/xã
    if (lastShipping && lastShipping.tinh_thanh) {
        // Có địa chỉ giao hàng đã lưu đầy đủ
        await prefillAddressSelectors(lastShipping);
    } else {
        // Thử tìm tỉnh/huyện từ địa chỉ text của user
        const addressText = lastShipping?.dia_chi || user.dia_chi || '';
        if (addressText) {
            await findAndSelectAddressFromText(addressText);
        }
    }
}

// Prefill địa chỉ từ thông tin user đã lưu
async function prefillAddressSelectors(user) {
    const provinceSelect = document.querySelector('select[name="province"]');
    const districtSelect = document.querySelector('select[name="district"]');
    const wardSelect = document.querySelector('select[name="ward"]');

    if (!provinceSelect || !districtSelect) return;

    // Đợi provinces được load xong
    await waitForProvinces(provinceSelect);

    // Nếu user có tinh_thanh, tìm và chọn tỉnh
    if (user.tinh_thanh) {
        const provinceOption = findOptionByText(provinceSelect, user.tinh_thanh);
        if (provinceOption) {
            provinceSelect.value = provinceOption.value;
            console.log('✅ Auto-selected province:', user.tinh_thanh);
            
            // Trigger change event để load districts
            provinceSelect.dispatchEvent(new Event('change'));
            
            // Đợi districts được load
            await waitForOptions(districtSelect);

            // Nếu user có quan_huyen, tìm và chọn huyện
            if (user.quan_huyen) {
                const districtOption = findOptionByText(districtSelect, user.quan_huyen);
                if (districtOption) {
                    districtSelect.value = districtOption.value;
                    console.log('✅ Auto-selected district:', user.quan_huyen);
                    
                    // Trigger change event để load wards
                    districtSelect.dispatchEvent(new Event('change'));
                    
                    // Đợi wards được load
                    if (wardSelect) {
                        await waitForOptions(wardSelect);

                        // Nếu user có phuong_xa, tìm và chọn xã
                        if (user.phuong_xa) {
                            const wardOption = findOptionByText(wardSelect, user.phuong_xa);
                            if (wardOption) {
                                wardSelect.value = wardOption.value;
                                console.log('✅ Auto-selected ward:', user.phuong_xa);
                            }
                        }
                    }
                }
            }
        }
    }
}

// Đợi provinces được load vào select
function waitForProvinces(select, timeout = 5000) {
    return new Promise((resolve) => {
        const startTime = Date.now();
        const checkInterval = setInterval(() => {
            // Kiểm tra có options nào không phải "Đang tải" hoặc "Chọn"
            const hasRealOptions = Array.from(select.options).some(opt => 
                opt.value && !opt.textContent.includes('Đang tải')
            );
            
            if (hasRealOptions || Date.now() - startTime > timeout) {
                clearInterval(checkInterval);
                resolve();
            }
        }, 100);
    });
}

// Đợi options được load vào select
function waitForOptions(select, timeout = 3000) {
    return new Promise((resolve) => {
        const startTime = Date.now();
        const checkInterval = setInterval(() => {
            const isLoading = select.options[0]?.textContent.includes('Đang tải');
            const hasOptions = select.options.length > 1;
            
            if ((!isLoading && hasOptions) || Date.now() - startTime > timeout) {
                clearInterval(checkInterval);
                // Thêm delay nhỏ để đảm bảo DOM đã cập nhật
                setTimeout(resolve, 100);
            }
        }, 100);
    });
}

// Tìm option theo text (fuzzy match)
function findOptionByText(select, searchText) {
    if (!searchText) return null;
    
    const normalizedSearch = normalizeVietnamese(searchText.toLowerCase());
    
    for (const option of select.options) {
        const optionText = normalizeVietnamese(option.textContent.toLowerCase());
        // Exact match hoặc contains
        if (optionText === normalizedSearch || 
            optionText.includes(normalizedSearch) || 
            normalizedSearch.includes(optionText)) {
            return option;
        }
    }
    return null;
}

// Chuẩn hóa tiếng Việt để so sánh
function normalizeVietnamese(str) {
    return str
        .normalize('NFD')
        .replace(/[\u0300-\u036f]/g, '')
        .replace(/đ/g, 'd')
        .replace(/Đ/g, 'D')
        .trim();
}

// Tìm và chọn tỉnh/huyện từ địa chỉ text (ví dụ: "Cầu Kè" → Trà Vinh)
async function findAndSelectAddressFromText(addressText) {
    if (!addressText) return;
    
    console.log('🔍 Trying to find province/district from address:', addressText);
    
    const provinceSelect = document.querySelector('select[name="province"]');
    const districtSelect = document.querySelector('select[name="district"]');
    
    if (!provinceSelect || !districtSelect) return;
    
    // Đợi provinces được load
    await waitForProvinces(provinceSelect);
    
    const normalizedAddress = normalizeVietnamese(addressText.toLowerCase());
    
    // Danh sách huyện phổ biến và tỉnh tương ứng (có thể mở rộng)
    const districtToProvince = {
        'cau ke': { province: 'Trà Vinh', district: 'Cầu Kè' },
        'cang long': { province: 'Trà Vinh', district: 'Càng Long' },
        'chau thanh': { province: 'Trà Vinh', district: 'Châu Thành' },
        'tra cu': { province: 'Trà Vinh', district: 'Trà Cú' },
        'tieu can': { province: 'Trà Vinh', district: 'Tiểu Cần' },
        'duyen hai': { province: 'Trà Vinh', district: 'Duyên Hải' },
        'vinh long': { province: 'Vĩnh Long', district: null },
        'long ho': { province: 'Vĩnh Long', district: 'Long Hồ' },
        'mang thit': { province: 'Vĩnh Long', district: 'Mang Thít' },
        'vung liem': { province: 'Vĩnh Long', district: 'Vũng Liêm' },
        'tam binh': { province: 'Vĩnh Long', district: 'Tam Bình' },
        'binh minh': { province: 'Vĩnh Long', district: 'Bình Minh' },
        'tra on': { province: 'Vĩnh Long', district: 'Trà Ôn' },
        'binh tan': { province: 'Vĩnh Long', district: 'Bình Tân' }
    };
    
    // Tìm trong mapping
    let foundProvince = null;
    let foundDistrict = null;
    
    for (const [key, value] of Object.entries(districtToProvince)) {
        if (normalizedAddress.includes(key)) {
            foundProvince = value.province;
            foundDistrict = value.district;
            console.log(`✅ Found match: "${key}" → ${foundProvince}, ${foundDistrict}`);
            break;
        }
    }
    
    // Nếu không tìm thấy trong mapping, thử tìm trực tiếp trong tên tỉnh
    if (!foundProvince) {
        for (const option of provinceSelect.options) {
            const optionText = normalizeVietnamese(option.textContent.toLowerCase());
            if (normalizedAddress.includes(optionText) || optionText.includes(normalizedAddress)) {
                foundProvince = option.textContent;
                console.log(`✅ Found province directly: ${foundProvince}`);
                break;
            }
        }
    }
    
    // Chọn tỉnh nếu tìm thấy
    if (foundProvince) {
        const provinceOption = findOptionByText(provinceSelect, foundProvince);
        if (provinceOption) {
            provinceSelect.value = provinceOption.value;
            console.log('✅ Auto-selected province:', foundProvince);
            
            // Trigger change để load districts
            provinceSelect.dispatchEvent(new Event('change'));
            
            // Đợi districts load
            await waitForOptions(districtSelect);
            
            // Chọn huyện nếu tìm thấy
            if (foundDistrict) {
                const districtOption = findOptionByText(districtSelect, foundDistrict);
                if (districtOption) {
                    districtSelect.value = districtOption.value;
                    console.log('✅ Auto-selected district:', foundDistrict);
                    
                    // Trigger change để load wards
                    districtSelect.dispatchEvent(new Event('change'));
                }
            }
        }
    }
}

// Lưu địa chỉ giao hàng cuối cùng để prefill lần sau
function saveLastShippingAddress(orderData) {
    const user = JSON.parse(localStorage.getItem('user') || '{}');
    if (!user.ma_nguoi_dung) return;

    const shippingAddress = {
        ten_nguoi_nhan: orderData.ten_nguoi_nhan,
        so_dien_thoai: orderData.so_dien_thoai,
        email: orderData.email,
        dia_chi: orderData.dia_chi,
        tinh_thanh: orderData.tinh_thanh,
        quan_huyen: orderData.quan_huyen,
        phuong_xa: orderData.phuong_xa
    };

    localStorage.setItem(`shipping_${user.ma_nguoi_dung}`, JSON.stringify(shippingAddress));
    console.log('💾 Saved shipping address for next order:', shippingAddress);
}

// Lấy địa chỉ giao hàng đã lưu
function getLastShippingAddress() {
    const user = JSON.parse(localStorage.getItem('user') || '{}');
    if (!user.ma_nguoi_dung) return null;

    const saved = localStorage.getItem(`shipping_${user.ma_nguoi_dung}`);
    if (saved) {
        try {
            return JSON.parse(saved);
        } catch (e) {
            return null;
        }
    }
    return null;
}

// Show notification - use auth.js notification if available
function showNotification(message, type = 'success') {
    // Try to use auth.js notification first (check if it exists and is different from this function)
    if (window.authShowNotification && typeof window.authShowNotification === 'function') {
        window.authShowNotification(message, type);
        return;
    }

    // Fallback notification
    const bgColor = type === 'success' ? 'bg-green-500' :
        type === 'info' ? 'bg-blue-500' :
            type === 'warning' ? 'bg-yellow-500' : 'bg-red-500';
    const icon = type === 'success' ? 'check' :
        type === 'warning' ? 'exclamation-triangle' : 'info';

    const notification = document.createElement('div');
    notification.className = `fixed top-24 right-6 z-50 px-6 py-4 rounded-lg shadow-lg transform transition-all duration-300 ${bgColor} text-white`;
    notification.innerHTML = `
        <div class="flex items-center space-x-3">
            <i class="fas fa-${icon}-circle text-xl"></i>
            <span>${message}</span>
        </div>
    `;

    document.body.appendChild(notification);

    setTimeout(() => {
        notification.style.opacity = '0';
        setTimeout(() => notification.remove(), 300);
    }, 3000);
}
