import 'package:glowy/data/network/app_api.dart';
import 'package:glowy/data/responses/image_category_responses/image_category_responses.dart';
import 'package:injectable/injectable.dart';

abstract class GetImageCategoryRemoteDataSource {
  Future<ImageCategory> getImageCategoryData(
    String appId,
    String categoryId,
    int page,
    int limit,
  );
}

@LazySingleton(as: GetImageCategoryRemoteDataSource)
class GetImageCategoryRemoteDataSourceImpl
    implements GetImageCategoryRemoteDataSource {
  final AppServiceClient _appServiceClient;
  GetImageCategoryRemoteDataSourceImpl(this._appServiceClient);

  @override
  Future<ImageCategory> getImageCategoryData(
    String appId,
    String categoryId,
    int page,
    int limit,
  ) {
    return _appServiceClient.getImageCategoryContent(
      appId,
      categoryId,
      page,
      limit,
    );
  }
}
