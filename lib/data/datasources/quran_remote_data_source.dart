import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:qalbu/common/exception.dart';
import 'package:qalbu/data/models/quran_detail_model.dart';
import 'package:qalbu/data/models/quran_model.dart';

abstract class QuranRemoteDataSource {
  Future<List<QuranModel>> getQuranList();

  Future<QuranDetailModel> getQuranDetail(int id);
}

class QuranRemoteDataSourceImpl implements QuranRemoteDataSource {
  static const baseUrl = 'https://equran.id/api';
  final http.Client client;

  QuranRemoteDataSourceImpl({required this.client});

  @override
  Future<List<QuranModel>> getQuranList() async {
    final response = await client.get(Uri.parse('$baseUrl/surat'));

    if (response.statusCode == 200) {
      return quranFromJson(response.body);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<QuranDetailModel> getQuranDetail(int id) async {
    final response = await client.get(Uri.parse('$baseUrl/surat/$id'));

    if (response.statusCode == 200) {
      return QuranDetailModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
