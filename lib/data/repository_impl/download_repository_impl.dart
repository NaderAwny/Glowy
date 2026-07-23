import 'package:dartz/dartz.dart';
import 'package:glowy/data/data_source/download_data_source.dart';
import 'package:glowy/data/network/error_handler.dart';
import 'package:glowy/data/network/failure.dart';
import 'package:glowy/domain/repository/download_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: DownloadRepository)
class DownloadRepositoryImpl implements DownloadRepository {
  final DownloadDataSource _dataSource;
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
