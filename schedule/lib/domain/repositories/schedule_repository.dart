import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import '../entities/schedule.dart';

abstract class ScheduleRepository {
  Future<Either<Failure, Schedule>> getDataSchedule();
}
