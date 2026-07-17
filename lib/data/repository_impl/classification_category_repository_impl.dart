import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:glowy/data/data_source/classification_category_data_source.dart';
import 'package:glowy/data/mapper/classification_category_mapper.dart';
import 'package:glowy/data/network/error_handler.dart';
import 'package:glowy/data/network/failure.dart';
import 'package:glowy/data/network/network_info.dart';
import 'package:glowy/domain/model/classification_category_model.dart';
import 'package:glowy/domain/repository/classification_category_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: GetClassificationCategoryRepository)
class GetClassificationCategoryRepositoryImpl
    implements GetClassificationCategoryRepository {
  final GetClassificationCategoryRemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  GetClassificationCategoryRepositoryImpl(
    this._remoteDataSource,
    this._networkInfo,
  );

  @override
  Future<Either<Failure, ClassificationCategoryMainModel>>
  getClassificationCategoryData(String appId, String categoryId) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.getClassificationCategoryData(
          appId,
          categoryId,
        );
        debugPrint('>>> [HOME RAW] status: ${response.success}');
        debugPrint('>>> [HOME RAW] message: ${response.message}');
        debugPrint('>>> [HOME RAW] data: ${response.data}');
        debugPrint(
          '>>> [HOME RAW] classifications: ${response.data?.classifications}',
        );

        if (response.success == true) {
          return Right(response.toDomain());
        } else {
          return Left(
            Failure(
              ApiInternalStatus.FAILURE,
              response.message ?? ResponseMessage.DEAFULT,
            ),
          );
        }
      } catch (error) {
        // print('>>> [HOME ERROR] $error');
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }
}
