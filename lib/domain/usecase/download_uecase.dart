import 'package:dartz/dartz.dart';
import 'package:glowy/data/network/failure.dart';
import 'package:glowy/domain/repository/download_repository.dart';
import 'package:glowy/domain/usecase/base_usecase.dart';
import 'package:injectable/injectable.dart';

@injectable
class DownLoadUsecase implements BaseUsecase<DownLoadInput, bool> {
  final DownloadRepository _downloadRepository;
  DownLoadUsecase(this._downloadRepository);
  @override
  Future<Either<Failure, bool>> execute(DownLoadInput input) async {
    return await _downloadRepository.downloadFile(input.url, input.fileName);
  }
}

class DownLoadInput {
  final String url;
  final String fileName;
  DownLoadInput({required this.url, required this.fileName});
}
