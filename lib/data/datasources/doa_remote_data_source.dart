import 'dart:convert';

import 'package:qalbu/common/exception.dart';
import 'package:qalbu/data/models/doa_model.dart';
import 'package:http/http.dart' as http;

abstract class DoaRemoteDataSource {
  Future<List<DoaModel>> getDoaList();
  Future<DoaModel> getDoaDetail(String id);
}

class RemoteDataSourceImpl implements DoaRemoteDataSource {
  static const baseURL = 'https://doa-doa-api-ahmadramadhan.fly.dev/api';

  final http.Client client;

  RemoteDataSourceImpl({required this.client});

  @override
  Future<List<DoaModel>> getDoaList() async {
    final response = await client.get(Uri.parse(baseURL));

    if (response.statusCode == 200) {
      return doaModelFromJson(response.body);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<DoaModel> getDoaDetail(String id) async {
    final response = await client.get(Uri.parse('$baseURL/$id'));

    if (response.statusCode == 200) {
      return DoaModel.fromJson(json.decode(response.body)[0]);
    } else {
      throw ServerException();
    }
  }
}
