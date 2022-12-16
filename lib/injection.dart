import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:just_audio/just_audio.dart';
import 'package:radio/data/datasources/radio_data_source.dart';
import 'package:radio/data/repositories/radio_repository_impl.dart';
import 'package:radio/domain/repositories/radio_repository.dart';
import 'package:radio/domain/usecases/get_data_radio.dart';
import 'package:radio/domain/usecases/play_radio.dart';
import 'package:radio/domain/usecases/stop_radio.dart';
import 'package:radio/presentation/bloc/radio_data_bloc/data_radio_bloc.dart';
import 'package:radio/presentation/bloc/radio_player_bloc/radio_player_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final locator = GetIt.instance;

Future<void> init() async {
  //bloc radio
  locator.registerFactory(
    () => DataRadioBloc(
      locator(),
      locator(),
    ),
  );

  locator.registerFactory(
    () => RadioPlayerBloc(
      locator(),
      locator(),
      locator(),
    ),
  );

  //usecases
  locator.registerLazySingleton(() => GetDataRadio(locator()));
  locator.registerLazySingleton(() => PlayRadio(locator()));
  locator.registerLazySingleton(() => StopRadio(locator()));

  //repository
  locator.registerLazySingleton<RadioRepository>(
      () => RadioRepositoryImpl(radioDataSource: locator()));

  //datasource
  locator.registerLazySingleton<RadioDataSource>(
      () => RadioDataSourceImpl(client: locator(), audioPlayer: locator()));

  //client http
  locator.registerLazySingleton(() => http.Client());

  //shared preferences
  final sharedPreferences = await SharedPreferences.getInstance();
  locator.registerLazySingleton(() => sharedPreferences);

  //audio player
  locator.registerLazySingleton(() => AudioPlayer());
}
