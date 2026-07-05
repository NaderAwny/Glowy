import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glowy/domain/model/get_image_category_model.dart';
import 'package:glowy/domain/usecase/get_image_category_usecase.dart';
import 'package:glowy/presentation/common/state_randrer/state_randrer.dart';
import 'package:glowy/presentation/common/state_randrer/state_randrer_impl.dart';

import 'package:glowy/presentation/home/get_category_content_cubit/get_category_content_state.dart';

import 'package:injectable/injectable.dart';

@injectable
class GetCategoryContentCubit extends Cubit<GetCategoryContentState> {
  // ignore: unused_field
  final GetImageCategoryUsecase _getImageCategoryUsecase;
  int currentPage = 1;

  final int limit = 20;

  GetCategoryContentCubit(this._getImageCategoryUsecase)
    : super(GetCategoryContentState());
  void getCategoryContent({
    required String appId,
    required String categoryId,
  }) async {
    appId = appId;
    categoryId = categoryId;
    currentPage = 1;
    emit(
      state.copyWith(
        flowState: LoadingState(
          stateRendererType: StateRendererType.fullScreenLoadingState,
        ),
        hasMore: true,
      ),
    );

    // ignore: void_checks
    final result = await _getImageCategoryUsecase.execute(
      GetImageCategoryInput(
        appId: appId,
        categoryId: categoryId,
        page: currentPage,
        limit: limit,
      ),
    );

    result.fold(
      (failure) {
        // left -> failure
        if (isClosed) return;
        emit(
          state.copyWith(
            flowState: ErrorState(
              StateRendererType.fullScreenErrorState,
              failure.message,
            ),
          ),
        );

        // ignore: avoid_print
        print(failure.message);
      },
      (imageCategoryObject) {
        // right -> data (success)
        if (isClosed) return;
        emit(
          state.copyWith(
            data: ImageCategoryObject(imageCategoryObject.data),
            flowState: ContentState(),
            hasMore:
                currentPage < imageCategoryObject.data.pagination.totalPages,
          ),
        );
      },
    );
  }

  Future<void> loadMoreCategoryContent({
    required String appId,
    required String categoryId,
  }) async {
    // امنع تكرار النداء لو بيحمل بالفعل أو خلص كل الصفحات
    if (state.isLoadingMore || !state.hasMore) return;

    emit(state.copyWith(isLoadingMore: true));

    final nextPage = currentPage + 1;

    final result = await _getImageCategoryUsecase.execute(
      GetImageCategoryInput(
        appId: appId,
        categoryId: categoryId,
        page: nextPage,
        limit: limit,
      ),
    );

    result.fold(
      (failure) {
        if (isClosed) return;
        emit(state.copyWith(isLoadingMore: false));
        // ممكن تعمل Snackbar أو Toast بدل ما توقف الشاشة كلها
      },
      (imageCategoryObject) {
        if (isClosed) return;
        currentPage = nextPage;

        // دمج الداتا القديمة مع الجديدة - عدّل حسب اسم الليست الفعلي جوه الموديل
        final mergedList = [
          ...?state.data?.data.items,
          ...imageCategoryObject.data.items,
        ];

        emit(
          state.copyWith(
            data: ImageCategoryObject(
              // ✅ نصنع object جديد بدل copyWith
              ImageCategoryData(
                mergedList,
                imageCategoryObject.data.pagination,
              ),
            ),
            isLoadingMore: false,
            hasMore: nextPage < imageCategoryObject.data.pagination.totalPages,
          ),
        );
      },
    );
  }
}
