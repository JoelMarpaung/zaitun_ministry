import 'dart:convert';
import 'package:core/common/exception.dart';
import '../models/info_model.dart';
import 'package:core/constants/urls.dart';
import 'package:http/http.dart' as http;

abstract class InfoDataSource {
  Future<InfoModel> getDataInfo();
}

class InfoDataSourceImpl implements InfoDataSource {
  final http.Client client;

  InfoDataSourceImpl({required this.client});

  @override
  Future<InfoModel> getDataInfo() async {
    final response = await client.get(Uri.parse(githubUrl + infoUrl));
    if (response.statusCode == 200) {
      return InfoModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}