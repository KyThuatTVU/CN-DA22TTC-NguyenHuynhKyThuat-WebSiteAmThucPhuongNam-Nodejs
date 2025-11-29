/**
 * Admin Mobile Navigation Handler
 * Handles sidebar toggle for mobile devices
 */

// Toggle sidebar function
function toggleSidebar() {
    const sidebar = document.getElementById('sidebar');
    const overlay = document.getElementById('sidebar-overlay');
    
    if (sidebar) {
        sidebar.classList.toggle('open');
    }
    
    if (overlay) {
        overlay.classList.toggle('active');
    }
    
    // Prevent body scroll when sidebar is open
    document.body.style.overflow = sidebar && sidebar.classList.contains('open') ? 'hidden' : '';
}

// Close sidebar when clicking outside
document.addEventListener('DOMContentLoaded', function() {
    // Create overlay if it doesn't exist
    if (!document.getElementById('sidebar-overlay')) {
        const overlay = document.createElement('div');
        overlay.id = 'sidebar-overlay';
        overlay.className = 'sidebar-overlay';
        overlay.onclick = toggleSidebar;
        
        const mainContent = document.querySelector('.flex-1.flex.flex-col');
        if (mainContent) {
            mainContent.insertBefore(overlay, mainContent.firstChild);
        }
    }
    
    // Close sidebar on window resize to desktop
    window.addEventListener('resize', function() {
        if (window.innerWidth >= 1024) {
            const sidebar = document.getElementById('sidebar');
            const overlay = document.getElementById('sidebar-overlay');
            
            if (sidebar) {
                sidebar.classList.remove('open');
            }
            if (overlay) {
                overlay.classList.remove('active');
            }
            document.body.style.overflow = '';
        }
    });
    
    // Close sidebar when pressing Escape key
    document.addEventListener('keydown', function(e) {
        if (e.key === 'Escape') {
            const sidebar = document.getElementById('sidebar');
            if (sidebar && sidebar.classList.contains('open')) {
                toggleSidebar();
            }
        }
    });
    
    // Handle swipe to close sidebar on mobile
    let touchStartX = 0;
    let touchEndX = 0;
    
    document.addEventListener('touchstart', function(e) {
        touchStartX = e.changedTouches[0].screenX;
    }, { passive: true });
    
    document.addEventListener('touchend', function(e) {
        touchEndX = e.changedTouches[0].screenX;
        handleSwipe();
    }, { passive: true });
    
    function handleSwipe() {
        const sidebar = document.getElementById('sidebar');
        const swipeThreshold = 100;
        
        // Swipe left to close sidebar
        if (sidebar && sidebar.classList.contains('open')) {
            if (touchStartX - touchEndX > swipeThreshold) {
                toggleSidebar();
            }
        }
        
        // Swipe right to open sidebar (from left edge)
        if (sidebar && !sidebar.classList.contains('open')) {
            if (touchEndX - touchStartX > swipeThreshold && touchStartX < 50) {
                toggleSidebar();
            }
        }
    }
});

// Make toggleSidebar available globally
window.toggleSidebar = toggleSidebar;
