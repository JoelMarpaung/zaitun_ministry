// ignore_for_file: library_private_types_in_public_api

import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radio/presentation/bloc/radio_player_bloc/radio_player_bloc.dart';
import 'package:radio/presentation/bloc/radio_player_bloc/radio_player_event.dart';
import 'package:radio/presentation/bloc/radio_player_bloc/radio_player_state.dart';
import '../widgets/equilizer.dart';
import 'package:animated_background/animated_background.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class RadioPage extends StatefulWidget {
  const RadioPage({super.key});

  @override
  _RadioPageState createState() => _RadioPageState();
}

class _RadioPageState extends State<RadioPage> with TickerProviderStateMixin {
  late RadioPlayerBloc radioPlayerBloc;
  late AnimationController _animationController;
  late Animation<double> _animation;
  late List<AnimationController> _animationControllers;
  late AnimationController _animationController2;

  @override
  void initState() {
    radioPlayerBloc = context.read<RadioPlayerBloc>();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController);
    _animationControllers = List.generate(
      // Add this line
      20, // Add this line
      (index) => AnimationController(
        // Add this line
        vsync: this, // Add this line
        duration: Duration(
            milliseconds: Random().nextInt(1000) + 1000), // Add this line
      ), // Add this line
    ); // A

    _animationController2 =
        AnimationController(vsync: this, duration: const Duration(seconds: 5));
    _animationController2.repeat();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _animationController2.dispose();
    for (final controller in _animationControllers) {
      // Add this line
      controller.dispose(); // Add this line
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            return AnimatedBackground(
              behaviour: RectanglesBehaviour(),
              vsync: this,
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BlocBuilder<RadioPlayerBloc, RadioPlayerState>(
                        bloc: radioPlayerBloc,
                        builder: (context, state) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  height: 150,
                                ),
                                Stack(
                                  children: [
                                    RotationTransition(
                                      turns: _animation,
                                      child: const Image(
                                        image: AssetImage(
                                            'assets/icons/icon_circle.png'),
                                        width: 180,
                                        height: 180,
                                      ),
                                    ),
                                    // Add the CustomPaint widget here
                                    CustomPaint(
                                      painter: _CirclePainter(
                                        animation:
                                            _animation, // Use the same animation here
                                      ),
                                      size: const Size(180, 180),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                _buildRadioPlayer(state),
                                const SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  height: 80,
                                  child: Equalizer(
                                    animationControllers: _animationControllers,
                                    numBars: 20,
                                    barWidth: 5,
                                    barHeight: 100,
                                    barColor: Colors.blue.shade900,
                                    animationDuration:
                                        const Duration(milliseconds: 500),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          height: 160,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.lightBlue.shade900.withOpacity(0.9),
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(60),
                  bottomRight: Radius.circular(60)),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black,
                  offset: Offset(1.0, 1.0), //(x,y)
                  blurRadius: 50.0,
                ),
              ],
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 15,),
                  Text(
                    'Radio Zaitun',
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  Text(
                    'Suara Kebenaran',
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    '105.8 FM Balige',
                    style: Theme.of(context).textTheme.headline3,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRadioPlayer(RadioPlayerState state) {
    switch (state.runtimeType) {
      case RadioPlayerEmpty:
      case RadioPlayerStop:
        _animationController.stop();
        for (final controller in _animationControllers) {
          // Modify this line
          controller.stop();
        }
        return IconButton(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          onPressed: () async {
            var isConnected = await (Connectivity().checkConnectivity());
            if (isConnected != ConnectivityResult.none) {
              _animationController.repeat();
              for (final controller in _animationControllers) {
                controller.repeat(reverse: true);
              }
              radioPlayerBloc.add(const OnPlayRadio());
            } else {
              showDialog(
                context: context,
                builder: (context) => CupertinoAlertDialog(
                  title: const Text('Error'),
                  content: const Text('No internet connection'),
                  actions: [
                    CupertinoDialogAction(
                      child: const Text('Close'),
                      onPressed: () => Navigator.of(context).pop(true),
                    ),
                  ],
                ),
              );
            }
          },
          iconSize: 100,
          icon: Icon(
            Icons.play_circle,
            color: Colors.indigo.shade900,
          ),
        );
      case RadioPlayerPlay:
        _animationController.repeat();
        for (final controller in _animationControllers) {
          // Modify this line
          controller.repeat(reverse: true);
        }
        return IconButton(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          onPressed: () {
            _animationController.stop();
            for (final controller in _animationControllers) {
              // Modify this line
              controller.stop();
            }
            radioPlayerBloc.add(const OnStopRadio());
          },
          iconSize: 100,
          icon: Icon(
            Icons.stop_circle,
            color: Colors.indigo.shade900,
          ),
        );
      case RadioPlayerLoading:
        return const CircularProgressIndicator();
      case RadioPlayerError:
        return CupertinoAlertDialog(
          title: const Text('Error'),
          content: Text((state as RadioPlayerError).message),
          actions: [
            CupertinoDialogAction(
              child: const Text('Close'),
              onPressed: () => Navigator.of(context).pop(true),
            ),
          ],
        );
      default:
        return Container();
    }
  }
}

class _CirclePainter extends CustomPainter {
  _CirclePainter({
    required this.animation,
  }) : super(repaint: animation);

  final Animation<double> animation;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.brown.shade300
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width, size.height) / 2;

    final path = Path();
    final startAngle = -animation.value *
        2 *
        pi; // Use the negative value of the animation here
    const arcAngle = 2 * pi;

    // // Add a loop here
    for (double i = startAngle; i < startAngle + arcAngle; i += pi / 10) {
      path.moveTo(center.dx + radius * cos(i), center.dy + radius * sin(i));
      path.lineTo(center.dx + radius * cos(i + pi / 5),
          center.dy + radius * sin(i + pi / 5));
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_CirclePainter oldDelegate) {
    return false;
  }
}
