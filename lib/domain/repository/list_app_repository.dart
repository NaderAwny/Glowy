import 'package:dartz/dartz.dart';
import 'package:glowy/data/network/failure.dart';
import 'package:glowy/domain/model/list_app_model.dart';

abstract class ListAppRepository {
  Future<Either<Failure, ListAppObject>> listApp();
}