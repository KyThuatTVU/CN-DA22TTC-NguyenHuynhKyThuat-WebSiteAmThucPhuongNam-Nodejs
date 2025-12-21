/**
 * Responsive Helper - Phương Nam Restaurant
 * Xử lý các vấn đề responsive động
 */

(function() {
    'use strict';

    // Breakpoints theo Tailwind CSS
    const BREAKPOINTS = {
        xs: 0,
        sm: 640,
        md: 768,
        lg: 1024,
        xl: 1280,
        '2xl': 1536
    };

    // Lấy breakpoint hiện tại
    function getCurrentBreakpoint() {
        const width = window.innerWidth;
        if (width >= BREAKPOINTS['2xl']) return '2xl';
        if (width >= BREAKPOINTS.xl) return 'xl';
        if (width >= BREAKPOINTS.lg) return 'lg';
        if (width >= BREAKPOINTS.md) return 'md';
        if (width >= BREAKPOINTS.sm) return 'sm';
        return 'xs';
    }

    // Kiểm tra thiết bị di động
    function isMobile() {
        return window.innerWidth < BREAKPOINTS.md;
    }

    // Kiểm tra thiết bị tablet
    function isTablet() {
        return window.innerWidth >= BREAKPOINTS.md && window.innerWidth < BREAKPOINTS.lg;
    }

    // Kiểm tra desktop
    function isDesktop() {
        return window.innerWidth >= BREAKPOINTS.lg;
    }

    // Kiểm tra touch device
    function isTouchDevice() {
        return ('ontouchstart' in window) || 
               (navigator.maxTouchPoints > 0) || 
               (navigator.msMaxTouchPoints > 0);
    }

    // Xử lý viewport height cho mobile (fix 100vh issue)
    function setViewportHeight() {
        const vh = window.innerHeight * 0.01;
        document.documentElement.style.setProperty('--vh', `${vh}px`);
    }

    // Xử lý navbar height
    function setNavbarHeight() {
        const navbar = document.getElementById('navbar');
        if (navbar) {
            const height = navbar.offsetHeight;
            document.documentElement.style.setProperty('--navbar-height', `${height}px`);
            document.body.style.paddingTop = `${height}px`;
        }
    }

    // Xử lý mobile menu
    function initMobileMenu() {
        const mobileMenuBtn = document.getElementById('mobile-menu-btn');
        const mobileMenu = document.getElementById('mobile-menu');
        
        if (mobileMenuBtn && mobileMenu) {
            mobileMenuBtn.addEventListener('click', function() {
                mobileMenu.classList.toggle('hidden');
                
                // Toggle icon
                const icon = this.querySelector('i');
                if (icon) {
                    icon.classList.toggle('fa-bars');
                    icon.classList.toggle('fa-times');
                }
                
                // Prevent body scroll when menu is open
                if (!mobileMenu.classList.contains('hidden')) {
                    document.body.style.overflow = 'hidden';
                } else {
                    document.body.style.overflow = '';
                }
            });
            
            // Close menu when clicking outside
            document.addEventListener('click', function(e) {
                if (!mobileMenu.contains(e.target) && !mobileMenuBtn.contains(e.target)) {
                    mobileMenu.classList.add('hidden');
                    document.body.style.overflow = '';
                    
                    const icon = mobileMenuBtn.querySelector('i');
                    if (icon) {
                        icon.classList.add('fa-bars');
                        icon.classList.remove('fa-times');
                    }
                }
            });
            
            // Close menu on resize to desktop
            window.addEventListener('resize', function() {
                if (isDesktop()) {
                    mobileMenu.classList.add('hidden');
                    document.body.style.overflow = '';
                    
                    const icon = mobileMenuBtn.querySelector('i');
                    if (icon) {
                        icon.classList.add('fa-bars');
                        icon.classList.remove('fa-times');
                    }
                }
            });
        }
    }

    // Xử lý filter sidebar trên mobile
    function initMobileFilter() {
        const filterToggle = document.getElementById('mobile-filter-toggle');
        const filterSidebar = document.getElementById('filter-sidebar');
        const filterClose = document.getElementById('mobile-filter-close');
        
        if (filterToggle && filterSidebar) {
            filterToggle.addEventListener('click', function() {
                filterSidebar.classList.toggle('hidden');
                filterSidebar.classList.toggle('mobile-open');
                
                // Toggle icon
                const icon = document.getElementById('filter-icon');
                if (icon) {
                    icon.classList.toggle('rotate-180');
                }
                
                // Add backdrop
                if (filterSidebar.classList.contains('mobile-open')) {
                    const backdrop = document.createElement('div');
                    backdrop.className = 'filter-backdrop';
                    backdrop.id = 'filter-backdrop';
                    backdrop.addEventListener('click', closeFilter);
                    document.body.appendChild(backdrop);
                    document.body.style.overflow = 'hidden';
                } else {
                    closeFilter();
                }
            });
            
            if (filterClose) {
                filterClose.addEventListener('click', closeFilter);
            }
            
            function closeFilter() {
                filterSidebar.classList.add('hidden');
                filterSidebar.classList.remove('mobile-open');
                
                const backdrop = document.getElementById('filter-backdrop');
                if (backdrop) backdrop.remove();
                
                document.body.style.overflow = '';
                
                const icon = document.getElementById('filter-icon');
                if (icon) icon.classList.remove('rotate-180');
            }
            
            // Close on resize to desktop
            window.addEventListener('resize', function() {
                if (isDesktop()) {
                    filterSidebar.classList.remove('hidden', 'mobile-open');
                    const backdrop = document.getElementById('filter-backdrop');
                    if (backdrop) backdrop.remove();
                    document.body.style.overflow = '';
                }
            });
        }
    }

    // Xử lý account sidebar trên mobile
    function initAccountSidebar() {
        const menuToggle = document.getElementById('mobile-menu-toggle');
        const sidebarMenu = document.getElementById('sidebar-menu');
        
        if (menuToggle && sidebarMenu) {
            menuToggle.addEventListener('click', function() {
                sidebarMenu.classList.toggle('hidden');
                
                const chevron = document.getElementById('menu-chevron');
                if (chevron) {
                    chevron.classList.toggle('rotate-180');
                }
            });
        }
    }

    // Xử lý lazy loading images
    function initLazyLoading() {
        if ('IntersectionObserver' in window) {
            const lazyImages = document.querySelectorAll('img[data-src]');
            
            const imageObserver = new IntersectionObserver((entries, observer) => {
                entries.forEach(entry => {
                    if (entry.isIntersecting) {
                        const img = entry.target;
                        img.src = img.dataset.src;
                        img.removeAttribute('data-src');
                        observer.unobserve(img);
                    }
                });
            }, {
                rootMargin: '50px 0px',
                threshold: 0.01
            });
            
            lazyImages.forEach(img => imageObserver.observe(img));
        }
    }

    // Xử lý scroll to top button
    function initScrollToTop() {
        const backToTop = document.getElementById('back-to-top');
        
        if (backToTop) {
            window.addEventListener('scroll', function() {
                if (window.scrollY > 300) {
                    backToTop.classList.remove('opacity-0', 'pointer-events-none');
                    backToTop.classList.add('opacity-100');
                } else {
                    backToTop.classList.add('opacity-0', 'pointer-events-none');
                    backToTop.classList.remove('opacity-100');
                }
            });
            
            backToTop.addEventListener('click', function() {
                window.scrollTo({
                    top: 0,
                    behavior: 'smooth'
                });
            });
        }
    }

    // Xử lý form inputs trên iOS (prevent zoom)
    function preventIOSZoom() {
        if (/iPhone|iPad|iPod/.test(navigator.userAgent)) {
            const inputs = document.querySelectorAll('input, select, textarea');
            inputs.forEach(input => {
                if (parseFloat(getComputedStyle(input).fontSize) < 16) {
                    input.style.fontSize = '16px';
                }
            });
        }
    }

    // Xử lý orientation change
    function handleOrientationChange() {
        window.addEventListener('orientationchange', function() {
            // Delay để đợi browser cập nhật viewport
            setTimeout(function() {
                setViewportHeight();
                setNavbarHeight();
            }, 100);
        });
    }

    // Xử lý sticky elements
    function initStickyElements() {
        const stickyElements = document.querySelectorAll('.lg\\:sticky');
        
        if (isMobile() || isTablet()) {
            stickyElements.forEach(el => {
                el.style.position = 'relative';
                el.style.top = 'auto';
            });
        }
    }

    // Xử lý grid responsive
    function adjustGrids() {
        const grids = document.querySelectorAll('.grid');
        
        grids.forEach(grid => {
            // Đảm bảo gap phù hợp trên mobile
            if (isMobile()) {
                const currentGap = getComputedStyle(grid).gap;
                if (parseFloat(currentGap) > 24) {
                    grid.style.gap = '1rem';
                }
            }
        });
    }

    // Xử lý images responsive
    function adjustImages() {
        const images = document.querySelectorAll('img');
        
        images.forEach(img => {
            // Đảm bảo images không vượt quá container
            img.style.maxWidth = '100%';
            img.style.height = 'auto';
            
            // Thêm error handler
            if (!img.hasAttribute('data-error-handled')) {
                img.setAttribute('data-error-handled', 'true');
                img.addEventListener('error', function() {
                    this.src = 'images/default-food.jpg';
                });
            }
        });
    }

    // Xử lý buttons touch feedback
    function initTouchFeedback() {
        if (isTouchDevice()) {
            const buttons = document.querySelectorAll('button, .btn, a.bg-orange-600, a.bg-gradient-to-r');
            
            buttons.forEach(btn => {
                btn.addEventListener('touchstart', function() {
                    this.style.transform = 'scale(0.98)';
                    this.style.opacity = '0.9';
                });
                
                btn.addEventListener('touchend', function() {
                    this.style.transform = '';
                    this.style.opacity = '';
                });
            });
        }
    }

    // Debounce function
    function debounce(func, wait) {
        let timeout;
        return function executedFunction(...args) {
            const later = () => {
                clearTimeout(timeout);
                func(...args);
            };
            clearTimeout(timeout);
            timeout = setTimeout(later, wait);
        };
    }

    // Xử lý resize
    const handleResize = debounce(function() {
        setViewportHeight();
        setNavbarHeight();
        initStickyElements();
        adjustGrids();
    }, 150);

    // Initialize
    function init() {
        // Set initial values
        setViewportHeight();
        
        // Wait for DOM
        if (document.readyState === 'loading') {
            document.addEventListener('DOMContentLoaded', onDOMReady);
        } else {
            onDOMReady();
        }
    }

    function onDOMReady() {
        setNavbarHeight();
        initMobileMenu();
        initMobileFilter();
        initAccountSidebar();
        initLazyLoading();
        initScrollToTop();
        preventIOSZoom();
        handleOrientationChange();
        initStickyElements();
        adjustGrids();
        adjustImages();
        initTouchFeedback();
        
        // Listen for resize
        window.addEventListener('resize', handleResize);
        
        console.log('📱 Responsive Helper initialized');
        console.log('📐 Current breakpoint:', getCurrentBreakpoint());
        console.log('👆 Touch device:', isTouchDevice());
    }

    // Export functions
    window.ResponsiveHelper = {
        getCurrentBreakpoint,
        isMobile,
        isTablet,
        isDesktop,
        isTouchDevice,
        BREAKPOINTS
    };

    // Initialize
    init();

})();
