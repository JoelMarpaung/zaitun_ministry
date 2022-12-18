import 'dart:convert';
import 'package:core/common/exception.dart';
import '../models/schedule_model.dart';
import 'package:core/constants/urls.dart';
import 'package:http/http.dart' as http;

abstract class ScheduleDataSource {
  Future<ScheduleModel> getDataSchedule();
}

class ScheduleDataSourceImpl implements ScheduleDataSource {
  final http.Client client;

  ScheduleDataSourceImpl({required this.client});

  @override
  Future<ScheduleModel> getDataSchedule() async {
    final response = await client.get(Uri.parse(githubUrl + scheduleUrl));
    if (response.statusCode == 200) {
      return ScheduleModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}