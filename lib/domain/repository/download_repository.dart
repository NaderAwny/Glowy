import 'package:dartz/dartz.dart';
import 'package:glowy/data/network/failure.dart';

abstract class DownloadRepository {
  Future<Either<Failure, bool>> downloadFile(String url, String fileName);
}
