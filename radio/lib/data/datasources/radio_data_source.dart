import 'dart:convert';

import 'package:core/common/exception.dart';
import 'package:core/constants/urls.dart';
import 'package:http/http.dart' as http;
import 'package:radio/data/models/radio_model.dart';

abstract class RadioDataSource {
  Future<RadioModel> getDataRadio();
}

class RadioDataSourceImpl implements RadioDataSource{
  final http.Client client;
  RadioDataSourceImpl({required this.client});

  @override
  Future<RadioModel> getDataRadio() async{
    final response = await client
        .get(Uri.parse(githubUrl + radioUrl));
    if (response.statusCode == 200) {
      return RadioModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

}