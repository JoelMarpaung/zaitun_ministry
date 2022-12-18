import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:radio/domain/repositories/radio_repository.dart';

class PlayRadio {
  final RadioRepository repository;
  PlayRadio(this.repository);

  Future<Either<Failure, void>> play(url) {
    return repository.playRadio(url);
  }
}
