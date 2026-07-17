import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:glowy/data/network/failure.dart';
import 'package:glowy/domain/model/list_app_model.dart';
import 'package:glowy/domain/usecase/list_app_usecase.dart';
import 'package:glowy/presentation/common/state_randrer/state_randrer_impl.dart';
import 'package:glowy/presentation/home/list_app_cubit/list_app_cubit.dart';
import 'package:glowy/presentation/home/list_app_cubit/list_app_state.dart';
import 'package:mocktail/mocktail.dart';

class MockListAppUsecase extends Mock implements ListAppUsecase {}

void main() {
  late MockListAppUsecase mockListAppUsecase;
  setUp(() {
    mockListAppUsecase = MockListAppUsecase();
  });
  // Note: the real code calls execute(Void) instead of execute(null),
  // so we use any() to match whatever value gets passed.
  group("ListAppCubit", () {
    blocTest<ListAppCubit, ListAppState>(
      'success -> emits [Loading, Content]',
      build: () {
        when(() => mockListAppUsecase.execute(any())).thenAnswer(
          (_) async => Right(ListAppObject(HomeListAppModel([], []))),
        );

        return ListAppCubit(mockListAppUsecase);
      },

      act: (cubit) => cubit.getListApp(),
      expect: () => [
        isA<ListAppState>().having(
          (s) => s.flowState,
          "flowstate",
          isA<LoadingState>(),
        ),
        isA<ListAppState>().having(
          (s) => s.flowState,
          "flowstate",
          isA<ContentState>(),
        ),
      ],
    );

    blocTest<ListAppCubit, ListAppState>(
      'failure -> emits [Loading, Error] with the message',
      build: () {
        when(
          () => mockListAppUsecase.execute(any()),
        ).thenAnswer((_) async => Left(Failure(-7, 'Something went wrong')));

        return ListAppCubit(mockListAppUsecase);
      },

      act: (cubit) => cubit.getListApp(),
      expect: () => [
        isA<ListAppState>().having(
          (s) => s.flowState,
          "flowstate",
          isA<LoadingState>(),
        ),
        isA<ListAppState>().having(
          (s) => (s.flowState as ErrorState).message,
          "error message",
          "Something went wrong",
        ),
      ],
    );
  });
}
