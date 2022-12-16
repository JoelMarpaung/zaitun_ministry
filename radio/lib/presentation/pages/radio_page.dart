import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radio/presentation/bloc/radio_player_bloc/radio_player_bloc.dart';
import 'package:radio/presentation/bloc/radio_player_bloc/radio_player_event.dart';
import 'package:radio/presentation/bloc/radio_player_bloc/radio_player_state.dart';

import '../widgets/equilizer.dart';

class RadioPage extends StatefulWidget {
  const RadioPage({super.key});

  @override
  _RadioPageState createState() => _RadioPageState();
}

class _RadioPageState extends State<RadioPage>
    with TickerProviderStateMixin {
  late RadioPlayerBloc radioPlayerBloc;
  late AnimationController _animationController;
  late Animation<double> _animation;
  late List<AnimationController> _animationControllers;

  @override
  void initState() {
    radioPlayerBloc = context.read<RadioPlayerBloc>();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController);
    _animationControllers = List.generate( // Add this line
      10, // Add this line
          (index) => AnimationController( // Add this line
        vsync: this, // Add this line
        duration: Duration(milliseconds: Random().nextInt(1000) + 1000), // Add this line
      ), // Add this line
    ); // A
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    for (final controller in _animationControllers) { // Add this line
      controller.dispose(); // Add this line
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<RadioPlayerBloc, RadioPlayerState>(
              bloc: radioPlayerBloc,
              builder: (context, state) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RotationTransition(
                      turns: _animation,
                      child: const Image(
                        image: AssetImage('assets/icons/icon.png'),
                        width: 250,
                        height: 250,
                      ),
                    ),


                    const SizedBox(height: 10,),
                    _buildRadioPlayer(state),
                    const SizedBox(height: 10,),
                    SizedBox(
                      height:100,
                      child: Equalizer(
                        animationControllers: _animationControllers,
                        numBars: 10,
                        barWidth: 15,
                        barHeight: 100,
                        barColor: Colors.black,
                        animationDuration: const Duration(milliseconds: 500),
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRadioPlayer(RadioPlayerState state) {
    switch (state.runtimeType) {
      case RadioPlayerEmpty:
      case RadioPlayerStop:
      _animationController.stop();
      for (final controller in _animationControllers) { // Modify this line
        controller.stop();
      }
        return ElevatedButton(
          onPressed: () {
            _animationController.repeat();
            for (final controller in _animationControllers) { // Modify this line
              controller.repeat(reverse: true);
            }
            radioPlayerBloc.add(const OnPlayRadio());
          },
          child: const Text('Play'),
        );
      case RadioPlayerPlay:
        _animationController.repeat();
        for (final controller in _animationControllers) { // Modify this line
          controller.repeat(reverse: true);
        }
        return ElevatedButton(
          onPressed: () {
            _animationController.stop();
            for (final controller in _animationControllers) { // Modify this line
              controller.stop();
            }
            radioPlayerBloc.add(const OnStopRadio());
          },
          child: const Text('Stop'),
        );
      case RadioPlayerLoading:
        return const CircularProgressIndicator();
      case RadioPlayerError:
        return AlertDialog(
          title: const Text('Error'),
          content: Text((state as RadioPlayerError).message),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      default:
        return Container();
    }
  }
}
