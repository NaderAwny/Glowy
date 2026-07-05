import 'package:glowy/data/network/app_api.dart';
import 'package:glowy/data/responses/classification_category_responses/classification_category_responses.dart';
import 'package:injectable/injectable.dart';

abstract class GetClassificationCategoryRemoteDataSource {
  Future<ClassificationMainResponse> getClassificationCategoryData(
    String appId,
    String categoryId,
  );
}

@LazySingleton(as: GetClassificationCategoryRemoteDataSource)
class GetClassificationCategoryRemoteDataSourceImpl
    implements GetClassificationCategoryRemoteDataSource {
  final AppServiceClient _appServiceClient;
  GetClassificationCategoryRemoteDataSourceImpl(this._appServiceClient);

  @override
  Future<ClassificationMainResponse> getClassificationCategoryData(
    String appId,
    String categoryId,
  ) {
    return _appServiceClient.getImageCategoryClassification(appId, categoryId);
  }
}
