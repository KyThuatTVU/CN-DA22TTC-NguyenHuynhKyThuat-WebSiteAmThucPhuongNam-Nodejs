# ==================== CÀI ĐẶT THƯ VIỆN (chạy trên Google Colab) ====================
# !pip install deepface tensorflow opencv-python matplotlib xlsxwriter -q

import cv2
import numpy as np
import matplotlib.pyplot as plt
from deepface import DeepFace
from google.colab import files
from IPython.display import display, HTML, clear_output
import pandas as pd

# ==================== UPLOAD ẢNH ====================
print("📷 Tải ảnh khuôn mặt lên:")
uploaded = files.upload()
img_path = list(uploaded.keys())[0]
print(f"✅ Đã tải: {img_path}")

# ==================== HIỂN THỊ ẢNH GỐC ====================
img = cv2.imread(img_path)
img_rgb = cv2.cvtColor(img, cv2.COLOR_BGR2RGB)

plt.figure(figsize=(8, 8))
plt.imshow(img_rgb)
plt.title("Ảnh gốc", fontsize=14)
plt.axis('off')
plt.show()

# ==================== KIỂM TRA KHUÔN MẶT NGƯỜI ====================
print("\n🔍 Đang kiểm tra khuôn mặt người trong ảnh...")

def detect_human_face(img_path):
    """
    Kiểm tra xem ảnh có chứa khuôn mặt người hay không.
    Lưu ý: DeepFace chỉ được huấn luyện cho khuôn mặt NGƯỜI,
    không phải động vật hay đối tượng khác.
    """
    try:
        face_objs = DeepFace.extract_faces(
            img_path=img_path,
            detector_backend='opencv',
            enforce_detection=True
        )
        
        if len(face_objs) == 0:
            return False, None
        
        return True, face_objs[0]
        
    except Exception as e:
        return False, str(e)

has_face, face_info = detect_human_face(img_path)

if not has_face:
    print("\n" + "=" * 60)
    print("❌ KHÔNG PHÁT HIỆN KHUÔN MẶT NGƯỜI!")
    print("=" * 60)
    print("""
⚠️ Ảnh bạn tải lên không chứa khuôn mặt NGƯỜI.

📌 Lưu ý quan trọng:
   • DeepFace, VGG-Face, ArcFace... chỉ được huấn luyện cho khuôn mặt NGƯỜI
   • Ảnh động vật (mèo, chó...) hoặc đồ vật sẽ cho kết quả SAI
   • Vui lòng tải lên ảnh khuôn mặt người rõ ràng
    """)
    
    plt.figure(figsize=(8, 8))
    plt.imshow(img_rgb)
    plt.title("❌ Không phát hiện khuôn mặt người!", fontsize=14, color='red')
    plt.axis('off')
    plt.show()
    
    raise ValueError("Ảnh không chứa khuôn mặt người!")

print("✅ Đã phát hiện khuôn mặt người trong ảnh!")


# ==============================================================================
# PHẦN 1: TRÍCH CHỌN ĐẶC TRƯNG DEEP LEARNING (FEATURE EMBEDDING)
# ==============================================================================
# Mục đích: Tạo vector đặc trưng để NHẬN DẠNG DANH TÍNH khuôn mặt
# Ứng dụng: Face verification, face identification, face matching
# ==============================================================================

print("\n" + "=" * 70)
print("🧠 PHẦN 1: TRÍCH CHỌN ĐẶC TRƯNG DEEP LEARNING (Feature Embedding)")
print("=" * 70)
print("""
📌 Mục đích: Tạo vector đặc trưng để NHẬN DẠNG DANH TÍNH
📌 Sử dụng: Model CNN Pretrained (đã được huấn luyện sẵn)
📌 Ứng dụng: Face verification, face identification
""")

models = ["VGG-Face", "Facenet", "Facenet512", "OpenFace", "ArcFace"]
results = {}

for model in models:
    try:
        print(f"  → Đang trích xuất với {model}...")
        embedding = DeepFace.represent(
            img_path=img_path,
            model_name=model,
            enforce_detection=True,
            detector_backend='opencv'
        )
        results[model] = {
            'embedding': embedding[0]['embedding'],
            'dimension': len(embedding[0]['embedding']),
            'face_region': embedding[0].get('facial_area', {})
        }
        print(f"    ✅ {model}: Vector {len(embedding[0]['embedding'])} chiều")
    except Exception as e:
        print(f"    ❌ {model}: Lỗi - {str(e)[:50]}")

if not results:
    raise ValueError("Không thể trích chọn đặc trưng!")

# Bảng kết quả Feature Embedding
print("\n📊 KẾT QUẢ FEATURE EMBEDDING:")
model_comparison = []
for model, data in results.items():
    model_comparison.append({
        'Model': model,
        'Số chiều vector': data['dimension'],
        'Loại': 'CNN Pretrained'
    })

df_models = pd.DataFrame(model_comparison)
display(df_models)

# Thống kê vector
print("\n📈 THỐNG KÊ VECTOR ĐẶC TRƯNG:")
for model, data in results.items():
    emb = data['embedding']
    print(f"\n   {model}:")
    print(f"      Số chiều: {len(emb)}")
    print(f"      Min: {min(emb):.4f}, Max: {max(emb):.4f}")
    print(f"      Mean: {np.mean(emb):.4f}, Std: {np.std(emb):.4f}")


# ==============================================================================
# PHẦN 2: THUỘC TÍNH NGỮ NGHĨA (SEMANTIC ATTRIBUTES) - TÁCH RIÊNG
# ==============================================================================
# ⚠️ LƯU Ý QUAN TRỌNG:
# - Đây KHÔNG PHẢI đặc trưng nhận dạng danh tính
# - Chỉ mang tính MÔ TẢ, PHÂN TÍCH khuôn mặt
# - KHÔNG dùng để so khớp danh tính (face matching)
# ==============================================================================

print("\n" + "=" * 70)
print("👤 PHẦN 2: THUỘC TÍNH NGỮ NGHĨA (Semantic Attributes)")
print("=" * 70)
print("""
⚠️ LƯU Ý QUAN TRỌNG:
   • Đây KHÔNG PHẢI đặc trưng nhận dạng danh tính
   • Chỉ mang tính MÔ TẢ, PHÂN TÍCH khuôn mặt
   • KHÔNG dùng để so khớp danh tính (face matching)
   • Age/Gender/Emotion/Race ≠ Feature Embedding
""")

try:
    analysis = DeepFace.analyze(
        img_path=img_path,
        actions=['age', 'gender', 'race', 'emotion'],
        enforce_detection=True,
        detector_backend='opencv'
    )
    
    if isinstance(analysis, list):
        analysis = analysis[0]
    
    semantic_attributes = {
        'Tuổi ước tính': analysis.get('age', 'N/A'),
        'Giới tính': analysis.get('dominant_gender', 'N/A'),
        'Chủng tộc chính': analysis.get('dominant_race', 'N/A'),
        'Cảm xúc chính': analysis.get('dominant_emotion', 'N/A')
    }
    
    emotion_scores = analysis.get('emotion', {})
    race_scores = analysis.get('race', {})
    
    print("\n📋 Kết quả phân tích (chỉ mang tính mô tả):")
    for key, value in semantic_attributes.items():
        print(f"   • {key}: {value}")
    
except Exception as e:
    print(f"⚠️ Không phân tích được: {e}")
    semantic_attributes = {}
    emotion_scores = {}
    race_scores = {}


# ==============================================================================
# VISUALIZATION - TÁCH RIÊNG 2 PHẦN
# ==============================================================================

# --- BIỂU ĐỒ 1: FEATURE EMBEDDING (Nhận dạng danh tính) ---
fig1, axes1 = plt.subplots(1, 2, figsize=(14, 5))

# Ảnh với face detection
ax1 = axes1[0]
img_display = img_rgb.copy()
if results:
    first_model = list(results.keys())[0]
    face_region = results[first_model].get('face_region', {})
    if face_region:
        fx = face_region.get('x', 0)
        fy = face_region.get('y', 0)
        fw = face_region.get('w', 0)
        fh = face_region.get('h', 0)
        cv2.rectangle(img_display, (fx, fy), (fx+fw, fy+fh), (0, 255, 0), 3)
ax1.imshow(img_display)
ax1.set_title("Phát hiện khuôn mặt", fontsize=12)
ax1.axis('off')

# So sánh số chiều vector
ax2 = axes1[1]
if results:
    model_names = list(results.keys())
    dimensions = [results[m]['dimension'] for m in model_names]
    colors_bar = ['#3498db', '#e74c3c', '#2ecc71', '#f39c12', '#9b59b6']
    bars = ax2.bar(model_names, dimensions, color=colors_bar[:len(model_names)])
    ax2.set_title("Số chiều Feature Embedding (dùng cho nhận dạng)", fontsize=12)
    ax2.set_ylabel("Số chiều")
    for bar, dim in zip(bars, dimensions):
        ax2.text(bar.get_x() + bar.get_width()/2, bar.get_height() + 5, 
                 str(dim), ha='center', fontsize=10)
    plt.sca(ax2)
    plt.xticks(rotation=45)

plt.suptitle("PHẦN 1: FEATURE EMBEDDING - Đặc trưng nhận dạng danh tính\n(Sử dụng Model Pretrained)", 
             fontsize=13, fontweight='bold')
plt.tight_layout()
plt.savefig('feature_embedding_result.png', dpi=150, bbox_inches='tight')
plt.show()

# --- BIỂU ĐỒ 2: SEMANTIC ATTRIBUTES (Chỉ mô tả, không nhận dạng) ---
if emotion_scores or race_scores:
    fig2, axes2 = plt.subplots(1, 2, figsize=(14, 5))
    
    # Biểu đồ cảm xúc
    ax3 = axes2[0]
    if emotion_scores:
        emotions = list(emotion_scores.keys())
        scores = list(emotion_scores.values())
        colors_emo = plt.cm.RdYlGn(np.linspace(0.2, 0.8, len(emotions)))
        ax3.barh(emotions, scores, color=colors_emo)
        ax3.set_title("Phân tích cảm xúc", fontsize=12)
        ax3.set_xlim(0, 100)
        ax3.set_xlabel("Phần trăm (%)")
    
    # Biểu đồ chủng tộc
    ax4 = axes2[1]
    if race_scores:
        races = list(race_scores.keys())
        scores_race = list(race_scores.values())
        ax4.pie(scores_race, labels=races, autopct='%1.1f%%', startangle=90)
        ax4.set_title("Phân tích chủng tộc", fontsize=12)
    
    plt.suptitle("PHẦN 2: SEMANTIC ATTRIBUTES - Chỉ mô tả, KHÔNG dùng nhận dạng\n⚠️ Age/Gender/Emotion ≠ Feature nhận dạng", 
                 fontsize=13, fontweight='bold', color='red')
    plt.tight_layout()
    plt.savefig('semantic_attributes_result.png', dpi=150, bbox_inches='tight')
    plt.show()


# ==============================================================================
# XUẤT KẾT QUẢ
# ==============================================================================
print("\n" + "=" * 70)
print("💾 XUẤT KẾT QUẢ")
print("=" * 70)

save = input("\n💾 Lưu kết quả vào Excel? (y/n): ").strip().lower()

if save == 'y':
    with pd.ExcelWriter('face_features.xlsx', engine='xlsxwriter') as writer:
        # Sheet 1: Feature Embedding (nhận dạng)
        df_models.to_excel(writer, sheet_name='Feature Embedding', index=False)
        
        # Sheet 2: Vector Facenet
        if 'Facenet' in results:
            df_facenet = pd.DataFrame({
                'Chiều': range(len(results['Facenet']['embedding'])),
                'Giá trị': results['Facenet']['embedding']
            })
            df_facenet.to_excel(writer, sheet_name='Vector Facenet', index=False)
        
        # Sheet 3: Semantic Attributes (tách riêng, ghi chú rõ)
        if semantic_attributes:
            df_semantic = pd.DataFrame([semantic_attributes])
            df_semantic.to_excel(writer, sheet_name='Semantic (không nhận dạng)', index=False)
    
    print("✅ Đã lưu: face_features.xlsx")
    files.download('face_features.xlsx')

# Download ảnh
print("\n📥 Tải ảnh kết quả:")
files.download('feature_embedding_result.png')
if emotion_scores or race_scores:
    files.download('semantic_attributes_result.png')

# ==============================================================================
# TÓM TẮT
# ==============================================================================
print("\n" + "=" * 70)
print("📚 TÓM TẮT QUAN TRỌNG")
print("=" * 70)
print("""
┌─────────────────────────────────────────────────────────────────────┐
│ PHẦN 1: FEATURE EMBEDDING (Đặc trưng nhận dạng danh tính)           │
├─────────────────────────────────────────────────────────────────────┤
│ • Sử dụng model PRETRAINED (VGG-Face, Facenet, ArcFace...)          │
│ • Tạo ra vector số thực (128-512 chiều)                             │
│ • DÙNG cho: Face verification, face identification, face matching  │
│ • Đây là HIGH-LEVEL FEATURES                                        │
└─────────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────────┐
│ PHẦN 2: SEMANTIC ATTRIBUTES (Thuộc tính ngữ nghĩa)                  │
├─────────────────────────────────────────────────────────────────────┤
│ • Age, Gender, Emotion, Race                                        │
│ • ⚠️ KHÔNG PHẢI đặc trưng nhận dạng danh tính                       │
│ • Chỉ mang tính MÔ TẢ, PHÂN TÍCH                                    │
│ • KHÔNG dùng để so khớp danh tính                                   │
└─────────────────────────────────────────────────────────────────────┘

⚠️ LƯU Ý KHI LÀM BÁO CÁO:
   • Feature Embedding → dùng cho nhận dạng IDENTITY
   • Semantic Attributes → chỉ MÔ TẢ, không nhận dạng
   • Hai phần này TÁCH RIÊNG, không đặt ngang hàng
   • Model DeepFace chỉ huấn luyện cho khuôn mặt NGƯỜI
""")

print("\n✅ HOÀN TẤT!")
