import 'package:glowy/data/network/app_api.dart';
import 'package:glowy/data/responses/list_app_responses/list_app.dart';
import 'package:injectable/injectable.dart';

abstract class RemoteDataSource {
  Future<HomeResponse> listappdata();
}

@LazySingleton(as: RemoteDataSource)
class RemoteDataSourceImpl implements RemoteDataSource {
  final AppServiceClient _appServiceClient;
  RemoteDataSourceImpl(this._appServiceClient);
  @override
  Future<HomeResponse> listappdata() {
    return _appServiceClient.listApp();
  }
}
