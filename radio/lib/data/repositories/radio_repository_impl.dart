import 'dart:io';
import 'package:core/common/exception.dart';
import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:just_audio/just_audio.dart';
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

  @override
  Future<Either<Failure, void>> playRadio(String url) async{
    // Catching errors at load time
    try {
      return Right(await radioDataSource.playRadio(url));
    } on PlayerException catch (e) {
      return Left(ServerFailure(e.message??''));
    } on PlayerInterruptedException catch (e) {
      return Left(ServerFailure(e.message??''));
    } catch (e) {
      return Left(ConnectionFailure(e.toString()));
    }

  }

  @override
  Future<Either<Failure, void>> stopRadio() async{
    // Catching errors at load time
    try {
      return Right(await radioDataSource.stopRadio());
    } on PlayerException catch (e) {
    return Left(ServerFailure(e.message??''));
    } on PlayerInterruptedException catch (e) {
    return Left(ServerFailure(e.message??''));
    } catch (e) {
    return Left(ConnectionFailure(e.toString()));
    }
  }
}