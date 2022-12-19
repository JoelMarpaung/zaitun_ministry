import 'dart:io';
import 'package:core/common/exception.dart';
import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:info/domain/repositories/info_repository.dart';
import '../../domain/entities/info.dart';
import '../datasources/info_data_source.dart';

class InfoRepositoryImpl implements InfoRepository {
  final InfoDataSource infoDataSource;

  InfoRepositoryImpl({
    required this.infoDataSource,
  });

  @override
  Future<Either<Failure, Info>> getDataInfo() async {
    try {
      final result = await infoDataSource.getDataInfo();
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

}
