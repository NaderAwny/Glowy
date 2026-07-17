import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:glowy/data/network/failure.dart';
import 'package:glowy/domain/model/get_drawer_model.dart';
import 'package:glowy/domain/usecase/get_darwer_usecase.dart';
import 'package:glowy/presentation/common/state_randrer/state_randrer_impl.dart';
import 'package:glowy/presentation/home/get_drawer_data_cubit/get_drawer_data_cubit.dart';
import 'package:glowy/presentation/home/get_drawer_data_cubit/get_drawer_data_state.dart';
import 'package:mocktail/mocktail.dart';

class MockGetDrawerUsecase extends Mock implements GetDarwerUsecase {}

void main() {
  late MockGetDrawerUsecase mockGetDrawerUsecase;

  setUp(() {
    mockGetDrawerUsecase = MockGetDrawerUsecase();
  });
  group("get drawer data", () {
    blocTest<GetDrawerDataCubit, GetDrawerDataState>(
      "success -> emits [Loading, Content]",
      build: () {
        when(() => mockGetDrawerUsecase.execute(any())).thenAnswer(
          (_) async => Right(
            DrawerAppObject(
              DrawerAppDataModel(
                [],
                DrawerAppModel(
                  "id",
                  "name",
                  "description",
                  "platform",
                  "about",
                  "privacyPolicy",
                  "termsOfUse",
                  "androidShareLink",
                  "iphoneShareLink",
                  "contactEmail",
                  [],
                ),
              ),
            ),
          ),
        );
        return GetDrawerDataCubit(mockGetDrawerUsecase);
      },
      act: (cubit) => cubit.getDrawerData("id"),
      expect: () => [
        isA<GetDrawerDataState>().having(
          (s) => s.flowState,
          "flow state",
          isA<LoadingState>(),
        ),
        isA<GetDrawerDataState>().having(
          (s) => s.flowState,
          "flow state",
          isA<ContentState>(),
        ),
      ],
    );
    blocTest<GetDrawerDataCubit, GetDrawerDataState>(
      "failure -> emits [Loading, Error]",
      build: () {
        when(
          () => mockGetDrawerUsecase.execute(any()),
        ).thenAnswer((_) async => Left(Failure(-7, "Something went wrong")));
        return GetDrawerDataCubit(mockGetDrawerUsecase);
      },
      act: (cubit) => cubit.getDrawerData("id"),
      expect: () => [
        isA<GetDrawerDataState>().having(
          (s) => s.flowState,
          "flow state",
          isA<LoadingState>(),
        ),
        isA<GetDrawerDataState>().having(
          (s) => (s.flowState as ErrorState).message,
          "error message",
          "Something went wrong",
        ),
      ],
    );
  });
}
