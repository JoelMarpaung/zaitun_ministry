import 'dart:async';

import 'package:core/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radio/presentation/bloc/radio_data_bloc/data_radio_bloc.dart';
import 'package:radio/presentation/bloc/radio_data_bloc/data_radio_event.dart';
import 'package:radio/presentation/bloc/radio_data_bloc/data_radio_state.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    context.read<DataRadioBloc>().add(const OnFetchDataRadio());
  }

  void _goToHomepage() {
    Timer(const Duration(seconds: 1), () {
      Navigator.pushNamedAndRemoveUntil(context, homePage, (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DataRadioBloc, RadioState>(
      listener: (BuildContext context, state) {
        if (state is RadioComplete) {
          _goToHomepage();
        }
      },
      child: const Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Image(
            image: AssetImage('assets/icons/icon_transparent.png'),
            width: double.infinity
          ),
        ),
      ),
    );
  }
}
