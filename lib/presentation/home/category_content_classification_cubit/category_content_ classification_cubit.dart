// ignore_for_file: file_names
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glowy/domain/model/get_image_category_model.dart';
import 'package:glowy/domain/usecase/category_content._usecase.dart';
import 'package:glowy/presentation/common/state_randrer/state_randrer.dart';
import 'package:glowy/presentation/common/state_randrer/state_randrer_impl.dart';
import 'package:glowy/presentation/home/category_content_classification_cubit/category_content_classification_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetCategoryContentClassificationCubit
    extends Cubit<CategoryContentClassificationState> {
  // ignore: unused_field
  final GetCategoryContentUsecase _getCategoryContentUsecase;
  int currentPage = 1;

  final int limit = 20;

  GetCategoryContentClassificationCubit(this._getCategoryContentUsecase)
    : super(CategoryContentClassificationState());
  // first loading
  void getCategoryContentClassification({
    required String appId,
    required String categoryIdClassification,
    required String classificationId,
  }) async {
    appId = appId;
    categoryIdClassification = categoryIdClassification;
    classificationId = classificationId;
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
    final result = await _getCategoryContentUsecase.execute(
      GetCategoryContentInput(
        appId: appId,
        categoryIdClassification: categoryIdClassification,
        page: currentPage,
        limit: limit,
        classificationId: classificationId,
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
            // عدّل السطر ده حسب اسم الفيلد الفعلي في الـ model بتاعك
            hasMore:
                currentPage < imageCategoryObject.data.pagination.totalPages,
          ),
        );

        // ---------- تحميل صفحات إضافية ----------
        // ignore: unused_element
      },
    );
  }

  Future<void> loadMoreCategoryContentClassification({
    required String appId,
    required String categoryIdClassification,
    required String classificationId,
  }) async {
    // امنع تكرار النداء لو بيحمل بالفعل أو خلص كل الصفحات
    if (state.isLoadingMore || !state.hasMore) return;

    emit(state.copyWith(isLoadingMore: true));

    final nextPage = currentPage + 1;

    final result = await _getCategoryContentUsecase.execute(
      GetCategoryContentInput(
        appId: appId,
        categoryIdClassification: categoryIdClassification,
        page: nextPage,
        limit: limit,
        classificationId: classificationId,
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
