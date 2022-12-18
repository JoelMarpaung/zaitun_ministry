import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:schedule/domain/entities/schedule.dart';
import 'package:schedule/domain/repositories/schedule_repository.dart';

class GetDataSchedule {
  final ScheduleRepository repository;
  GetDataSchedule(this.repository);

  Future<Either<Failure, Schedule>> execute() {
    return repository.getDataSchedule();
  }
}
