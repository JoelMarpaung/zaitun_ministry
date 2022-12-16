import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:radio/domain/repositories/radio_repository.dart';

class StopRadio {
  final RadioRepository repository;
  StopRadio(this.repository);

  Future<Either<Failure, void>> stop(){
    return repository.stopRadio();
  }
}