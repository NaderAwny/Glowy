import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:glowy/domain/model/get_drawer_model.dart';
import 'package:glowy/domain/repository/get_drawer_repository.dart';
import 'package:glowy/domain/usecase/get_darwer_usecase.dart';
import 'package:mocktail/mocktail.dart';

class MockGetDrawerRepository extends Mock implements GetDrawerRepository {}

void main() {
  late MockGetDrawerRepository mockGetDrawerRepository;
  late GetDarwerUsecase getDrawerUsecase;
  setUp(() {
    mockGetDrawerRepository = MockGetDrawerRepository();
    getDrawerUsecase = GetDarwerUsecase(mockGetDrawerRepository);
  });
  test('returns exactly what the repository returns', () async {
    final fakeobject = DrawerAppObject(
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
    );
    when(
      () => mockGetDrawerRepository.getDrawerData("id"),
    ).thenAnswer((_) async => Right(fakeobject));
    final result = await getDrawerUsecase.execute("id");
    expect(result, Right(fakeobject));
    verify(() => mockGetDrawerRepository.getDrawerData("id")).called(1);
  });
}
