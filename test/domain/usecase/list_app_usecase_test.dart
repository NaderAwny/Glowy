import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:glowy/domain/model/list_app_model.dart';
import 'package:glowy/domain/repository/list_app_repository.dart';
import 'package:glowy/domain/usecase/list_app_usecase.dart';
import 'package:mocktail/mocktail.dart';

class MockListAppRepository extends Mock implements ListAppRepository {}

void main() {
  late MockListAppRepository mockListAppRepository;
  late ListAppUsecase listAppUseCase;
  setUp(() {
    mockListAppRepository = MockListAppRepository();
    listAppUseCase = ListAppUsecase(mockListAppRepository);
  });
  test('returns exactly what the repository returns', () async {
    final fakeobject = ListAppObject(HomeListAppModel([], []));
    when(
      () => mockListAppRepository.listApp(),
    ).thenAnswer((_) async => Right(fakeobject));
    final result = await listAppUseCase.execute(null);
    expect(result, Right(fakeobject));
    verify(() => mockListAppRepository.listApp()).called(1);
  });
}
