import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:glowy/domain/model/get_image_category_model.dart';
import 'package:glowy/presentation/common/state_randrer/state_randrer_impl.dart';

part 'get_category_content_state.freezed.dart';

@freezed
abstract class GetCategoryContentState with _$GetCategoryContentState {
  const factory GetCategoryContentState({
    FlowState? flowState,
    ImageCategoryObject? data,
    @Default(false) bool isLoadingMore,
    @Default(true) bool hasMore,
  }) = _GetCategoryContentState;
}
