// Admin Comments Management - Updated for new UI
const COMMENTS_API_URL = 'http://localhost:3000/api/news';

let allComments = [];
let allNews = [];

// Load on page ready
document.addEventListener('DOMContentLoaded', () => {
    loadComments();
    loadNewsList();
});

// Load all comments
async function loadComments() {
    try {
        console.log('🔄 Loading comments...');
        const response = await fetch(`${COMMENTS_API_URL}/admin/comments/all`, {
            credentials: 'include'
        });
        
        console.log('📊 Response status:', response.status);
        const result = await response.json();
        console.log('📦 Result:', result);
        
        if (result.success) {
            allComments = result.data || [];
            console.log('✅ Loaded', allComments.length, 'comments');
            updateStats();
            displayComments(allComments);
        } else {
            console.error('❌ API error:', result.message);
            showError(result.message || 'Không thể tải bình luận');
        }
    } catch (error) {
        console.error('❌ Lỗi:', error);
        showError('Không thể kết nối đến server');
    }
}

// Load news list for filter
async function loadNewsList() {
    try {
        const response = await fetch(`${COMMENTS_API_URL}/admin/all`, {
            credentials: 'include'
        });
        const result = await response.json();
        if (result.success) {
            allNews = result.data;
            const select = document.getElementById('news-filter');
            if (select) {
                result.data.forEach(news => {
                    const option = document.createElement('option');
                    option.value = news.ma_tin_tuc;
                    option.textContent = news.tieu_de.substring(0, 40) + (news.tieu_de.length > 40 ? '...' : '');
                    select.appendChild(option);
                });
            }
        }
    } catch (error) {
        console.error('Lỗi tải tin tức:', error);
    }
}

// Update statistics
function updateStats() {
    const total = allComments.length;
    const approved = allComments.filter(c => c.trang_thai === 'approved').length;
    const pending = allComments.filter(c => c.trang_thai === 'pending').length;
    const rejected = allComments.filter(c => c.trang_thai === 'rejected').length;
    
    const statTotal = document.getElementById('stat-total');
    const statApproved = document.getElementById('stat-approved');
    const statPending = document.getElementById('stat-pending');
    const statRejected = document.getElementById('stat-rejected');
    
    if (statTotal) statTotal.textContent = total;
    if (statApproved) statApproved.textContent = approved;
    if (statPending) statPending.textContent = pending;
    if (statRejected) statRejected.textContent = rejected;
}

// Display comments
function displayComments(comments) {
    const tbody = document.getElementById('comments-table');
    if (!tbody) return;
    
    if (comments.length === 0) {
        tbody.innerHTML = `<tr><td colspan="6" class="text-center py-12 text-slate-500">Không có bình luận nào</td></tr>`;
        return;
    }
    
    tbody.innerHTML = comments.map(comment => `
        <tr class="border-b border-slate-100 hover:bg-slate-50">
            <td class="py-4 px-4">
                <div class="flex items-center space-x-3">
                    <img src="${getAvatarUrl(comment.anh_dai_dien, comment.ten_nguoi_binh_luan)}" 
                         class="w-10 h-10 rounded-full object-cover"
                         onerror="this.src='https://ui-avatars.com/api/?name=${encodeURIComponent(comment.ten_nguoi_binh_luan)}&background=3b82f6&color=fff'">
                    <div>
                        <p class="font-medium text-slate-800">${comment.ten_nguoi_binh_luan}</p>
                        <p class="text-xs text-slate-500">${comment.email_nguoi_binh_luan || ''}</p>
                    </div>
                </div>
            </td>
            <td class="py-4 px-4">
                <p class="text-sm text-slate-700 max-w-xs truncate">${escapeHtml(comment.noi_dung)}</p>
            </td>
            <td class="py-4 px-4">
                <p class="text-sm text-slate-600 max-w-[150px] truncate">${comment.tieu_de_tin_tuc || 'N/A'}</p>
            </td>
            <td class="py-4 px-4">
                ${getStatusBadge(comment.trang_thai)}
            </td>
            <td class="py-4 px-4 text-sm text-slate-500">
                ${formatDate(comment.ngay_binh_luan)}
            </td>
            <td class="py-4 px-4 text-center">
                <div class="flex justify-center gap-2">
                    ${comment.trang_thai !== 'approved' ? `
                        <button onclick="updateStatus(${comment.ma_binh_luan}, 'approved')" 
                            class="text-green-600 hover:text-green-800" title="Duyệt">
                            <i class="fas fa-check"></i>
                        </button>
                    ` : ''}
                    ${comment.trang_thai !== 'rejected' ? `
                        <button onclick="updateStatus(${comment.ma_binh_luan}, 'rejected')" 
                            class="text-yellow-600 hover:text-yellow-800" title="Từ chối">
                            <i class="fas fa-ban"></i>
                        </button>
                    ` : ''}
                    <button onclick="deleteComment(${comment.ma_binh_luan})" 
                        class="text-red-600 hover:text-red-800" title="Xóa">
                        <i class="fas fa-trash"></i>
                    </button>
                </div>
            </td>
        </tr>
    `).join('');
}

// Get status badge
function getStatusBadge(status) {
    const badges = {
        approved: '<span class="px-2 py-1 text-xs font-medium rounded-full bg-green-100 text-green-700">Đã duyệt</span>',
        pending: '<span class="px-2 py-1 text-xs font-medium rounded-full bg-yellow-100 text-yellow-700">Chờ duyệt</span>',
        rejected: '<span class="px-2 py-1 text-xs font-medium rounded-full bg-red-100 text-red-700">Từ chối</span>'
    };
    return badges[status] || badges.pending;
}

// Update comment status
async function updateStatus(id, status) {
    try {
        const response = await fetch(`${COMMENTS_API_URL}/admin/comments/${id}/status`, {
            method: 'PUT',
            headers: { 'Content-Type': 'application/json' },
            credentials: 'include',
            body: JSON.stringify({ trang_thai: status })
        });
        
        const result = await response.json();
        
        if (result.success) {
            loadComments();
        } else {
            alert(result.message || 'Lỗi cập nhật');
        }
    } catch (error) {
        console.error('Lỗi:', error);
        alert('Không thể kết nối đến server');
    }
}

// Delete comment
async function deleteComment(id) {
    if (!confirm('Bạn có chắc muốn xóa bình luận này?')) return;
    
    try {
        const response = await fetch(`${COMMENTS_API_URL}/admin/comments/${id}`, {
            method: 'DELETE',
            credentials: 'include'
        });
        
        const result = await response.json();
        
        if (result.success) {
            loadComments();
        } else {
            alert(result.message || 'Lỗi xóa');
        }
    } catch (error) {
        console.error('Lỗi:', error);
        alert('Không thể kết nối đến server');
    }
}

// Apply filters
function applyFilters() {
    const search = document.getElementById('search')?.value.toLowerCase() || '';
    const status = document.getElementById('status-filter')?.value || '';
    const newsId = document.getElementById('news-filter')?.value || '';
    
    const filtered = allComments.filter(c => {
        const matchSearch = !search || 
            c.ten_nguoi_binh_luan.toLowerCase().includes(search) ||
            c.noi_dung.toLowerCase().includes(search);
        const matchStatus = !status || c.trang_thai === status;
        const matchNews = !newsId || c.ma_tin_tuc == newsId;
        return matchSearch && matchStatus && matchNews;
    });
    
    displayComments(filtered);
}

// Helpers
function getAvatarUrl(anh_dai_dien, ten) {
    if (anh_dai_dien) {
        if (anh_dai_dien.startsWith('http')) return anh_dai_dien;
        if (anh_dai_dien.startsWith('/')) return `http://localhost:3000${anh_dai_dien}`;
        return `http://localhost:3000/${anh_dai_dien}`;
    }
    return `https://ui-avatars.com/api/?name=${encodeURIComponent(ten || 'U')}&background=3b82f6&color=fff`;
}

function formatDate(dateStr) {
    if (!dateStr) return '-';
    const date = new Date(dateStr);
    return date.toLocaleDateString('vi-VN') + ' ' + date.toLocaleTimeString('vi-VN', { hour: '2-digit', minute: '2-digit' });
}

function escapeHtml(text) {
    const div = document.createElement('div');
    div.textContent = text;
    return div.innerHTML;
}

function showError(message) {
    const tbody = document.getElementById('comments-table');
    if (tbody) {
        tbody.innerHTML = `<tr><td colspan="6" class="text-center py-12 text-red-500"><i class="fas fa-exclamation-circle text-2xl mb-2"></i><p>${message}</p></td></tr>`;
    }
}

// Search on enter
document.getElementById('search')?.addEventListener('keypress', (e) => {
    if (e.key === 'Enter') applyFilters();
});
