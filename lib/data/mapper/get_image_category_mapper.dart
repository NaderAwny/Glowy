import 'package:glowy/app/constants.dart';
import 'package:glowy/app/extensions.dart';
import 'package:glowy/data/responses/image_category_responses/image_category_responses.dart';
import 'package:glowy/domain/model/get_image_category_model.dart';

extension ImageItemsResponseMapper on ItemsImageCategory {
  ImageItemsModel toDomain() {
    return ImageItemsModel(
      id?.orEmpty() ?? Constants.empty,
      url?.orEmpty() ?? Constants.empty,
      thumbUrl?.orEmpty() ?? Constants.empty,
      isTopRated?.orFalse() ?? Constants.isFalse,
      mediaType?.orEmpty() ?? Constants.empty,
      classificationId?.orEmpty() ?? Constants.empty,
      classificationName?.orEmpty() ?? Constants.empty,
      classificationThumbnailUrl?.orEmpty() ?? Constants.empty,
      createdAt?.orEmpty() ?? Constants.empty,
    );
  }
}

extension PaginationResponseMapper on Pagination {
  PaginationModel toDomain() {
    return PaginationModel(
      page?.orZero() ?? Constants.zero,
      limit?.orZero() ?? Constants.zero,
      total?.orZero() ?? Constants.zero,
      totalPages?.orZero() ?? Constants.zero,
    );
  }
}

extension GetImageCategoryMapper on ImageCategory? {
  ImageCategoryObject toDomain() {
    List<ImageItemsModel> items = this?.data?.items != null
        ? this!.data!.items!.map((item) => item.toDomain()).toList()
        : [];

    PaginationModel pagination =
        this?.data?.pagination?.toDomain() ?? PaginationModel(0, 0, 0, 0);

    var data = ImageCategoryData(items, pagination);

    return ImageCategoryObject(data);
  }
}
