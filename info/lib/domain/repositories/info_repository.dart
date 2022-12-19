import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import '../entities/info.dart';

abstract class InfoRepository {
  Future<Either<Failure, Info>> getDataInfo();
}
