import 'package:glowy/data/network/app_api.dart';
import 'package:glowy/data/responses/get_drawer_data_responses/get_drawer_data_response.dart';
import 'package:injectable/injectable.dart';

abstract class GetDrawerRemoteDataSource {
  Future<GetDrawerDataResponse> getDrawer(String appId);
}

@LazySingleton(as: GetDrawerRemoteDataSource)
class GetDrawerRemoteDataSourceImpl implements GetDrawerRemoteDataSource {
  final AppServiceClient _appServiceClient;
  GetDrawerRemoteDataSourceImpl(this._appServiceClient);

  @override
  Future<GetDrawerDataResponse> getDrawer(String appId) {
    return _appServiceClient.getDrawerData(appId);
  }
}
