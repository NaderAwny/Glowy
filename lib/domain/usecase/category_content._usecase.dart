import 'package:dartz/dartz.dart';
import 'package:glowy/data/network/failure.dart';
import 'package:glowy/domain/model/get_image_category_model.dart';
import 'package:glowy/domain/repository/category_content_repository.dart';
import 'package:glowy/domain/usecase/base_usecase.dart';
import 'package:injectable/injectable.dart';

class GetCategoryContentInput {
  final String appId;
  final String categoryIdClassification;
  final int page;
  final int limit;
  final String classificationId;

  GetCategoryContentInput({
    required this.appId,
    required this.categoryIdClassification,
    required this.page,
    required this.limit,
    required this.classificationId,
  });
}

@injectable
class GetCategoryContentUsecase
    implements BaseUsecase<GetCategoryContentInput, ImageCategoryObject> {
  final CategoryContentRepository _categoryContentRepository;
  GetCategoryContentUsecase(this._categoryContentRepository);

  @override
  Future<Either<Failure, ImageCategoryObject>> execute(
    GetCategoryContentInput input,
  ) async {
    return await _categoryContentRepository.getCategoryContent(
      input.appId,
      input.categoryIdClassification,
      input.page,
      input.limit,
      input.classificationId,
    );
  }
}
