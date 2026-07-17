import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:glowy/data/data_source/get_drawer_remote_data_source.dart';
import 'package:glowy/data/network/failure.dart';
import 'package:glowy/data/network/network_info.dart';
import 'package:glowy/data/repository_impl/get_drawer_repository_impl.dart';
import 'package:glowy/data/responses/get_drawer_data_responses/get_drawer_data_response.dart';
import 'package:mocktail/mocktail.dart';

class MockRemoteDataSource extends Mock implements GetDrawerRemoteDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late MockRemoteDataSource mockRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;
  // ignore: unused_local_variable
  late GetDrawerRepositoryImpl repository;
  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = GetDrawerRepositoryImpl(mockRemoteDataSource, mockNetworkInfo);
  });
  final appId = "appId";
  group("GetDrawerRepositoryImpl.getDrawer", () {
    test("no internet-> return NO_Internet failure when calling Api", () async {
      // arrange
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      // act
      final result = await repository.getDrawerData(appId);
      // assert
      expect(result, isA<Left<Failure, dynamic>>());
      verifyNever(() => mockRemoteDataSource.getDrawer(appId));
    });
    test('connected + success:true -> returns Right with the data', () async {
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(() => mockRemoteDataSource.getDrawer(appId)).thenAnswer(
        (_) async => GetDrawerDataResponse(
          success: true,
          message: "message",
          data: GetDrawerDataResponseData(
            app: DrawerApp(
              id: "id",
              name: "App one",
              platform: "platform",
              categories: [],
            ),
          ),
        ),
      );
      final result = await repository.getDrawerData(appId);
      expect(result, isA<Right<Failure, dynamic>>());
      result.fold(
        (l) => fail("expected success, got failure"),
        (r) => expect(r.data.apps.name, "App one"),
      );
    });

    test(
      'connected + success:false -> returns Left with the error message',
      () async {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);

        when(() => mockRemoteDataSource.getDrawer(appId)).thenAnswer(
          (_) async => GetDrawerDataResponse(
            success: false,
            message: "someThing went wrong",
          ),
        );
        final result = await repository.getDrawerData(appId);
        expect(result, isA<Left<Failure, dynamic>>());
        result.fold(
          (l) => expect(l.message, "someThing went wrong"),
          (r) => fail("expected failure, got success"),
        );
      },
    );
  });
}
