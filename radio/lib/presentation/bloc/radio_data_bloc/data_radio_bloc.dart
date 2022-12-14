import 'package:core/constants/urls.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../domain/usecases/get_data_radio.dart';
import 'data_radio_event.dart';
import 'data_radio_state.dart';

class DataRadioBloc extends Bloc<RadioEvent, RadioState> {
  final GetDataRadio _dataRadio;
  final SharedPreferences _prefs;

  DataRadioBloc(this._dataRadio, this._prefs) : super(RadioEmpty()) {
    on<OnFetchDataRadio>((event, emit) async {
      emit(RadioLoading());
      final result = await _dataRadio.execute();
      result.fold(
        (failure) async {
          await _prefs.setString(streamPref, streamUrl);
        },
        (data) async {
          await _prefs.setString(streamPref, data.url);
        },
      );
      emit(RadioComplete());
    });
  }
}
