import 'dart:io';
import 'package:core/common/exception.dart';
import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:radio/data/datasources/radio_data_source.dart';
import 'package:radio/domain/repositories/radio_repository.dart';
import '../../domain/entities/radio.dart';

class RadioRepositoryImpl implements RadioRepository{
  final RadioDataSource radioDataSource;

  RadioRepositoryImpl({
    required this.radioDataSource,
  });

  @override
  Future<Either<Failure, Radio>> getDataRadio() async{
    try {
      final result = await radioDataSource.getDataRadio();
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}