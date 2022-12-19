import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:info/domain/entities/info.dart';
import 'package:info/domain/repositories/info_repository.dart';

class GetDataInfo {
  final InfoRepository repository;
  GetDataInfo(this.repository);

  Future<Either<Failure, Info>> execute() {
    return repository.getDataInfo();
  }
}
