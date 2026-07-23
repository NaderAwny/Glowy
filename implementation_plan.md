# 📥 Download Feature — Glowy App

> **المبدأ:** الـ User هو اللي بيكتب الكود، الـ Plan دي مرجعه خطوة بخطوة.

---

## 🗂️ الملفات اللي هنشتغل عليها

```
المرحلة الأولى (بدون Isolate)
├── pubspec.yaml                                        [MODIFY]
├── android/app/src/main/AndroidManifest.xml            [MODIFY]
├── ios/Runner/Info.plist                               [MODIFY]
│
├── domain/
│   ├── usecase/download_usecase.dart                   [NEW]
│   └── repository/download_repository.dart             [NEW]
│
├── data/
│   ├── repository_impl/download_repository_impl.dart   [NEW]
│   └── data_source/download_data_source.dart           [NEW]
│
└── presentation/
    ├── wallpaper_detail/
    │   ├── download_cubit/
    │   │   ├── download_cubit.dart                     [NEW]
    │   │   └── download_state.dart                     [NEW]
    │   └── wallpaper_detail.dart                       [MODIFY]
    └── home/widget/
        └── category_content_deatils.dart               [MODIFY]
```

---

## 📦 الخطوة 0 — pubspec.yaml

أضف الباكدجات دي تحت `dependencies:`:

```yaml
gal: ^2.3.0
permission_handler: ^11.3.1
```

بعدين شغّل:
```bash
flutter pub get
```

---

## 📱 الخطوة 1 — Permissions

### Android — `android/app/src/main/AndroidManifest.xml`

أضف قبل `<application`:

```xml
<!-- Storage - للـ Android 12 وأقل فقط -->
<uses-permission
    android:name="android.permission.WRITE_EXTERNAL_STORAGE"
    android:maxSdkVersion="32" />
<uses-permission
    android:name="android.permission.READ_EXTERNAL_STORAGE"
    android:maxSdkVersion="32" />
```

### iOS — `ios/Runner/Info.plist`

أضف داخل `<dict>`:

```xml
<key>NSPhotoLibraryAddUsageDescription</key>
<string>Glowy needs access to save wallpapers to your gallery</string>
```

---

## 🏛️ الخطوة 2 — Domain Layer

### [NEW] `lib/domain/repository/download_repository.dart`

```dart
import 'package:dartz/dartz.dart';
import 'package:glowy/data/network/failure.dart';

abstract class DownloadRepository {
  Future<Either<Failure, bool>> downloadFile(String url, String fileName);
}
```

---

### [NEW] `lib/domain/usecase/download_usecase.dart`

```dart
import 'package:dartz/dartz.dart';
import 'package:glowy/data/network/failure.dart';
import 'package:glowy/domain/repository/download_repository.dart';
import 'package:glowy/domain/usecase/base_usecase.dart';
import 'package:injectable/injectable.dart';

// Input class — هنبعت الـ url والاسم
class DownloadInput {
  final String url;
  final String fileName;
  DownloadInput({required this.url, required this.fileName});
}

@injectable
class DownloadUsecase implements BaseUsecase<DownloadInput, bool> {
  final DownloadRepository _downloadRepository;
  DownloadUsecase(this._downloadRepository);

  @override
  Future<Either<Failure, bool>> execute(DownloadInput input) async {
    return await _downloadRepository.downloadFile(input.url, input.fileName);
  }
}
```

---

## 🗄️ الخطوة 3 — Data Layer

### [NEW] `lib/data/data_source/download_data_source.dart`

```dart
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:gal/gal.dart';
import 'package:injectable/injectable.dart';

abstract class DownloadRemoteDataSource {
  Future<bool> downloadFile(String url, String fileName);
}

@LazySingleton(as: DownloadRemoteDataSource)
class DownloadRemoteDataSourceImpl implements DownloadRemoteDataSource {
  final Dio _dio;
  DownloadRemoteDataSourceImpl(this._dio);

  @override
  Future<bool> downloadFile(String url, String fileName) async {
    // 1. طلب Permission
    final hasAccess = await Gal.requestAccess();
    if (!hasAccess) {
      throw Exception('Permission denied by user');
    }

    // 2. Download الـ bytes عن طريق Dio
    final response = await _dio.get<List<int>>(
      url,
      options: Options(responseType: ResponseType.bytes),
    );

    if (response.data == null) {
      throw Exception('Empty response data');
    }

    final bytes = Uint8List.fromList(response.data!);

    // 3. حفظ في الـ Gallery
    // هنحدد نوع الملف بناءً على الاسم
    if (fileName.endsWith('.mp4') || fileName.endsWith('.mov')) {
      await Gal.putVideoBytes(bytes, album: 'Glowy', name: fileName);
    } else {
      await Gal.putImageBytes(bytes, album: 'Glowy', name: fileName);
    }

    return true;
  }
}
```

---

### [NEW] `lib/data/repository_impl/download_repository_impl.dart`

```dart
import 'package:dartz/dartz.dart';
import 'package:glowy/data/data_source/download_data_source.dart';
import 'package:glowy/data/network/error_handler.dart';
import 'package:glowy/data/network/failure.dart';
import 'package:glowy/domain/repository/download_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: DownloadRepository)
class DownloadRepositoryImpl implements DownloadRepository {
  final DownloadRemoteDataSource _dataSource;
  DownloadRepositoryImpl(this._dataSource);

  @override
  Future<Either<Failure, bool>> downloadFile(
    String url,
    String fileName,
  ) async {
    try {
      final result = await _dataSource.downloadFile(url, fileName);
      return Right(result);
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }
}
```

---

## 🎨 الخطوة 4 — Presentation Layer

### [NEW] `lib/presentation/wallpaper_detail/download_cubit/download_state.dart`

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'download_state.freezed.dart';

// حالات الـ download
enum DownloadStatus { initial, loading, success, failure }

@freezed
abstract class DownloadState with _$DownloadState {
  const factory DownloadState({
    @Default(DownloadStatus.initial) DownloadStatus status,
    String? errorMessage,
  }) = _DownloadState;
}
```

> ⚠️ بعد ما تكتب الملف ده، شغّل:
> ```bash
> dart run build_runner build --delete-conflicting-outputs
> ```

---

### [NEW] `lib/presentation/wallpaper_detail/download_cubit/download_cubit.dart`

```dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glowy/domain/usecase/download_usecase.dart';
import 'package:glowy/presentation/wallpaper_detail/download_cubit/download_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class DownloadCubit extends Cubit<DownloadState> {
  final DownloadUsecase _downloadUsecase;
  DownloadCubit(this._downloadUsecase) : super(const DownloadState());

  Future<void> download({required String url, required String fileName}) async {
    // امنع الضغط المتكرر
    if (state.status == DownloadStatus.loading) return;

    emit(state.copyWith(status: DownloadStatus.loading));

    final result = await _downloadUsecase.execute(
      DownloadInput(url: url, fileName: fileName),
    );

    result.fold(
      (failure) {
        if (isClosed) return;
        emit(state.copyWith(
          status: DownloadStatus.failure,
          errorMessage: failure.message,
        ));
      },
      (success) {
        if (isClosed) return;
        emit(state.copyWith(status: DownloadStatus.success));
      },
    );
  }

  void reset() => emit(const DownloadState());
}
```

---

### [MODIFY] `lib/presentation/home/widget/category_content_deatils.dart`

استبدل الكود كله بالكود ده — بيضيف زرار الـ Download:

```dart
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glowy/app/di.dart';
import 'package:glowy/presentation/home/widget/video_item_widget.dart';
import 'package:glowy/presentation/resources/media_type_enum.dart';
import 'package:glowy/presentation/wallpaper_detail/download_cubit/download_cubit.dart';
import 'package:glowy/presentation/wallpaper_detail/download_cubit/download_state.dart';

class CategoryContentDetails extends StatelessWidget {
  final String imageUrl;
  final MediaType mediaType;

  const CategoryContentDetails({
    super.key,
    required this.imageUrl,
    required this.mediaType,
  });

  // استخرج اسم الملف من الـ URL
  String _getFileName() {
    final uri = Uri.parse(imageUrl);
    final segments = uri.pathSegments;
    if (segments.isNotEmpty) return segments.last;
    // اسم افتراضي لو مفيش
    return mediaType == MediaType.video
        ? 'glowy_video.mp4'
        : 'glowy_image.jpg';
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<DownloadCubit>(),
      child: BlocConsumer<DownloadCubit, DownloadState>(
        listener: (context, state) {
          if (state.status == DownloadStatus.success) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('✅ Downloaded to Gallery successfully!'),
                backgroundColor: Colors.green,
              ),
            );
            context.read<DownloadCubit>().reset();
          } else if (state.status == DownloadStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('❌ ${state.errorMessage ?? 'Download failed'}'),
                backgroundColor: Colors.red,
              ),
            );
            context.read<DownloadCubit>().reset();
          }
        },
        builder: (context, state) {
          final isLoading = state.status == DownloadStatus.loading;

          return Scaffold(
            appBar: AppBar(
              title: const Text('Category Details'),
              centerTitle: true,
              actions: [
                // ── زرار الـ Download ──
                IconButton(
                  icon: isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.download_rounded),
                  onPressed: isLoading
                      ? null
                      : () {
                          context.read<DownloadCubit>().download(
                                url: imageUrl,
                                fileName: _getFileName(),
                              );
                        },
                ),
              ],
            ),
            body: Center(
              child: switch (mediaType) {
                MediaType.video => VideoItemWidget(videoUrl: imageUrl),
                MediaType.image ||
                MediaType.classification =>
                  CachedNetworkImage(imageUrl: imageUrl),
                _ => const SizedBox.shrink(),
              },
            ),
          );
        },
      ),
    );
  }
}
```

---

## ♻️ الخطوة 5 — Regenerate DI

بعد ما تخلص كل الملفات، شغّل:

```bash
dart run build_runner build --delete-conflicting-outputs
```

ده هيـ generate ملف `di.config.dart` تلقائياً ويضيف الـ `DownloadCubit` و `DownloadUsecase` للـ DI.

---

## ✅ ترتيب الشغل (Step by Step)

| # | الملف | الحالة |
|---|-------|--------|
| 1 | `pubspec.yaml` — أضف `gal` + `permission_handler` | ⬜ |
| 2 | `AndroidManifest.xml` — أضف الـ permissions | ⬜ |
| 3 | `ios/Info.plist` — أضف الـ permission description | ⬜ |
| 4 | `domain/repository/download_repository.dart` | ⬜ |
| 5 | `domain/usecase/download_usecase.dart` | ⬜ |
| 6 | `data/data_source/download_data_source.dart` | ⬜ |
| 7 | `data/repository_impl/download_repository_impl.dart` | ⬜ |
| 8 | `presentation/.../download_state.dart` | ⬜ |
| 9 | `presentation/.../download_cubit.dart` | ⬜ |
| 10 | `category_content_deatils.dart` — أضف زر الـ download | ⬜ |
| 11 | `dart run build_runner build` | ⬜ |
| 12 | شغّل الـ app واختبر | ⬜ |

---

## 🚀 المرحلة الثانية — Isolate.spawn (بعد ما المرحلة الأولى تشتغل)

> هنضيف الـ Isolate بعد ما نتأكد إن الـ download بيشتغل صح.
>
> الفكرة:
> - الـ `DownloadRemoteDataSourceImpl` هتتغير فقط
> - الـ Cubit والـ Usecase هيفضلوا زي ما هم بالظبط
> - هنعزل كود الـ Dio (download bytes) في isolate منفصل

```
Main Isolate                    Spawned Isolate
     │                               │
     │──── Isolate.spawn ────────────▶│
     │      (url, sendPort)           │
     │                               │ Dio.get → bytes
     │                               │ Gal.putImageBytes
     │◀──── sendPort.send(true) ─────│
     │
  emit(success)
```

سيتم توضيح الكود بالتفصيل في المرحلة الثانية.

---

> 💡 **ملاحظة مهمة:** لو `gal` مش بتدعم `putVideoBytes`، استخدم `putVideo` مع `path_provider` لتخزين الملف مؤقتاً أولاً. هنتعامل مع ده لو حصل.
