import 'dart:io';
import 'package:core/common/exception.dart';
import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:schedule/data/datasources/schedule_data_source.dart';
import 'package:schedule/domain/repositories/schedule_repository.dart';
import '../../domain/entities/schedule.dart';

class ScheduleRepositoryImpl implements ScheduleRepository {
  final ScheduleDataSource scheduleDataSource;

  ScheduleRepositoryImpl({
    required this.scheduleDataSource,
  });

  @override
  Future<Either<Failure, Schedule>> getDataSchedule() async {
    try {
      final result = await scheduleDataSource.getDataSchedule();
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

}
