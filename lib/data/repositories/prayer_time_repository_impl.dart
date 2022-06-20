import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:qalbu/common/exception.dart';
import 'package:qalbu/common/failure.dart';
import 'package:qalbu/data/datasources/prayer_time_remote_data_source.dart';
import 'package:qalbu/domain/entities/prayer_time_daily.dart';
import 'package:qalbu/domain/entities/prayer_time_monthly.dart';
import 'package:qalbu/domain/repositories/prayer_time_repository.dart';

class PrayerTimeRepositoryImpl implements PrayerTimeRepository {
  final PrayerTimeRemoteDataSource remoteDataSource;

  PrayerTimeRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, PrayerTimeMonthly>> getPrayerTimeMonthly(
      double lat, double long, int month, int year) async {
    try {
      final result =
          await remoteDataSource.getPrayerTimeMonthly(lat, long, month, year);
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, PrayerTimeDaily>> getPrayerTimeDaily(
      String timestamp, double lat, double long) async {
    try {
      final result =
          await remoteDataSource.getPrayerTimeDaily(timestamp, lat, long);
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}
