import 'package:dartz/dartz.dart';
import 'package:glowy/data/network/failure.dart';
import 'package:glowy/domain/model/get_image_category_model.dart';

abstract class GetImageCategoryRepository {
  Future<Either<Failure, ImageCategoryObject>> getImageCategoryData(
    String appId,
    String categoryId,
    int page,
    int limit,
  );
}
