import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:glowy/data/data_source/category_content_data_source.dart';
import 'package:glowy/data/mapper/get_image_category_mapper.dart';
import 'package:glowy/data/network/error_handler.dart';
import 'package:glowy/data/network/failure.dart';
import 'package:glowy/data/network/network_info.dart';
import 'package:glowy/domain/model/get_image_category_model.dart';
import 'package:glowy/domain/repository/category_content_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: CategoryContentRepository)
class CategoryContentRepositoryImpl implements CategoryContentRepository {
  final CategoryContentRemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  CategoryContentRepositoryImpl(this._remoteDataSource, this._networkInfo);

  @override
  Future<Either<Failure, ImageCategoryObject>> getCategoryContent(
    String appId,
    String categoryIdClassification,
    int page,
    int limit,
    String classificationId,
  ) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.getCategoryContent(
          appId,
          categoryIdClassification,
          page,
          limit,
          classificationId,
        );
        debugPrint('>>> [category content RAW] status: ${response.success}');
        debugPrint('>>> [category content RAW] message: ${response.message}');
        debugPrint('>>> [category content RAW] data: ${response.data}');
        debugPrint(
          '>>> [category content RAW] services: ${response.data?.items}',
        );
        debugPrint(
          '>>> [category content RAW] banners: ${response.data?.pagination}',
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
