import 'package:dartz/dartz.dart';
import 'package:glowy/data/network/failure.dart';
import 'package:glowy/domain/model/get_image_category_model.dart';

abstract class CategoryContentRepository {
  Future<Either<Failure, ImageCategoryObject>> getCategoryContent(
    String appId,
    String categoryIdClassification,
    int page,
    int limit,
    String classificationId,
  );
}
