import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:radio/domain/repositories/radio_repository.dart';

import '../entities/radio.dart';

class GetDataRadio {
  final RadioRepository repository;
  GetDataRadio(this.repository);

  Future<Either<Failure, Radio>> execute() {
    return repository.getDataRadio();
  }
}
