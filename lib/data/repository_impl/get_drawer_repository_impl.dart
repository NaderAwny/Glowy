import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:glowy/data/data_source/get_drawer_remote_data_source.dart';
import 'package:glowy/data/mapper/get_drawer_mapper.dart';
import 'package:glowy/data/network/error_handler.dart';
import 'package:glowy/data/network/failure.dart';
import 'package:glowy/data/network/network_info.dart';
import 'package:glowy/domain/model/get_drawer_model.dart';
import 'package:glowy/domain/repository/get_drawer_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: GetDrawerRepository)
class GetDrawerRepositoryImpl implements GetDrawerRepository {
  final GetDrawerRemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  GetDrawerRepositoryImpl(this._remoteDataSource, this._networkInfo);

  @override
  Future<Either<Failure, DrawerAppObject>> getDrawerData(String appId) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.getDrawer(appId);

        // 🔍 طبع الـ response الخام قبل أي فحص
        debugPrint('>>> [HOME RAW] status: ${response.success}');
        debugPrint('>>> [HOME RAW] message: ${response.message}');
        debugPrint('>>> [HOME RAW] data: ${response.data}');
        debugPrint('>>> [HOME RAW] app: ${response.data?.app}');
        debugPrint(
          '>>> [HOME RAW] categories: ${response.data?.app?.categories}',
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
