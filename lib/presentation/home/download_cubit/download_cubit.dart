import 'dart:io';
import 'dart:isolate';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gal/gal.dart';
import 'package:glowy/domain/usecase/download_uecase.dart';
import 'package:glowy/presentation/home/download_cubit/download_state.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';

// ─── خارج الـ class — لازم top-level ───
class _IsolateMsg {
  final String url;
  final String tempPath;
  final SendPort sendPort;
  _IsolateMsg(this.url, this.tempPath, this.sendPort);
}

Future<void> _downloadEntryPoint(_IsolateMsg msg) async {
  try {
    final dio = Dio(
      BaseOptions(
        receiveTimeout: const Duration(minutes: 5),
        connectTimeout: const Duration(seconds: 30),
      ),
    );
    final res = await dio.get<List<int>>(
      msg.url,
      options: Options(responseType: ResponseType.bytes),
    );
    await File(msg.tempPath).writeAsBytes(res.data!);
    msg.sendPort.send({'ok': true, 'path': msg.tempPath});
  } catch (e) {
    msg.sendPort.send({'ok': false, 'error': e.toString()});
  }
}
// ─────────────────────────────────────────────────

@lazySingleton
class DownloadCubit extends Cubit<DownloadState> {
  final DownLoadUsecase downloadUsecase;
  Isolate? _isolate;
  ReceivePort? _port;

  DownloadCubit(this.downloadUsecase) : super(const DownloadState());

  Future<void> downloadWithIsolate({
    required String url,
    required String fileName,
  }) async {
    if (state.status == DownloadStatus.loading) return;
    emit(state.copyWith(status: DownloadStatus.loading));

    // ⬇️ ده لازم هنا — plugins مش بتشتغل في isolate
    final hasAccess = await Gal.requestAccess(toAlbum: true);
    if (!hasAccess) {
      emit(
        state.copyWith(
          status: DownloadStatus.failure,
          errorMessage: 'Permission denied',
        ),
      );
      return;
    }

    final tempDir = await getTemporaryDirectory();
    final tempPath = '${tempDir.path}/$fileName';

    _port = ReceivePort();

    _isolate = await Isolate.spawn(
      _downloadEntryPoint,
      _IsolateMsg(url, tempPath, _port!.sendPort),
    );

    _port!.listen((msg) async {
      if (isClosed) return;
      final map = msg as Map<String, dynamic>;

      if (map['ok'] == true) {
        final path = map['path'] as String;
        final file = File(path);
        final isVideo = fileName.endsWith('.mp4') || fileName.endsWith('.mov');

        if (isVideo) {
          await Gal.putVideo(path, album: 'Glowy');
        } else {
          // putImageBytes بيقرأ الـ bytes الفعلية — مش محتاج extension
          final bytes = await file.readAsBytes();
          await Gal.putImageBytes(bytes, album: 'Glowy', name: fileName);
        }

        await file.delete();
        if (!isClosed) emit(state.copyWith(status: DownloadStatus.success));
      } else {
        if (!isClosed) {
          emit(
            state.copyWith(
              status: DownloadStatus.failure,
              errorMessage: map['error'] as String?,
            ),
          );
        }
      }
      _cleanUp();
    });
  }

  void _cleanUp() {
    _isolate?.kill(priority: Isolate.immediate);
    _isolate = null;
    _port?.close();
    _port = null;
  }

  void reset() => emit(const DownloadState());

  @override
  Future<void> close() {
    _cleanUp();
    return super.close();
  }
}
