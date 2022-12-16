import 'dart:convert';

import 'package:core/common/exception.dart';
import 'package:core/constants/urls.dart';
import 'package:http/http.dart' as http;
import 'package:just_audio/just_audio.dart';
import 'package:radio/data/models/radio_model.dart';

abstract class RadioDataSource {
  Future<RadioModel> getDataRadio();
  Future<void> playRadio(String url);
  Future<void> stopRadio();
}

class RadioDataSourceImpl implements RadioDataSource{
  final http.Client client;
  final AudioPlayer audioPlayer;
  RadioDataSourceImpl({required this.client, required this.audioPlayer});
  var _isUrlSet = false;

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

  @override
  Future<void> playRadio(String url) async{
    if (!_isUrlSet) {
      await audioPlayer.setUrl(url);
      _isUrlSet = true;
    }
    return audioPlayer.play();
  }

  @override
  Future<void> stopRadio() {
    return audioPlayer.pause();
  }

}