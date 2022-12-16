import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radio/presentation/bloc/radio_player_bloc/radio_player_bloc.dart';
import 'package:radio/presentation/bloc/radio_player_bloc/radio_player_event.dart';
import 'package:radio/presentation/bloc/radio_player_bloc/radio_player_state.dart';

class RadioPage extends StatefulWidget {
  const RadioPage({super.key});

  @override
  _RadioPageState createState() => _RadioPageState();
}

class _RadioPageState extends State<RadioPage> {
  late RadioPlayerBloc radioPlayerBloc;

  @override
  void initState() {
    radioPlayerBloc = context.read<RadioPlayerBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocConsumer<RadioPlayerBloc, RadioPlayerState>(
              bloc: radioPlayerBloc,
              listener: (context, state) {
                // handle state changes that don't affect the UI
              },
              buildWhen: (previous, current) {
                // only rebuild the UI when the state changes that affect it
                return current is RadioPlayerEmpty ||
                    current is RadioPlayerStop ||
                    current is RadioPlayerPlay ||
                    current is RadioPlayerLoading ||
                    current is RadioPlayerError;
              },
              builder: (context, state) {
                return _buildRadioPlayer(state);
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
        return ElevatedButton(
          onPressed: () => radioPlayerBloc.add(const OnPlayRadio()),
          child: const Text('Play'),
        );
      case RadioPlayerPlay:
        return ElevatedButton(
            onPressed: () => radioPlayerBloc.add(const OnStopRadio()),
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
