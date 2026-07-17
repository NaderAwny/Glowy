import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:glowy/data/data_source/list_app_remote_data_source.dart';
import 'package:glowy/data/network/failure.dart';
import 'package:glowy/data/network/network_info.dart';
import 'package:glowy/data/repository_impl/list_app_repository_impl.dart';
import 'package:glowy/data/responses/list_app_responses/list_app.dart';
import 'package:mocktail/mocktail.dart';

class MockRemoteDataSource extends Mock implements RemoteDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late MockRemoteDataSource mockRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;
  // ignore: unused_local_variable
  late ListAppRepositoryImpl repository;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = ListAppRepositoryImpl(mockRemoteDataSource, mockNetworkInfo);
  });
  group("ListAppRepositoryImpl.ListApp", () {
    test("no internet-> return NO_Internet failure when calling Api", () async {
      // arrange
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      // act
      final result = await repository.listApp();
      // assert
      expect(result, isA<Left<Failure, dynamic>>());
      verifyNever(() => mockRemoteDataSource.listappdata());
    });

    test('connected + success:true -> returns Right with the data', () async {
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(() => mockRemoteDataSource.listappdata()).thenAnswer(
        (_) async => HomeResponse(
          success: true,
          message: "message",
          data: HomeDataResponse([], [
            ListApp("id", "App one", "platform", []),
          ]),
        ),
      );
      final result = await repository.listApp();
      expect(result, isA<Right<Failure, dynamic>>());
      result.fold(
        (l) => fail("expected success, got failure"),
        (r) => expect(r.data.apps.first.name, "App one"),
      );
    });

    test(
      'connected + success:false -> returns Left with the error message',
      () async {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);

        when(() => mockRemoteDataSource.listappdata()).thenAnswer(
          (_) async =>
              HomeResponse(success: false, message: "someThing went wrong"),
        );
        final result = await repository.listApp();
        expect(result, isA<Left<Failure, dynamic>>());
        result.fold(
          (l) => expect(l.message, "someThing went wrong"),
          (r) => fail("expected failure, got success"),
        );
      },
    );
  });
}
