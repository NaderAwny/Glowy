import 'package:dartz/dartz.dart';
import 'package:glowy/data/network/failure.dart';
import 'package:glowy/domain/model/classification_category_model.dart';
import 'package:glowy/domain/repository/classification_category_repository.dart';
import 'package:glowy/domain/usecase/base_usecase.dart';
import 'package:injectable/injectable.dart';

class GetClassificationCategoryInput {
  final String appId;
  final String categoryId;

  GetClassificationCategoryInput({
    required this.appId,
    required this.categoryId,
  });
}

@injectable
class GetClassificationCategoryUsecase
    implements
        BaseUsecase<
          GetClassificationCategoryInput,
          ClassificationCategoryMainModel
        > {
  final GetClassificationCategoryRepository
  _getClassificationCategoryRepository;
  GetClassificationCategoryUsecase(this._getClassificationCategoryRepository);

  @override
  Future<Either<Failure, ClassificationCategoryMainModel>> execute(
    GetClassificationCategoryInput input,
  ) async {
    return await _getClassificationCategoryRepository
        .getClassificationCategoryData(input.appId, input.categoryId);
  }
}
