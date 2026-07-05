import 'package:dartz/dartz.dart';
import 'package:glowy/data/network/failure.dart';
import 'package:glowy/domain/model/get_drawer_model.dart';

abstract class GetDrawerRepository {
  Future<Either<Failure, DrawerAppObject>> getDrawerData(String appId);
}
