import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glowy/domain/model/get_drawer_model.dart';
import 'package:glowy/domain/usecase/get_darwer_usecase.dart';
import 'package:glowy/presentation/common/state_randrer/state_randrer.dart';
import 'package:glowy/presentation/common/state_randrer/state_randrer_impl.dart';
import 'package:glowy/presentation/home/get_drawer_data_cubit/get_drawer_data_state.dart';

import 'package:injectable/injectable.dart';

@injectable
class GetDrawerDataCubit extends Cubit<GetDrawerDataState> {
  // ignore: unused_field
  final GetDarwerUsecase _getDrawerUsecase;

  GetDrawerDataCubit(this._getDrawerUsecase) : super(GetDrawerDataState());
  void getDrawerData(String appId) async {
    emit(
      state.copyWith(
        flowState: LoadingState(
          stateRendererType: StateRendererType.fullScreenLoadingState,
        ),
      ),
    );

    // ignore: void_checks
    (await _getDrawerUsecase.execute(appId)).fold(
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
      (drawerAppObject) => {
        // right -> data (success)
        // if (!isClosed)
        emit(
          state.copyWith(
            data: DrawerAppObject(drawerAppObject.data),
            flowState: ContentState(),
          ),
        ),
      },
    );
  }
}
