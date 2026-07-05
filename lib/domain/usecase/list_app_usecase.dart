import 'package:dartz/dartz.dart';
import 'package:glowy/data/network/failure.dart';
import 'package:glowy/domain/model/list_app_model.dart';
import 'package:glowy/domain/repository/list_app_repository.dart';
import 'package:glowy/domain/usecase/base_usecase.dart';
import 'package:injectable/injectable.dart';

@injectable
class ListAppUsecase implements BaseUsecase<void, ListAppObject> {
  final ListAppRepository _listAppRepository;
  ListAppUsecase(this._listAppRepository);
  @override
  Future<Either<Failure, ListAppObject>> execute(void input) async {
    return await _listAppRepository.listApp();
  }
}
