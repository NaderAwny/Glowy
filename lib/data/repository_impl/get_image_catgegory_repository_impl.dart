import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:glowy/data/data_source/get_image_category_data_source.dart';
import 'package:glowy/data/mapper/get_image_category_mapper.dart';
import 'package:glowy/data/network/error_handler.dart';
import 'package:glowy/data/network/failure.dart';
import 'package:glowy/data/network/network_info.dart';
import 'package:glowy/domain/model/get_image_category_model.dart';
import 'package:glowy/domain/repository/get_image_category_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: GetImageCategoryRepository)
class GetImageCategoryRepositoryImpl implements GetImageCategoryRepository {
  final GetImageCategoryRemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  GetImageCategoryRepositoryImpl(this._remoteDataSource, this._networkInfo);

  @override
  Future<Either<Failure, ImageCategoryObject>> getImageCategoryData(
    String appId,
    String categoryId,
    int page,
    int limit,
  ) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.getImageCategoryData(
          appId,
          categoryId,
          page,
          limit,
        );
        debugPrint('>>> [HOME RAW] status: ${response.success}');
        debugPrint('>>> [HOME RAW] message: ${response.message}');
        debugPrint('>>> [HOME RAW] data: ${response.data}');
        debugPrint('>>> [HOME RAW] services: ${response.data?.items}');
        debugPrint('>>> [HOME RAW] banners: ${response.data?.pagination}');

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
