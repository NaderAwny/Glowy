import 'package:glowy/data/network/app_api.dart';
import 'package:glowy/data/responses/image_category_responses/image_category_responses.dart';
import 'package:injectable/injectable.dart';

abstract class CategoryContentRemoteDataSource {
  Future<ImageCategory> getCategoryContent(
    String appId,
    String categoryIdClassification,
    int page,
    int limit,
    String classificationId,
  );
}

@LazySingleton(as: CategoryContentRemoteDataSource)
class CategoryContentRemoteDataSourceImpl
    implements CategoryContentRemoteDataSource {
  final AppServiceClient _appServiceClient;
  CategoryContentRemoteDataSourceImpl(this._appServiceClient);

  @override
  Future<ImageCategory> getCategoryContent(
    String appId,
    String categoryIdClassification,
    int page,
    int limit,
    String classificationId,
  ) {
    return _appServiceClient.getImageCategoryContentClassification(
      appId,
      categoryIdClassification,
      page,
      limit,
      classificationId,
    );
  }
}
