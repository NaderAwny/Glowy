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
