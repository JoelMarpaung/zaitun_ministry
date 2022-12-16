import 'package:core/constants/urls.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radio/presentation/bloc/radio_player_bloc/radio_player_event.dart';
import 'package:radio/presentation/bloc/radio_player_bloc/radio_player_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../domain/usecases/play_radio.dart';
import '../../../domain/usecases/stop_radio.dart';

class RadioPlayerBloc extends Bloc<RadioPlayerEvent, RadioPlayerState> {
  final PlayRadio _playRadio;
  final StopRadio _stopRadio;
  final SharedPreferences _prefs;

  RadioPlayerBloc(this._playRadio, this._stopRadio, this._prefs)
      : super(RadioPlayerEmpty()) {
    on<OnPlayRadio>((event, emit)  {
      emit(RadioPlayerLoading());
      final url = _prefs.getString(streamPref);
      try {
        _playRadio.play(url);
      } catch (e) {
        emit(RadioPlayerError(e.toString()));
      } finally {
        emit(RadioPlayerPlay());
      }
    });

    on<OnStopRadio>((event, emit) {
      emit(RadioPlayerLoading());
      try{
        _stopRadio.stop();
      } catch (e) {
        emit(RadioPlayerError(e.toString()));
      } finally {
        emit(RadioPlayerStop());
      }
    });
  }
}
