import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:glowy/domain/model/classification_category_model.dart';
import 'package:glowy/presentation/common/state_randrer/state_randrer_impl.dart';

part 'classification_category_state.freezed.dart';

@freezed
abstract class ClassificationCategoryState with _$ClassificationCategoryState {
  const factory ClassificationCategoryState({
    FlowState? flowState,
    ClassificationCategoryMainModel? data,
  }) = _ClassificationCategoryState;
}
