# 🌟 Glowy — ملاحظات التطوير

> سجل كل التعديلات اللي اتعملت على مشروع Glowy

---

## 📁 الملفات الجديدة

| الملف | المسار | الغرض |
|-------|--------|--------|
| `media_type_enum.dart` | `lib/presentation/resources/` | Enum لتحديد نوع المحتوى |
| `video_item_widget.dart` | `lib/presentation/home/widget/` | Widget عرض الفيديو |

---

## 🗂️ التعديلات بالترتيب

---

### 1️⃣ إصلاح `home_page.dart` — حذف الكود الميت

**المشكلة:**
كان فيه `BlocBuilder<GetCategoryContentCubit>` بدون `return`، فالكود اللي بعده مكنش بيتنفذ أبداً.

```dart
// ❌ قبل — dead code
return BlocBuilder<GetCategoryContentCubit, GetCategoryContentState>(
  builder: (context, categoryState) {
    final categorycontent = categoryState.data?.data.items ?? [];
    final categorytype = categorycontent.first.mediaType; // crash لو فاضية!
  }, // مفيش return!
);
// هذا الكود لن يُنفَّذ أبداً ↓
return BlocBuilder<ListAppCubit, ListAppState>(...);

// ✅ بعد — شيلنا الـ BlocBuilder الخاطئ وفضلنا بس الصح
return BlocBuilder<ListAppCubit, ListAppState>(...);
```

---

### 2️⃣ إنشاء `MediaType` Enum

**الملف:** `lib/presentation/resources/media_type_enum.dart`

```dart
enum MediaType {
  image,
  video,
  classification;

  static MediaType fromString(String? value) {
    switch (value) {
      case 'IMAGES':           return MediaType.image;
      case 'VIDEOS':           return MediaType.video;
      case 'IMAGE_CLASSIFICATION': return MediaType.classification;
      default:                 return MediaType.image;
    }
  }
}
```

**القيم الجاية من الـ API:**

| API Value | MediaType |
|-----------|-----------|
| `"IMAGES"` | `MediaType.image` |
| `"VIDEOS"` | `MediaType.video` |
| `"IMAGE_CLASSIFICATION"` | `MediaType.classification` |
| أي قيمة تانية | `MediaType.image` (default) |

---

### 3️⃣ ربط الـ Tabs بالـ MediaType في `home_page.dart`

لما المستخدم يضغط على category tab، يتحدد الـ `MediaType` بناءً على الـ index:

```dart
// في _HomePageState
MediaType selectedMediaType = MediaType.image; // default

// في onTap
onTap: () {
  setState(() {
    _selectedIndex = index;
    selectedMediaType = switch (index) {
      0 => MediaType.image,           // Home → صور
      1 => MediaType.video,           // Live → فيديوهات
      2 => MediaType.classification,  // Exclusive → تصنيفات
      _ => MediaType.image,
    };
  });
},
```

---

### 4️⃣ ربط الـ `categoryId` بالـ Tab المختار

**المشكلة:** كان `categoryId` دايماً بياخد أول category بغض النظر عن الـ tab.

```dart
// ❌ قبل — دايماً أول category
final categoryId = drawerCategories.first.id;

// ✅ بعد — category مختلفة لكل tab
final categoryId = drawerCategories.isNotEmpty &&
        _selectedIndex < drawerCategories.length
    ? drawerCategories[_selectedIndex].id   // ← الـ category الصح
    : drawerCategories.first.id;
```

---

### 5️⃣ تعديل `CategoryContent` — فلترة المحتوى حسب النوع

**الملف:** `lib/presentation/home/widget/category_content.dart`

**أضفنا:**

1. **Parameter جديد** `selectedMediaType`
2. **Filter** — بيفلتر العناصر حسب النوع
3. **ValueKey** — عشان الـ Cubit يتجدد لما الـ category تتغير

```dart
class CategoryContent extends StatefulWidget {
  final String appId;
  final String categoryId;
  final MediaType selectedMediaType; // ← جديد

  const CategoryContent({
    ...
    this.selectedMediaType = MediaType.image,
  });
}
```

**منطق الفلتر:**
```dart
// فلتر العناصر بناءً على النوع المختار
final categoryImages = allImages.where((item) {
  final itemType = MediaType.fromString(item.mediaType);
  return switch (widget.selectedMediaType) {
    MediaType.video => itemType == MediaType.video,
    MediaType.image ||
    MediaType.classification => itemType != MediaType.video,
  };
}).toList();
```

**Switch عرض المحتوى:**
```dart
switch (widget.selectedMediaType) {
  // صورة أو تصنيف → CachedNetworkImage
  MediaType.image || MediaType.classification => CachedNetworkImage(...),

  // فيديو → VideoItemWidget
  MediaType.video => VideoItemWidget(
    videoUrl: image.url,
    thumbUrl: image.thumbUrl,
  ),
}
```

---

### 6️⃣ إنشاء `VideoItemWidget`

**الملف:** `lib/presentation/home/widget/video_item_widget.dart`

**الميزات:**
- ✅ يعرض thumbnail من `thumbUrl` أو `videoUrl` كـ fallback
- ✅ زر ▶ Play للضغط عليه وتشغيل الفيديو
- ✅ Looping تلقائي بعد التشغيل
- ✅ زر ⏸ Pause في الكورنر
- ✅ Placeholder جميل لو التحميل فشل
- ✅ شريط "Video" في أسفل الكارت

**الـ Flow:**
```
قبل الضغط:
  Thumbnail (thumbUrl ?? videoUrl) + زر ▶ Play

بعد الضغط:
  VideoPlayer يشتغل + زر ⏸ Pause
```

---

### 7️⃣ إضافة `video_player` لـ pubspec.yaml

```yaml
dependencies:
  video_player: ^2.9.2  # ← جديد
```

---

## 🔄 الـ Flow الكامل

```
المستخدم يضغط Tab
       ↓
_selectedIndex = index
_selectedMediaType = switch(index) { 0→image, 1→video, 2→classification }
       ↓
categoryId = drawerCategories[_selectedIndex].id
       ↓
CategoryContent(
  appId: appId,
  categoryId: categoryId,        ← category جديدة
  selectedMediaType: ...,        ← نوع المحتوى
)
       ↓
BlocProvider (ValueKey بالـ categoryId) → Cubit جديد → fetch جديد
       ↓
فلترة العناصر حسب selectedMediaType
       ↓
switch(selectedMediaType)
  image/classification → CachedNetworkImage
  video               → VideoItemWidget
```

---

## 📦 Dependencies المضافة

| Package | Version | الغرض |
|---------|---------|--------|
| `video_player` | `^2.9.2` | تشغيل الفيديوهات |

---

## ⚠️ ملاحظات مهمة

> **الـ API Values:**
> تأكد إن الـ API بيرجع القيم دي بالظبط:
> - `"IMAGES"` للصور
> - `"VIDEOS"` للفيديوهات  
> - `"IMAGE_CLASSIFICATION"` للتصنيفات

> **الـ ValueKey:**
> الـ `BlocProvider` في `CategoryContent` بيستخدم `ValueKey('${appId}_${categoryId}')` عشان يعمل Cubit جديد لكل category — لو شيلته الـ fetch مش هيتجدد.

> **Video Thumbnails:**
> لو `thumbUrl == null` للفيديو، بيتجرب تحميل `url` نفسه كصورة. لو فشل بييجي placeholder بأيقونة كاميرا.
