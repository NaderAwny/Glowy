import 'dart:ffi';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glowy/domain/model/list_app_model.dart';
import 'package:glowy/domain/usecase/list_app_usecase.dart';
import 'package:glowy/presentation/common/state_randrer/state_randrer.dart';
import 'package:glowy/presentation/common/state_randrer/state_randrer_impl.dart';
import 'package:glowy/presentation/home/list_app_cubit/list_app_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class ListAppCubit extends Cubit<ListAppState> {
  final ListAppUsecase _listAppUsecase;

  ListAppCubit(this._listAppUsecase) : super(ListAppState());
  void getListApp() async {
    emit(
      state.copyWith(
        flowState: LoadingState(
          stateRendererType: StateRendererType.fullScreenLoadingState,
        ),
      ),
    );

    // ignore: void_checks
    (await _listAppUsecase.execute(Void)).fold(
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
      (homeListAppModel) => {
        // right -> data (success)
        // if (!isClosed)
        emit(
          state.copyWith(
            data: HomeListAppModel(
              homeListAppModel.data.categories,
              homeListAppModel.data.apps,
            ),
            flowState: ContentState(),
          ),
        ),
      },
    );
  }
}
