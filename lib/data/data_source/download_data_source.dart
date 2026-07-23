import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:gal/gal.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';

abstract class DownloadDataSource {
  Future<bool> downloadFile(String url, String fileName);
}

@LazySingleton(as: DownloadDataSource)
class DownloadRemoteDataSourceImpl implements DownloadDataSource {
  // لا نحتاج الـ _dio المحقون هنا — الـ download URLs هي URLs كاملة خارجية
  DownloadRemoteDataSourceImpl();

  @override
  Future<bool> downloadFile(String url, String fileName) async {
    // 1. طلب Permission
    final hasAccess = await Gal.requestAccess(toAlbum: true);
    if (!hasAccess) {
      throw Exception('Permission denied by user');
    }

    // 2. Dio جديد بدون baseUrl + timeout كافي للملفات الكبيرة
    final downloadDio = Dio(
      BaseOptions(
        receiveTimeout: const Duration(minutes: 5),
        sendTimeout: const Duration(minutes: 2),
        connectTimeout: const Duration(seconds: 30),
      ),
    );

    final response = await downloadDio.get<List<int>>(
      url,
      options: Options(responseType: ResponseType.bytes),
    );

    if (response.data == null) {
      throw Exception('Empty response data');
    }

    final isVideo = fileName.endsWith('.mp4') || fileName.endsWith('.mov');
    if (isVideo) {
      // ── فيديو: حفظ في temp file أولاً ثم نبعت الـ path لـ Gal ──
      final tempDir = await getTemporaryDirectory();
      final tempFile = File('${tempDir.path}/$fileName');
      await tempFile.writeAsBytes(response.data!);
      await Gal.putVideo(tempFile.path, album: 'Glowy');
      await tempFile.delete();
    } else {
      // ── صورة: bytes مباشرة ✅ ──
      final bytes = Uint8List.fromList(response.data!);
      await Gal.putImageBytes(bytes, album: 'Glowy', name: fileName);
    }

    return true;
  }
}
