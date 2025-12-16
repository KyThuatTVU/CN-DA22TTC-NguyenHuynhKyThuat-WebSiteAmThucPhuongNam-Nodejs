// Snow Effect JavaScript - Hiệu ứng tuyết rơi cho tất cả các trang
(function() {
    'use strict';

    // Configuration - Tuyết rơi nhiều hơn!
    const config = {
        snowflakeCount: 120,
        snowflakeChars: ['❄', '❅', '❆', '✻', '✼', '❉', '•', '◦'],
        minSize: 0.6,
        maxSize: 2.0,
        minDuration: 8,
        maxDuration: 18,
        minDelay: 0,
        maxDelay: 5
    };

    // Inject CSS styles for snow effect
    function injectStyles() {
        if (document.getElementById('snow-effect-styles')) return;
        
        const style = document.createElement('style');
        style.id = 'snow-effect-styles';
        style.textContent = `
            /* Snow container */
            .snow-container {
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                pointer-events: none;
                z-index: 9999;
                overflow: hidden;
            }

            /* Individual snowflake */
            .snowflake {
                position: absolute;
                top: -20px;
                color: #fff;
                font-size: 1em;
                text-shadow: 0 0 5px rgba(255,255,255,0.8), 0 0 10px rgba(173,216,230,0.5);
                animation: snowfall linear infinite;
                opacity: 0.9;
                user-select: none;
                filter: drop-shadow(0 0 3px rgba(255,255,255,0.8));
            }

            @keyframes snowfall {
                0% {
                    transform: translateY(-20px) translateX(0) rotate(0deg);
                    opacity: 0;
                }
                10% {
                    opacity: 1;
                }
                90% {
                    opacity: 0.8;
                }
                100% {
                    transform: translateY(100vh) translateX(50px) rotate(360deg);
                    opacity: 0;
                }
            }

            /* Snowflake variations for more natural movement */
            .snowflake:nth-child(odd) {
                animation-timing-function: ease-in-out;
            }

            .snowflake:nth-child(even) {
                animation-timing-function: linear;
            }

            .snowflake:nth-child(3n) {
                animation-name: snowfall-sway;
            }

            @keyframes snowfall-sway {
                0% {
                    transform: translateY(-20px) translateX(0) rotate(0deg);
                    opacity: 0;
                }
                10% {
                    opacity: 1;
                }
                25% {
                    transform: translateY(25vh) translateX(-30px) rotate(90deg);
                }
                50% {
                    transform: translateY(50vh) translateX(30px) rotate(180deg);
                }
                75% {
                    transform: translateY(75vh) translateX(-20px) rotate(270deg);
                }
                90% {
                    opacity: 0.8;
                }
                100% {
                    transform: translateY(100vh) translateX(20px) rotate(360deg);
                    opacity: 0;
                }
            }

            /* Corner decorations */
            .snowflake-decoration {
                position: fixed;
                z-index: 9998;
                pointer-events: none;
                opacity: 0.5;
                color: #fff;
                text-shadow: 0 0 15px rgba(173,216,230,0.8), 0 0 30px rgba(255,255,255,0.5);
                animation: float-decoration 6s ease-in-out infinite;
            }

            .snowflake-decoration.top-left {
                top: 80px;
                left: 20px;
                font-size: 50px;
                animation-delay: 0s;
            }

            .snowflake-decoration.top-right {
                top: 100px;
                right: 30px;
                font-size: 40px;
                animation-delay: 1s;
            }

            .snowflake-decoration.mid-left {
                top: 35%;
                left: 15px;
                font-size: 35px;
                animation-delay: 2s;
            }

            .snowflake-decoration.mid-right {
                top: 45%;
                right: 20px;
                font-size: 38px;
                animation-delay: 1.5s;
            }

            @keyframes float-decoration {
                0%, 100% {
                    transform: translateY(0) rotate(0deg) scale(1);
                }
                50% {
                    transform: translateY(-15px) rotate(180deg) scale(1.1);
                }
            }

            /* Hide decorations on mobile for better UX */
            @media (max-width: 768px) {
                .snowflake-decoration {
                    display: none;
                }
                .snow-container .snowflake {
                    font-size: 0.7em;
                }
            }
        `;
        document.head.appendChild(style);
    }

    // Create snow container
    function createSnowContainer() {
        let container = document.querySelector('.snow-container');
        if (!container) {
            container = document.createElement('div');
            container.className = 'snow-container';
            document.body.appendChild(container);
        }
        return container;
    }

    // Create a single snowflake
    function createSnowflake(container) {
        const snowflake = document.createElement('div');
        snowflake.className = 'snowflake';
        
        // Random snowflake character
        const char = config.snowflakeChars[Math.floor(Math.random() * config.snowflakeChars.length)];
        snowflake.textContent = char;
        
        // Random properties
        const size = config.minSize + Math.random() * (config.maxSize - config.minSize);
        const left = Math.random() * 100;
        const duration = config.minDuration + Math.random() * (config.maxDuration - config.minDuration);
        const delay = Math.random() * config.maxDelay;
        const opacity = 0.5 + Math.random() * 0.5;
        
        // Apply styles
        snowflake.style.cssText = `
            left: ${left}%;
            font-size: ${size}em;
            animation-duration: ${duration}s;
            animation-delay: ${delay}s;
            opacity: ${opacity};
        `;
        
        container.appendChild(snowflake);
        
        // Remove and recreate snowflake after animation
        const totalTime = (duration + delay) * 1000;
        setTimeout(() => {
            if (snowflake.parentNode) {
                snowflake.remove();
                createSnowflake(container);
            }
        }, totalTime);
    }

    // Initialize snow effect
    function initSnow() {
        injectStyles();
        const container = createSnowContainer();
        
        // Clear existing snowflakes
        container.innerHTML = '';
        
        // Create initial snowflakes with staggered timing
        for (let i = 0; i < config.snowflakeCount; i++) {
            setTimeout(() => {
                createSnowflake(container);
            }, i * 50);
        }
    }

    // Add decorative elements (corner snowflakes)
    function addDecorations() {
        // Check if decorations already exist
        if (document.querySelector('.snowflake-decoration')) return;
        
        // Snowflake decorations on corners
        const positions = ['top-left', 'top-right', 'mid-left', 'mid-right'];
        positions.forEach(pos => {
            const decoration = document.createElement('div');
            decoration.className = `snowflake-decoration ${pos}`;
            decoration.textContent = '❄';
            document.body.appendChild(decoration);
        });
    }

    // Stop snow effect
    function stopSnow() {
        const container = document.querySelector('.snow-container');
        if (container) container.remove();
        
        document.querySelectorAll('.snowflake-decoration').forEach(el => el.remove());
    }

    // Start when DOM is ready - Auto-run on all pages
    function init() {
        initSnow();
        addDecorations();
    }

    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', init);
    } else {
        init();
    }

    // Expose to global for manual control
    window.SnowEffect = {
        start: init,
        stop: stopSnow,
        config: config
    };
})();
