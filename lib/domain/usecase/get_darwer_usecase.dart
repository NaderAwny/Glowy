import 'package:dartz/dartz.dart';
import 'package:glowy/data/network/failure.dart';
import 'package:glowy/domain/model/get_drawer_model.dart';
import 'package:glowy/domain/repository/get_drawer_repository.dart';
import 'package:glowy/domain/usecase/base_usecase.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetDarwerUsecase implements BaseUsecase<String, DrawerAppObject> {
  final GetDrawerRepository _getDrawerRepository;
  GetDarwerUsecase(this._getDrawerRepository);
  @override
  Future<Either<Failure, DrawerAppObject>> execute(String input) async {
    return await _getDrawerRepository.getDrawerData(input);
  }
}
