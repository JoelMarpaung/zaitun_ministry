import 'package:core/constants/urls.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RadioPage extends StatefulWidget {

  const RadioPage({super.key});

  @override
  State<RadioPage> createState() => _RadioPageState();
}

class _RadioPageState extends State<RadioPage> {
  final _planetRockUrl = 'https://stream-mz.planetradio.co.uk/planetrock.mp3';

  final _planetRockImage = 'assets/images/planet_rock.png';
  late String _text;
  late SharedPreferences _pref;

  Future getSharedPrefs() async {
    _pref = await SharedPreferences.getInstance();
    _text = _pref.getString(streamPref) ??'';
    print('yapp');
    print(_text);
  }

  @override
  void initState(){
    // TODO: implement initState
    getSharedPrefs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Online Radio'),
      ),
      body: const Padding(
        padding: EdgeInsets.only(bottom: 100),
        child: Center(
          child: Text('test'),
        ))
    );
  }
}