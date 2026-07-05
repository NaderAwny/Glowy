import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glowy/domain/model/classification_category_model.dart';
import 'package:glowy/domain/usecase/classification_category_usecase.dart';
import 'package:glowy/presentation/common/state_randrer/state_randrer.dart';
import 'package:glowy/presentation/common/state_randrer/state_randrer_impl.dart';
import 'package:glowy/presentation/home/classification_category_cubit/classification_category_state.dart';

import 'package:injectable/injectable.dart';

@injectable
class ClassificationCategoryCubit extends Cubit<ClassificationCategoryState> {
  // ignore: unused_field
  final GetClassificationCategoryUsecase _getClassificationCategoryUsecase;

  ClassificationCategoryCubit(this._getClassificationCategoryUsecase)
    : super(ClassificationCategoryState());
  void getClassificationCategory({
    required String appId,
    required String categoryId,
  }) async {
    emit(
      state.copyWith(
        flowState: LoadingState(
          stateRendererType: StateRendererType.fullScreenLoadingState,
        ),
      ),
    );

    // ignore: void_checks
    (await _getClassificationCategoryUsecase.execute(
      GetClassificationCategoryInput(appId: appId, categoryId: categoryId),
    )).fold(
      (failure) => {
        // left -> failure
        //if (!isClosed)
        emit(
          state.copyWith(
            flowState: ErrorState(
              StateRendererType.fullScreenErrorState,
              failure.message,
            ),
          ),
        ),

        // ignore: avoid_print
        print(failure.message),
      },
      (classificationCategoryObject) => {
        // right -> data (success)
        // if (!isClosed)
        emit(
          state.copyWith(
            data: ClassificationCategoryMainModel(
              data: classificationCategoryObject.data,
            ),
            flowState: ContentState(),
          ),
        ),
      },
    );
  }
}
