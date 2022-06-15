import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:qalbu/common/exception.dart';
import 'package:qalbu/common/failure.dart';
import 'package:qalbu/data/datasources/doa_local_data_source.dart';
import 'package:qalbu/data/datasources/doa_remote_data_source.dart';
import 'package:qalbu/data/models/doa_table.dart';
import 'package:qalbu/domain/entities/doa.dart';
import 'package:qalbu/domain/repositories/doa_repository.dart';

class DoaRepositoryImpl implements DoaRepository {
  final DoaRemoteDataSource doaRemoteDataSource;
  final DoaLocalDataSource doaLocalDataSource;

  DoaRepositoryImpl({
    required this.doaRemoteDataSource,
    required this.doaLocalDataSource,
  });

  @override
  Future<Either<Failure, List<Doa>>> getDoaList() async {
    try {
      final result = await doaRemoteDataSource.getDoaList();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, Doa>> getDoaDetail(String id) async {
    try {
      final result = await doaRemoteDataSource.getDoaDetail(id);
      return Right(result.toEntity());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, String>> saveFavorite(Doa doa) async {
    try {
      final result =
      await doaLocalDataSource.insertFavorite(DoaTable.fromEntity(doa));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<Either<Failure, String>> removeFavorite(Doa doa) async {
    try {
      final result =
      await doaLocalDataSource.removeFavorite(DoaTable.fromEntity(doa));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<bool> isAddedToFavorite(String id) async {
    final result = await doaLocalDataSource.getDoaById(id);
    return result != null;
  }

  @override
  Future<Either<Failure, List<Doa>>> getFavoriteDoa() async {
    final result = await doaLocalDataSource.getFavoriteDoa();
    return Right(result.map((data) => data.toEntity()).toList());
  }
}
