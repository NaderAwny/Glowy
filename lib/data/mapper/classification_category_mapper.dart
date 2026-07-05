import 'package:glowy/app/constants.dart';
import 'package:glowy/app/extensions.dart';
import 'package:glowy/data/responses/classification_category_responses/classification_category_responses.dart';
import 'package:glowy/domain/model/classification_category_model.dart';

extension ClassificationResponseMapper on ClassificationResponse {
  ClassificationModel toDomain() {
    return ClassificationModel(
      id: id?.orEmpty() ?? Constants.empty,
      name: name?.orEmpty() ?? Constants.empty,
      thumbnailUrl: thumbnailUrl?.orEmpty() ?? Constants.empty,
      itemCount: itemCount?.orZero() ?? Constants.zero,
    );
  }
}

extension GetClassificationCategoryMapper on ClassificationMainResponse? {
  ClassificationCategoryMainModel toDomain() {
    List<ClassificationModel> classification =
        this?.data?.classifications != null
        ? this!.data!.classifications!.map((item) => item.toDomain()).toList()
        : [];

    var data = ClassificationCategoryModel(classification: classification);

    return ClassificationCategoryMainModel(data: data);
  }
}
