// API Configuration
const API_URL = 'http://localhost:3000/api/news';

// Format date to Vietnamese
function formatDate(dateString) {
    const date = new Date(dateString);
    const day = date.getDate().toString().padStart(2, '0');
    const month = (date.getMonth() + 1).toString().padStart(2, '0');
    const year = date.getFullYear();
    return `${day}/${month}/${year}`;
}

// Format views count
function formatViews(views) {
    if (views >= 1000) {
        return (views / 1000).toFixed(1) + 'K';
    }
    return views;
}

// Load news detail from API
async function loadNewsDetail() {
    try {
        // Get news ID from URL
        const urlParams = new URLSearchParams(window.location.search);
        const newsId = urlParams.get('id');

        if (!newsId) {
            showError('Không tìm thấy tin tức');
            return;
        }

        showLoading();

        // Fetch news detail from API
        const response = await fetch(`${API_URL}/${newsId}`);
        const result = await response.json();

        if (result.success && result.data) {
            displayNewsDetail(result.data);
            displayRelatedNews(result.data.related || []);
            // Load comments and reactions
            loadComments(newsId);
            loadReactions(newsId);
        } else {
            showError('Không tìm thấy tin tức');
        }

    } catch (error) {
        console.error('Lỗi tải tin tức:', error);
        showError('Không thể kết nối đến server');
    } finally {
        hideLoading();
    }
}

// Display news detail
function displayNewsDetail(news) {
    // Update page title
    document.title = `${news.tieu_de} - Nhà hàng Phương Nam Vĩnh Long`;

    // Update breadcrumb
    const breadcrumb = document.querySelector('.breadcrumb-current');
    if (breadcrumb) {
        breadcrumb.textContent = news.tieu_de;
    }

    // Update article header
    const articleHeader = document.querySelector('article .p-8.pb-6');
    if (articleHeader) {
        articleHeader.innerHTML = `
            <div class="flex items-center space-x-4 text-sm text-gray-500 mb-4">
                <span><i class="far fa-calendar mr-2"></i> ${formatDate(news.ngay_dang)}</span>
                <span><i class="far fa-user mr-2"></i> ${news.tac_gia || 'Admin'}</span>
                <span><i class="far fa-eye mr-2"></i> ${formatViews(news.luot_xem)} lượt xem</span>
            </div>
            <h1 class="font-dancing text-4xl font-bold mb-6 text-gray-800">
                ${news.tieu_de}
            </h1>
        `;
    }

    // Update featured image
    const featuredImage = document.querySelector('article img');
    if (featuredImage && news.anh_dai_dien) {
        featuredImage.src = `http://localhost:3000/${news.anh_dai_dien}`;
        featuredImage.alt = news.tieu_de;
    }

    // Update article content
    const contentDiv = document.querySelector('.news-content');
    if (contentDiv) {
        // If noi_dung contains HTML, use it directly
        // Otherwise, wrap it in paragraphs
        if (news.noi_dung) {
            contentDiv.innerHTML = `
                <div class="prose max-w-none mb-8">
                    ${news.tom_tat ? `<p class="text-lg text-gray-700 leading-relaxed mb-6">${news.tom_tat}</p>` : ''}
                    ${news.noi_dung}
                </div>
            `;
        } else {
            contentDiv.innerHTML = `
                <div class="prose max-w-none mb-8">
                    <p class="text-lg text-gray-700 leading-relaxed mb-6">
                        ${news.tom_tat || 'Nội dung đang được cập nhật...'}
                    </p>
                </div>
            `;
        }
    }
}

// Display related news
function displayRelatedNews(relatedNews) {
    const relatedContainer = document.getElementById('related-news-container');
    const relatedSection = document.getElementById('related-news-section');
    
    if (!relatedContainer) {
        return;
    }

    if (relatedNews.length === 0) {
        // Hide related section if no related news
        if (relatedSection) {
            relatedSection.style.display = 'none';
        }
        return;
    }

    relatedContainer.innerHTML = relatedNews.map(news => `
        <a href="tin-tuc-chi-tiet.html?id=${news.ma_tin_tuc}" class="group">
            <img src="${news.anh_dai_dien ? `http://localhost:3000/${news.anh_dai_dien}` : 'images/default-news.jpg'}"
                 alt="${news.tieu_de}"
                 class="w-full h-48 object-cover rounded-lg mb-3 group-hover:opacity-90 transition">
            <h4 class="font-bold text-lg group-hover:text-orange-600 transition line-clamp-2">
                ${news.tieu_de}
            </h4>
            <p class="text-sm text-gray-500 mt-2">${formatDate(news.ngay_dang)}</p>
        </a>
    `).join('');
}

// Share functions
function shareOnFacebook() {
    const url = encodeURIComponent(window.location.href);
    window.open(`https://www.facebook.com/sharer/sharer.php?u=${url}`, '_blank', 'width=600,height=400');
}

function shareOnTwitter() {
    const url = encodeURIComponent(window.location.href);
    const title = encodeURIComponent(document.title);
    window.open(`https://twitter.com/intent/tweet?url=${url}&text=${title}`, '_blank', 'width=600,height=400');
}

function copyLink() {
    navigator.clipboard.writeText(window.location.href).then(() => {
        alert('Đã sao chép link vào clipboard!');
    }).catch(err => {
        console.error('Lỗi sao chép:', err);
    });
}

// Loading helpers
function showLoading() {
    const contentDiv = document.querySelector('.news-content');
    if (contentDiv) {
        // Use LoadingManager if available
        if (typeof LoadingManager !== 'undefined') {
            LoadingManager.showSectionLoading(contentDiv, 'Đang tải tin tức...');
        } else {
            contentDiv.innerHTML = `
                <div class="text-center py-12">
                    <i class="fas fa-spinner fa-spin text-4xl text-orange-600 mb-4"></i>
                    <p class="text-gray-600">Đang tải tin tức...</p>
                </div>
            `;
        }
    }
}

function hideLoading() {
    // Loading will be replaced by content
}

function showError(message) {
    const contentDiv = document.querySelector('.news-content');
    if (contentDiv) {
        contentDiv.innerHTML = `
            <div class="text-center py-12">
                <i class="fas fa-exclamation-triangle text-4xl text-red-500 mb-4"></i>
                <p class="text-gray-600 text-lg mb-4">${message}</p>
                <a href="tin-tuc.html" class="inline-block bg-orange-600 text-white px-6 py-3 rounded-lg hover:bg-orange-700 transition">
                    <i class="fas fa-arrow-left mr-2"></i>Quay lại trang tin tức
                </a>
            </div>
        `;
    }

    // Also update title
    const articleHeader = document.querySelector('article .p-8.pb-6');
    if (articleHeader) {
        articleHeader.innerHTML = `
            <h1 class="font-dancing text-4xl font-bold mb-6 text-gray-800">
                ${message}
            </h1>
        `;
    }
}

// Load comments for news
async function loadComments(newsId) {
    try {
        const token = localStorage.getItem('token');
        const headers = {};
        if (token) {
            headers['Authorization'] = `Bearer ${token}`;
        }

        const response = await fetch(`${API_URL}/${newsId}/comments`, {
            headers: headers,
            credentials: 'include'
        });
        const result = await response.json();

        if (result.success) {
            displayComments(result.data, result.total);
        }
    } catch (error) {
        console.error('Lỗi tải bình luận:', error);
    }
}

// Display comments with reactions and replies
function displayComments(comments, totalCount) {
    const commentsContainer = document.querySelector('.comments-list');
    const commentsCount = document.querySelector('.comments-count');
    
    if (!commentsContainer) return;

    if (commentsCount) {
        commentsCount.textContent = totalCount || comments.length;
    }

    if (comments.length === 0) {
        commentsContainer.innerHTML = `
            <div class="text-center py-8 text-gray-500">
                <i class="far fa-comments text-4xl mb-3"></i>
                <p>Chưa có bình luận nào. Hãy là người đầu tiên bình luận!</p>
            </div>
        `;
        return;
    }

    commentsContainer.innerHTML = comments.map(comment => renderComment(comment)).join('');
}

// Render single comment with reactions and replies
function renderComment(comment, isReply = false) {
    const avatar = getAvatarUrl(comment.anh_dai_dien, comment.ten_nguoi_binh_luan);
    const fallbackAvatar = `https://ui-avatars.com/api/?name=${encodeURIComponent(comment.ten_nguoi_binh_luan)}&size=50&background=f97316&color=fff`;
    const timeAgo = getTimeAgo(comment.ngay_binh_luan);
    
    // Reaction icons
    const reactionIcons = { like: '👍', love: '❤️', haha: '😄', wow: '😮', sad: '😢', angry: '😠' };
    
    // Tính tổng reactions
    const totalReactions = comment.reactions ? 
        Object.values(comment.reactions).reduce((a, b) => a + b, 0) : 0;
    
    // Hiển thị reactions summary
    let reactionsSummary = '';
    if (totalReactions > 0) {
        const topReactions = Object.entries(comment.reactions || {})
            .filter(([_, count]) => count > 0)
            .sort((a, b) => b[1] - a[1])
            .slice(0, 3);
        reactionsSummary = topReactions.map(([type, _]) => reactionIcons[type]).join('') + ` ${totalReactions}`;
    }

    // Render replies
    const repliesHtml = (comment.replies && comment.replies.length > 0) 
        ? `<div class="ml-8 mt-4 space-y-4">${comment.replies.map(reply => renderComment(reply, true)).join('')}</div>`
        : '';

    return `
        <div class="comment-item ${isReply ? 'ml-8' : ''} mb-6" data-comment-id="${comment.ma_binh_luan}">
            <div class="flex space-x-4">
                <img src="${avatar}" alt="${comment.ten_nguoi_binh_luan}"
                    class="${isReply ? 'w-10 h-10' : 'w-12 h-12'} rounded-full flex-shrink-0 object-cover"
                    onerror="this.onerror=null; this.src='${fallbackAvatar}'">
                <div class="flex-1">
                    <div class="bg-gray-50 rounded-lg p-4">
                        <div class="flex items-center justify-between mb-2">
                            <h4 class="font-bold text-gray-800 ${isReply ? 'text-sm' : ''}">${comment.ten_nguoi_binh_luan}</h4>
                            <span class="text-sm text-gray-500">${timeAgo}</span>
                        </div>
                        <p class="text-gray-700">${escapeHtml(comment.noi_dung)}</p>
                    </div>
                    
                    <!-- Actions: Reactions & Reply -->
                    <div class="flex items-center gap-4 mt-2 text-sm">
                        <!-- Reaction button with picker -->
                        <div class="relative reaction-wrapper">
                            <button class="reaction-btn-trigger text-gray-500 hover:text-orange-600 flex items-center gap-1"
                                data-comment-id="${comment.ma_binh_luan}"
                                data-current-reaction="${comment.userReaction || ''}">
                                <span class="reaction-icon ${comment.userReaction ? 'text-orange-600' : ''}">${comment.userReaction ? reactionIcons[comment.userReaction] : '👍'}</span>
                                <span class="reaction-text">${comment.userReaction ? getReactionLabel(comment.userReaction) : 'Thích'}</span>
                            </button>
                            <!-- Reaction picker - hiện khi hover/hold -->
                            <div class="reaction-picker-popup absolute bottom-full left-0 mb-2 bg-white rounded-full shadow-xl p-2 flex gap-1 z-20 opacity-0 invisible transition-all duration-200">
                                ${Object.entries(reactionIcons).map(([type, icon]) => `
                                    <button class="reaction-option hover:scale-125 transition-transform text-2xl p-1 rounded-full hover:bg-gray-100 ${comment.userReaction === type ? 'bg-orange-100' : ''}"
                                        data-reaction-type="${type}"
                                        data-comment-id="${comment.ma_binh_luan}"
                                        title="${getReactionLabel(type)}">
                                        ${icon}
                                    </button>
                                `).join('')}
                            </div>
                        </div>
                        
                        <!-- Reply button -->
                        <button onclick="showReplyForm(${comment.ma_binh_luan})" 
                            class="text-gray-500 hover:text-orange-600 flex items-center gap-1">
                            <i class="far fa-comment"></i>
                            <span>Trả lời</span>
                        </button>
                        
                        <!-- Reactions summary -->
                        ${reactionsSummary ? `<span class="text-gray-500">${reactionsSummary}</span>` : ''}
                    </div>
                    
                    <!-- Reply form (hidden by default) -->
                    <div id="reply-form-${comment.ma_binh_luan}" class="hidden mt-3">
                        <div class="flex gap-2">
                            <input type="text" placeholder="Viết trả lời..." 
                                class="flex-1 border rounded-lg px-3 py-2 text-sm focus:outline-none focus:border-orange-600"
                                id="reply-input-${comment.ma_binh_luan}"
                                onkeypress="if(event.key==='Enter') submitReply(${comment.ma_binh_luan})">
                            <button onclick="submitReply(${comment.ma_binh_luan})" 
                                class="bg-orange-600 text-white px-4 py-2 rounded-lg text-sm hover:bg-orange-700">
                                Gửi
                            </button>
                            <button onclick="hideReplyForm(${comment.ma_binh_luan})" 
                                class="text-gray-500 px-2 hover:text-gray-700">
                                ✕
                            </button>
                        </div>
                    </div>
                </div>
            </div>
            ${repliesHtml}
        </div>
    `;
}

// Get avatar URL helper
function getAvatarUrl(anh_dai_dien, ten) {
    if (anh_dai_dien) {
        if (anh_dai_dien.startsWith('http')) return anh_dai_dien;
        if (anh_dai_dien.startsWith('/')) return `http://localhost:3000${anh_dai_dien}`;
        return `http://localhost:3000/${anh_dai_dien}`;
    }
    return `https://ui-avatars.com/api/?name=${encodeURIComponent(ten)}&size=50&background=f97316&color=fff`;
}

// Show reply form
function showReplyForm(commentId) {
    const form = document.getElementById(`reply-form-${commentId}`);
    if (form) {
        form.classList.remove('hidden');
        document.getElementById(`reply-input-${commentId}`).focus();
    }
}

// Hide reply form
function hideReplyForm(commentId) {
    const form = document.getElementById(`reply-form-${commentId}`);
    if (form) form.classList.add('hidden');
}

// Submit reply
async function submitReply(commentId) {
    const input = document.getElementById(`reply-input-${commentId}`);
    const noi_dung = input.value.trim();
    
    if (!noi_dung) {
        alert('Vui lòng nhập nội dung trả lời');
        return;
    }

    const token = localStorage.getItem('token');
    if (!token) {
        alert('Vui lòng đăng nhập để trả lời');
        return;
    }

    try {
        const response = await fetch(`${API_URL}/comments/${commentId}/replies`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${token}`
            },
            credentials: 'include',
            body: JSON.stringify({ noi_dung })
        });

        const result = await response.json();
        if (result.success) {
            input.value = '';
            hideReplyForm(commentId);
            // Reload comments
            const urlParams = new URLSearchParams(window.location.search);
            loadComments(urlParams.get('id'));
        } else {
            alert(result.message || 'Không thể gửi trả lời');
        }
    } catch (error) {
        console.error('Lỗi gửi trả lời:', error);
        alert('Không thể gửi trả lời');
    }
}

// React to comment
async function reactToComment(commentId, reactionType) {
    const token = localStorage.getItem('token');
    if (!token) {
        alert('Vui lòng đăng nhập để thả cảm xúc');
        return;
    }

    try {
        const response = await fetch(`${API_URL}/comments/${commentId}/reactions`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${token}`
            },
            credentials: 'include',
            body: JSON.stringify({ loai_cam_xuc: reactionType })
        });

        const result = await response.json();
        if (result.success) {
            // Reload comments
            const urlParams = new URLSearchParams(window.location.search);
            loadComments(urlParams.get('id'));
        } else {
            alert(result.message || 'Không thể thả cảm xúc');
        }
    } catch (error) {
        console.error('Lỗi thả cảm xúc:', error);
    }
}

// Get reaction label in Vietnamese
function getReactionLabel(type) {
    const labels = {
        like: 'Thích',
        love: 'Yêu thích', 
        haha: 'Haha',
        wow: 'Wow',
        sad: 'Buồn',
        angry: 'Phẫn nộ'
    };
    return labels[type] || 'Thích';
}

// Make functions global
window.showReplyForm = showReplyForm;
window.hideReplyForm = hideReplyForm;
window.submitReply = submitReply;
window.reactToComment = reactToComment;
window.getReactionLabel = getReactionLabel;

// Setup reaction interactions (click nhanh = like, hover = show picker)
function setupReactionInteractions() {
    let holdTimer = null;
    let isHolding = false;

    document.addEventListener('mousedown', (e) => {
        const trigger = e.target.closest('.reaction-btn-trigger');
        if (!trigger) return;

        isHolding = false;
        holdTimer = setTimeout(() => {
            isHolding = true;
            // Show picker on hold
            const picker = trigger.parentElement.querySelector('.reaction-picker-popup');
            if (picker) {
                picker.classList.remove('opacity-0', 'invisible');
                picker.classList.add('opacity-100', 'visible');
            }
        }, 300); // 300ms hold để hiện picker
    });

    document.addEventListener('mouseup', (e) => {
        const trigger = e.target.closest('.reaction-btn-trigger');
        
        if (holdTimer) {
            clearTimeout(holdTimer);
            holdTimer = null;
        }

        // Nếu không hold (click nhanh) -> toggle like
        if (trigger && !isHolding) {
            const commentId = trigger.dataset.commentId;
            const currentReaction = trigger.dataset.currentReaction;
            
            if (currentReaction) {
                // Đã có reaction -> bỏ reaction (click lại cùng loại)
                reactToComment(commentId, currentReaction);
            } else {
                // Chưa có -> like
                reactToComment(commentId, 'like');
            }
        }

        isHolding = false;
    });

    // Click vào reaction option
    document.addEventListener('click', (e) => {
        const option = e.target.closest('.reaction-option');
        if (option) {
            e.preventDefault();
            e.stopPropagation();
            const commentId = option.dataset.commentId;
            const reactionType = option.dataset.reactionType;
            reactToComment(commentId, reactionType);
            
            // Hide picker
            const picker = option.closest('.reaction-picker-popup');
            if (picker) {
                picker.classList.add('opacity-0', 'invisible');
                picker.classList.remove('opacity-100', 'visible');
            }
        }
    });

    // Hide picker khi mouse leave
    document.addEventListener('mouseleave', (e) => {
        if (e.target.closest('.reaction-wrapper')) {
            setTimeout(() => {
                const wrapper = e.target.closest('.reaction-wrapper');
                if (wrapper && !wrapper.matches(':hover')) {
                    const picker = wrapper.querySelector('.reaction-picker-popup');
                    if (picker) {
                        picker.classList.add('opacity-0', 'invisible');
                        picker.classList.remove('opacity-100', 'visible');
                    }
                }
            }, 300);
        }
    }, true);

    // Show picker on hover (sau 500ms)
    document.addEventListener('mouseenter', (e) => {
        const wrapper = e.target.closest('.reaction-wrapper');
        if (wrapper) {
            setTimeout(() => {
                if (wrapper.matches(':hover')) {
                    const picker = wrapper.querySelector('.reaction-picker-popup');
                    if (picker) {
                        picker.classList.remove('opacity-0', 'invisible');
                        picker.classList.add('opacity-100', 'visible');
                    }
                }
            }, 500);
        }
    }, true);
}

// Get time ago string
function getTimeAgo(dateString) {
    const date = new Date(dateString);
    const now = new Date();
    const seconds = Math.floor((now - date) / 1000);

    if (seconds < 60) return 'Vừa xong';
    if (seconds < 3600) return `${Math.floor(seconds / 60)} phút trước`;
    if (seconds < 86400) return `${Math.floor(seconds / 3600)} giờ trước`;
    if (seconds < 604800) return `${Math.floor(seconds / 86400)} ngày trước`;
    
    return formatDate(dateString);
}

// Escape HTML to prevent XSS
function escapeHtml(text) {
    const div = document.createElement('div');
    div.textContent = text;
    return div.innerHTML;
}

// Submit comment (requires login)
async function submitComment(event) {
    event.preventDefault();

    const urlParams = new URLSearchParams(window.location.search);
    const newsId = urlParams.get('id');

    if (!newsId) return;

    const form = event.target;
    const noi_dung = form.querySelector('[name="comment"]').value.trim();

    if (!noi_dung) {
        alert('Vui lòng nhập nội dung bình luận');
        return;
    }

    try {
        const submitButton = form.querySelector('button[type="submit"]');
        submitButton.disabled = true;
        submitButton.innerHTML = '<i class="fas fa-spinner fa-spin mr-2"></i>Đang gửi...';

        // Lấy token từ localStorage
        const token = localStorage.getItem('token');
        const headers = {
            'Content-Type': 'application/json'
        };
        if (token) {
            headers['Authorization'] = `Bearer ${token}`;
        }

        const response = await fetch(`${API_URL}/${newsId}/comments`, {
            method: 'POST',
            headers: headers,
            credentials: 'include', // Gửi cookie session
            body: JSON.stringify({ noi_dung })
        });

        const result = await response.json();

        if (result.success) {
            alert('Bình luận của bạn đã được gửi thành công!');
            form.reset();
            // Reload comments
            loadComments(newsId);
        } else {
            if (response.status === 401) {
                alert('Vui lòng đăng nhập để bình luận');
                window.location.href = 'dang-nhap.html?redirect=' + encodeURIComponent(window.location.href);
            } else {
                alert(result.message || 'Không thể gửi bình luận');
            }
        }
    } catch (error) {
        console.error('Lỗi gửi bình luận:', error);
        alert('Không thể gửi bình luận. Vui lòng thử lại sau.');
    } finally {
        const submitButton = form.querySelector('button[type="submit"]');
        submitButton.disabled = false;
        submitButton.innerHTML = '<i class="far fa-paper-plane mr-2"></i>Gửi bình luận';
    }
}

// Setup comment form based on login status
async function setupCommentForm() {
    try {
        console.log('🔍 Checking login status...');
        
        // Lấy token từ localStorage
        const token = localStorage.getItem('token');
        const headers = {};
        if (token) {
            headers['Authorization'] = `Bearer ${token}`;
        }
        
        const response = await fetch('http://localhost:3000/api/auth/check-session', {
            credentials: 'include',
            headers: headers
        });
        const data = await response.json();
        console.log('📊 Session check result:', data);
        const isLoggedIn = data.loggedIn;

        const commentForm = document.getElementById('comment-form');
        const loginMessage = document.getElementById('login-required-message');

        if (!isLoggedIn) {
            console.log('❌ User not logged in - hiding comment form');
            if (commentForm) commentForm.style.display = 'none';
            if (loginMessage) loginMessage.classList.remove('hidden');
        } else {
            console.log('✅ User logged in - showing comment form');
            if (commentForm) commentForm.style.display = 'block';
            if (loginMessage) loginMessage.classList.add('hidden');
        }
    } catch (error) {
        console.error('Lỗi kiểm tra đăng nhập:', error);
        // Nếu lỗi, ẩn form để an toàn
        const commentForm = document.getElementById('comment-form');
        const loginMessage = document.getElementById('login-required-message');
        if (commentForm) commentForm.style.display = 'none';
        if (loginMessage) loginMessage.classList.remove('hidden');
    }
}

// Load reactions for news
async function loadReactions(newsId) {
    try {
        const response = await fetch(`${API_URL}/${newsId}/reactions`);
        const result = await response.json();

        if (result.success) {
            displayReactions(result.data);
        }
    } catch (error) {
        console.error('Lỗi tải cảm xúc:', error);
    }
}

// Display reactions
function displayReactions(data) {
    const reactionsContainer = document.querySelector('.reactions-container');
    if (!reactionsContainer) return;

    const { reactions, total, userReaction } = data;

    const reactionIcons = {
        like: '👍',
        love: '❤️',
        haha: '😄',
        wow: '😮',
        sad: '😢',
        angry: '😠'
    };

    const reactionLabels = {
        like: 'Thích',
        love: 'Yêu thích',
        haha: 'Haha',
        wow: 'Wow',
        sad: 'Buồn',
        angry: 'Phẫn nộ'
    };

    reactionsContainer.innerHTML = `
        <div class="flex items-center gap-2 mb-4">
            <span class="text-gray-600 font-medium">Cảm xúc:</span>
            <div class="flex gap-2">
                ${Object.keys(reactionIcons).map(type => `
                    <button 
                        onclick="toggleReaction('${type}')"
                        class="reaction-btn ${userReaction === type ? 'active' : ''}"
                        data-reaction="${type}"
                        title="${reactionLabels[type]}">
                        <span class="text-2xl">${reactionIcons[type]}</span>
                        <span class="count">${reactions[type] || 0}</span>
                    </button>
                `).join('')}
            </div>
            <span class="text-gray-500 text-sm ml-2">${total} cảm xúc</span>
        </div>
    `;
}

// Toggle reaction
async function toggleReaction(reactionType) {
    const urlParams = new URLSearchParams(window.location.search);
    const newsId = urlParams.get('id');

    if (!newsId) return;

    try {
        // Lấy token từ localStorage
        const token = localStorage.getItem('token');
        const headers = {
            'Content-Type': 'application/json'
        };
        if (token) {
            headers['Authorization'] = `Bearer ${token}`;
        }

        const response = await fetch(`${API_URL}/${newsId}/reactions`, {
            method: 'POST',
            headers: headers,
            credentials: 'include', // Gửi cookie session
            body: JSON.stringify({ loai_cam_xuc: reactionType })
        });

        const result = await response.json();

        if (result.success) {
            // Reload reactions
            loadReactions(newsId);
        } else {
            if (response.status === 401) {
                alert('Vui lòng đăng nhập để thả cảm xúc');
                window.location.href = 'dang-nhap.html?redirect=' + encodeURIComponent(window.location.href);
            } else {
                alert(result.message || 'Không thể thả cảm xúc');
            }
        }
    } catch (error) {
        console.error('Lỗi thả cảm xúc:', error);
        alert('Không thể thả cảm xúc. Vui lòng thử lại sau.');
    }
}

// Make toggleReaction global
window.toggleReaction = toggleReaction;

// Initialize on page load
document.addEventListener('DOMContentLoaded', function() {
    loadNewsDetail();
    setupCommentForm();
    setupReactionInteractions(); // Setup reaction UX

    // Setup comment form
    const commentForm = document.getElementById('comment-form');
    if (commentForm) {
        commentForm.addEventListener('submit', submitComment);
    }
});
