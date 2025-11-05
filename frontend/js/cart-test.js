// Test script to check cart data transmission
console.log('🧪 Testing cart data transmission...');

// Test 1: Check if cartManager is available
if (typeof cartManager === 'undefined') {
    console.error('❌ cartManager is not defined');
} else {
    console.log('✅ cartManager is available');

    // Test 2: Check authentication
    const isAuth = cartManager.isAuthenticated();
    console.log('🔐 Authentication status:', isAuth);

    // Test 3: Check current cart data
    const cart = cartManager.getCart();
    console.log('🛒 Current cart data:', cart);

    // Test 4: Check localStorage
    const user = JSON.parse(localStorage.getItem('user') || 'null');
    const token = localStorage.getItem('token');
    console.log('👤 User data:', user);
    console.log('🔑 Token exists:', !!token);

    if (user && user.ma_nguoi_dung) {
        const cartKey = `cart_${user.ma_nguoi_dung}`;
        const savedCart = localStorage.getItem(cartKey);
        console.log('💾 Saved cart in localStorage:', savedCart);
    }
}

// Test 5: Check API_URL
console.log('🌐 API_URL:', window.API_URL);

// Test 6: Test addToCart function
window.testAddToCart = function(ma_mon) {
    console.log('🛍️ Testing addToCart with ma_mon:', ma_mon);
    if (typeof cartManager !== 'undefined') {
        cartManager.addToCart(ma_mon, 1);
    } else {
        console.error('❌ cartManager not available for testing');
    }
};

// Test 7: Test API call
window.testApiCall = async function() {
    console.log('🔗 Testing API call...');
    try {
        const response = await fetch(`${window.API_URL}/menu`);
        const data = await response.json();
        console.log('📡 API Response:', data);
    } catch (error) {
        console.error('❌ API call failed:', error);
    }
};

console.log('🧪 Test functions available:');
console.log('- testAddToCart(ma_mon): Test adding item to cart');
console.log('- testApiCall(): Test API connectivity');