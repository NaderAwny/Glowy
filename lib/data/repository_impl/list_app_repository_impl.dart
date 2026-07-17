import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:glowy/data/data_source/list_app_remote_data_source.dart';
import 'package:glowy/data/mapper/list_app_mapper.dart';
import 'package:glowy/data/network/error_handler.dart';
import 'package:glowy/data/network/failure.dart';
import 'package:glowy/data/network/network_info.dart';
import 'package:glowy/domain/model/list_app_model.dart';
import 'package:glowy/domain/repository/list_app_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ListAppRepository)
class ListAppRepositoryImpl implements ListAppRepository {
  final RemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  ListAppRepositoryImpl(this._remoteDataSource, this._networkInfo);

  @override
  Future<Either<Failure, ListAppObject>> listApp() async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.listappdata();

        // 🔍 طبع الـ response الخام قبل أي فحص
        debugPrint('>>> [HOME RAW] status: ${response.success}');
        debugPrint('>>> [HOME RAW] message: ${response.message}');
        debugPrint('>>> [HOME RAW] data: ${response.data}');
        debugPrint('>>> [HOME RAW] apps: ${response.data?.apps}');
        debugPrint('>>> [HOME RAW] categories: ${response.data?.categories}');

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
