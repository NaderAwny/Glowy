import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:glowy/domain/model/get_drawer_model.dart';
import 'package:glowy/presentation/common/state_randrer/state_randrer_impl.dart';

part 'get_drawer_data_state.freezed.dart';

@freezed
abstract class GetDrawerDataState with _$GetDrawerDataState {
  const factory GetDrawerDataState({
    FlowState? flowState,
    DrawerAppObject? data,
  }) = _GetDrawerDataState;
}
