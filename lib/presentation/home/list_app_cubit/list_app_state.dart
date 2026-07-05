import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:glowy/domain/model/list_app_model.dart';
import 'package:glowy/presentation/common/state_randrer/state_randrer_impl.dart';

part 'list_app_state.freezed.dart';

@freezed
abstract class ListAppState with _$ListAppState {
  const factory ListAppState({FlowState? flowState, HomeListAppModel? data}) =
      _ListAppState;
}
