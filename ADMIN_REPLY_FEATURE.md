# Tính năng Admin Trả lời Bình luận

## Tổng quan

Đã thêm chức năng cho admin trả lời bình luận của người dùng trên cả bài viết tin tức và đánh giá món ăn. Admin có thể trả lời trực tiếp từ trang quản trị và câu trả lời sẽ hiển thị với tên "Admin" trên trang người dùng.

## Thay đổi Database

### 1. Bảng mới: `tra_loi_danh_gia`

Tạo bảng lưu trả lời của admin cho đánh giá sản phẩm:

```sql
CREATE TABLE IF NOT EXISTS `tra_loi_danh_gia` (
  `ma_tra_loi` INT NOT NULL AUTO_INCREMENT,
  `ma_danh_gia` INT NOT NULL COMMENT 'ID đánh giá được trả lời',
  `noi_dung` TEXT NOT NULL COMMENT 'Nội dung trả lời',
  `ten_admin` VARCHAR(150) DEFAULT 'Admin' COMMENT 'Tên admin trả lời',
  `ngay_tra_loi` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ma_tra_loi`),
  KEY `ma_danh_gia` (`ma_danh_gia`),
  CONSTRAINT `tra_loi_danh_gia_ibfk_1` FOREIGN KEY (`ma_danh_gia`) 
    REFERENCES `danh_gia_san_pham` (`ma_danh_gia`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
```

**Chạy migration:**
```bash
cd backend/scripts
mysql -u root -p amthuc_phuongnam < add_review_replies.sql
```

### 2. Bảng hiện có: `binh_luan_tin_tuc`

Bảng này đã có sẵn cột `ma_binh_luan_cha` để hỗ trợ reply, không cần thay đổi.

## Backend API

### 1. API Trả lời Bình luận Tin tức

#### Endpoint: `POST /api/news/comments/:commentId/reply`

**Headers:**
- Cookie: Session admin đã đăng nhập

**Body:**
```json
{
  "noi_dung": "Cảm ơn bạn đã góp ý. Chúng tôi sẽ cải thiện dịch vụ."
}
```

**Response:**
```json
{
  "success": true,
  "message": "Trả lời bình luận thành công",
  "data": {
    "ma_binh_luan": 123
  }
}
```

**Logic:**
- Kiểm tra admin đã đăng nhập
- Lấy tên admin từ session
- Tạo bình luận mới với `ma_binh_luan_cha` = ID bình luận gốc
- Tên hiển thị: Tên admin từ session hoặc "Admin"
- Email: "admin@phuongnam.vn"
- Trạng thái: "approved" (tự động duyệt)

### 2. API Trả lời Đánh giá Món ăn

#### Endpoint: `POST /api/reviews/:reviewId/reply`

**Headers:**
- Cookie: Session admin đã đăng nhập

**Body:**
```json
{
  "noi_dung": "Cảm ơn bạn đã đánh giá. Chúng tôi rất vui khi bạn hài lòng!"
}
```

**Response:**
```json
{
  "success": true,
  "message": "Trả lời đánh giá thành công",
  "data": {
    "ma_tra_loi": 456,
    "noi_dung": "Cảm ơn bạn...",
    "ten_admin": "Admin",
    "ngay_tra_loi": "2024-12-05T10:30:00.000Z"
  }
}
```

#### Endpoint: `GET /api/reviews/:reviewId/replies`

Lấy danh sách trả lời của admin cho một đánh giá.

**Response:**
```json
{
  "success": true,
  "data": [
    {
      "ma_tra_loi": 1,
      "noi_dung": "Cảm ơn bạn đã đánh giá!",
      "ten_admin": "Admin",
      "ngay_tra_loi": "2024-12-05T10:30:00.000Z"
    }
  ]
}
```

### 3. Cập nhật API Lấy Reviews

API `GET /api/reviews/product/:productId` đã được cập nhật để bao gồm replies:

```json
{
  "success": true,
  "data": {
    "reviews": [
      {
        "ma_danh_gia": 1,
        "so_sao": 5,
        "binh_luan": "Món ăn rất ngon!",
        "ten_nguoi_dung": "Nguyễn Văn A",
        "replies": [
          {
            "ma_tra_loi": 1,
            "noi_dung": "Cảm ơn bạn!",
            "ten_admin": "Admin",
            "ngay_tra_loi": "2024-12-05T10:30:00.000Z"
          }
        ]
      }
    ]
  }
}
```

## Frontend - Trang Admin

### 1. Trang Quản lý Bình luận Tin tức

**File:** `frontend/admin/quan-ly-binh-luan.html`

**Thêm nút "Trả lời":**
```html
<button onclick="replyComment(${comment.ma_binh_luan})" 
        class="text-blue-600 hover:text-blue-800 p-2" 
        title="Trả lời">
    <i class="fas fa-reply"></i>
</button>
```

**Thêm modal trả lời:**
```html
<div id="reply-modal" class="hidden fixed inset-0 bg-black/50 z-50">
    <div class="bg-white rounded-2xl max-w-lg w-full p-6">
        <h3 class="text-xl font-bold mb-4">Trả lời bình luận</h3>
        <textarea id="reply-content" 
                  class="w-full border rounded-lg p-3" 
                  rows="4" 
                  placeholder="Nhập nội dung trả lời..."></textarea>
        <div class="flex gap-2 mt-4">
            <button onclick="submitReply()" 
                    class="bg-blue-600 text-white px-4 py-2 rounded-lg">
                Gửi trả lời
            </button>
            <button onclick="closeReplyModal()" 
                    class="bg-gray-200 px-4 py-2 rounded-lg">
                Hủy
            </button>
        </div>
    </div>
</div>
```

**JavaScript:**
```javascript
let currentCommentId = null;

function replyComment(commentId) {
    currentCommentId = commentId;
    document.getElementById('reply-modal').classList.remove('hidden');
    document.getElementById('reply-content').value = '';
}

async function submitReply() {
    const content = document.getElementById('reply-content').value.trim();
    
    if (!content) {
        alert('Vui lòng nhập nội dung trả lời');
        return;
    }

    try {
        const response = await fetch(`${API_URL}/news/comments/${currentCommentId}/reply`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            credentials: 'include',
            body: JSON.stringify({ noi_dung: content })
        });

        const data = await response.json();
        
        if (data.success) {
            alert('Trả lời thành công!');
            closeReplyModal();
            loadComments(); // Reload danh sách
        } else {
            alert('Lỗi: ' + data.message);
        }
    } catch (error) {
        console.error('Error:', error);
        alert('Có lỗi xảy ra');
    }
}

function closeReplyModal() {
    document.getElementById('reply-modal').classList.add('hidden');
    currentCommentId = null;
}
```

### 2. Trang Quản lý Đánh giá

**File:** `frontend/admin/reviews.html`

Tương tự như bình luận tin tức, thêm nút "Trả lời" và modal.

**JavaScript:**
```javascript
async function submitReviewReply() {
    const content = document.getElementById('reply-content').value.trim();
    
    if (!content) {
        alert('Vui lòng nhập nội dung trả lời');
        return;
    }

    try {
        const response = await fetch(`${API_URL}/reviews/${currentReviewId}/reply`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            credentials: 'include',
            body: JSON.stringify({ noi_dung: content })
        });

        const data = await response.json();
        
        if (data.success) {
            alert('Trả lời thành công!');
            closeReplyModal();
            loadReviews(); // Reload danh sách
        } else {
            alert('Lỗi: ' + data.message);
        }
    } catch (error) {
        console.error('Error:', error);
        alert('Có lỗi xảy ra');
    }
}
```

## Frontend - Trang Người dùng

### 1. Hiển thị Reply trong Chi tiết Tin tức

**File:** `frontend/tin-tuc-chi-tiet.html`

**HTML Template:**
```html
<!-- Bình luận gốc -->
<div class="comment-item">
    <div class="flex items-start space-x-3">
        <img src="${comment.anh_dai_dien}" class="w-10 h-10 rounded-full">
        <div class="flex-1">
            <p class="font-semibold">${comment.ten_nguoi_binh_luan}</p>
            <p class="text-gray-700">${comment.noi_dung}</p>
            <p class="text-xs text-gray-500">${formatDate(comment.ngay_binh_luan)}</p>
            
            <!-- Replies của admin -->
            ${comment.replies && comment.replies.length > 0 ? `
                <div class="ml-8 mt-3 space-y-2">
                    ${comment.replies.map(reply => `
                        <div class="bg-blue-50 rounded-lg p-3 border-l-4 border-blue-500">
                            <div class="flex items-center space-x-2 mb-1">
                                <i class="fas fa-shield-alt text-blue-600"></i>
                                <p class="font-semibold text-blue-800">${reply.ten_admin}</p>
                                <span class="text-xs bg-blue-200 text-blue-800 px-2 py-0.5 rounded">Admin</span>
                            </div>
                            <p class="text-gray-700">${reply.noi_dung}</p>
                            <p class="text-xs text-gray-500 mt-1">${formatDate(reply.ngay_binh_luan)}</p>
                        </div>
                    `).join('')}
                </div>
            ` : ''}
        </div>
    </div>
</div>
```

### 2. Hiển thị Reply trong Chi tiết Món ăn

**File:** `frontend/chitietmonan.html`

**HTML Template:**
```html
<!-- Đánh giá gốc -->
<div class="review-item border-b pb-4">
    <div class="flex items-start space-x-3">
        <img src="${review.anh_dai_dien}" class="w-12 h-12 rounded-full">
        <div class="flex-1">
            <div class="flex items-center justify-between">
                <p class="font-semibold">${review.ten_nguoi_dung}</p>
                <div class="flex text-yellow-400">
                    ${renderStars(review.so_sao)}
                </div>
            </div>
            <p class="text-gray-700 mt-2">${review.binh_luan}</p>
            <p class="text-xs text-gray-500 mt-1">${formatDate(review.ngay_danh_gia)}</p>
            
            <!-- Replies của admin -->
            ${review.replies && review.replies.length > 0 ? `
                <div class="ml-8 mt-3 space-y-2">
                    ${review.replies.map(reply => `
                        <div class="bg-green-50 rounded-lg p-3 border-l-4 border-green-500">
                            <div class="flex items-center space-x-2 mb-1">
                                <i class="fas fa-user-shield text-green-600"></i>
                                <p class="font-semibold text-green-800">${reply.ten_admin}</p>
                                <span class="text-xs bg-green-200 text-green-800 px-2 py-0.5 rounded">Quản trị viên</span>
                            </div>
                            <p class="text-gray-700">${reply.noi_dung}</p>
                            <p class="text-xs text-gray-500 mt-1">${formatDate(reply.ngay_tra_loi)}</p>
                        </div>
                    `).join('')}
                </div>
            ` : ''}
        </div>
    </div>
</div>
```

## Styling

### CSS cho Reply của Admin

```css
/* Reply container */
.admin-reply {
    margin-left: 2rem;
    margin-top: 0.75rem;
    background: linear-gradient(135deg, #f0f9ff 0%, #e0f2fe 100%);
    border-left: 4px solid #3b82f6;
    border-radius: 0.5rem;
    padding: 0.75rem;
}

/* Admin badge */
.admin-badge {
    display: inline-flex;
    align-items: center;
    gap: 0.25rem;
    background: #3b82f6;
    color: white;
    font-size: 0.75rem;
    padding: 0.125rem 0.5rem;
    border-radius: 9999px;
    font-weight: 600;
}

/* Admin icon */
.admin-icon {
    color: #3b82f6;
    font-size: 1rem;
}
```

## Testing

### 1. Test Backend API

```bash
# Test reply bình luận tin tức
curl -X POST http://localhost:3000/api/news/comments/1/reply \
  -H "Content-Type: application/json" \
  -H "Cookie: connect.sid=..." \
  -d '{"noi_dung":"Cảm ơn bạn đã góp ý!"}'

# Test reply đánh giá món ăn
curl -X POST http://localhost:3000/api/reviews/1/reply \
  -H "Content-Type: application/json" \
  -H "Cookie: connect.sid=..." \
  -d '{"noi_dung":"Cảm ơn bạn đã đánh giá!"}'

# Test lấy replies
curl http://localhost:3000/api/reviews/1/replies
```

### 2. Test Frontend Admin

1. Đăng nhập admin
2. Vào trang "Quản lý Bình luận"
3. Click nút "Trả lời" trên một bình luận
4. Nhập nội dung và gửi
5. Kiểm tra bình luận đã được trả lời

### 3. Test Frontend User

1. Vào trang chi tiết tin tức hoặc món ăn
2. Xem bình luận/đánh giá có reply
3. Kiểm tra hiển thị đúng:
   - Badge "Admin" hoặc "Quản trị viên"
   - Icon shield
   - Background màu xanh/xanh lá
   - Border bên trái
   - Thời gian trả lời

## Lợi ích

### 1. Tương tác tốt hơn
- Admin có thể trả lời trực tiếp câu hỏi của khách hàng
- Khách hàng cảm thấy được quan tâm
- Tăng độ tin cậy của nhà hàng

### 2. Quản lý dễ dàng
- Trả lời ngay từ trang admin
- Không cần chuyển qua trang người dùng
- Theo dõi các bình luận cần trả lời

### 3. Branding
- Hiển thị rõ ràng đây là câu trả lời chính thức
- Badge "Admin" tạo uy tín
- Màu sắc riêng biệt dễ nhận diện

## Kết luận

Tính năng admin trả lời bình luận đã được implement hoàn chỉnh với:
- ✅ Backend API cho cả tin tức và đánh giá
- ✅ Database schema với bảng mới
- ✅ UI admin với modal trả lời
- ✅ UI người dùng hiển thị reply đẹp mắt
- ✅ Badge và styling riêng cho admin
- ✅ Tích hợp với hệ thống hiện tại

Hệ thống giờ đã cho phép admin tương tác trực tiếp với khách hàng! 💬
