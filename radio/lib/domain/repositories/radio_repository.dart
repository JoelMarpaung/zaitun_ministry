import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import '../entities/radio.dart';
abstract class RadioRepository {
  Future<Either<Failure, Radio>> getDataRadio();
}