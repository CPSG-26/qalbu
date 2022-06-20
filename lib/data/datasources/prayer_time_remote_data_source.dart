import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:qalbu/common/exception.dart';
import 'package:qalbu/data/models/prayer_time_daily_model.dart';
import 'package:qalbu/data/models/prayer_time_monthly_model.dart';

abstract class PrayerTimeRemoteDataSource {
  Future<PrayerTimeMonthlyModel> getPrayerTimeMonthly(
      double lat, double long, int month, int year);

  Future<PrayerTimeDailyModel> getPrayerTimeDaily(
      String timestamp, double lat, double long);
}

class PrayerTimeRemoteDataSourceImpl implements PrayerTimeRemoteDataSource {
  static const baseUrl = 'http://api.aladhan.com/v1';
  final http.Client client;

  PrayerTimeRemoteDataSourceImpl({required this.client});

  @override
  Future<PrayerTimeMonthlyModel> getPrayerTimeMonthly(
      double lat, double long, int month, int year) async {
    final response = await client.get(Uri.parse(
        '$baseUrl/calendar?latitude=$lat&longitude=$long&method=3&month=$month&year=$year'));

    if (response.statusCode == 200) {
      return PrayerTimeMonthlyModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<PrayerTimeDailyModel> getPrayerTimeDaily(
      String timestamp, double lat, double long) async {
    final response = await client.get(Uri.parse(
        '$baseUrl/timings/$timestamp?latitude=$lat&longitude=$long&method=3'));

    if (response.statusCode == 200) {
      return PrayerTimeDailyModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
