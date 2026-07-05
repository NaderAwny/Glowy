import 'package:dartz/dartz.dart';
import 'package:glowy/data/network/failure.dart';
import 'package:glowy/domain/model/get_image_category_model.dart';
import 'package:glowy/domain/repository/get_image_category_repository.dart';
import 'package:glowy/domain/usecase/base_usecase.dart';
import 'package:injectable/injectable.dart';

class GetImageCategoryInput {
  final String appId;
  final String categoryId;
  final int page;
  final int limit;

  GetImageCategoryInput({
    required this.appId,
    required this.categoryId,
    required this.page,
    required this.limit,
  });
}

@injectable
class GetImageCategoryUsecase
    implements BaseUsecase<GetImageCategoryInput, ImageCategoryObject> {
  final GetImageCategoryRepository _getImageCategoryRepository;
  GetImageCategoryUsecase(this._getImageCategoryRepository);

  @override
  Future<Either<Failure, ImageCategoryObject>> execute(
    GetImageCategoryInput input,
  ) async {
    return await _getImageCategoryRepository.getImageCategoryData(
      input.appId,
      input.categoryId,
      input.page,
      input.limit,
    );
  }
}
