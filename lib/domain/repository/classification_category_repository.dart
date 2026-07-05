import 'package:dartz/dartz.dart';
import 'package:glowy/data/network/failure.dart';
import 'package:glowy/domain/model/classification_category_model.dart';

abstract class GetClassificationCategoryRepository {
  Future<Either<Failure, ClassificationCategoryMainModel>>
  getClassificationCategoryData(String appId, String categoryId);
}
