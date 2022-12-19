import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:info/data/datasources/info_data_source.dart';
import 'package:info/data/repositories/info_repository_impl.dart';
import 'package:info/domain/repositories/info_repository.dart';
import 'package:info/domain/usecases/get_data_info.dart';
import 'package:info/presentation/bloc/info_data_bloc/info_data_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:radio/data/datasources/radio_data_source.dart';
import 'package:radio/data/repositories/radio_repository_impl.dart';
import 'package:radio/domain/repositories/radio_repository.dart';
import 'package:radio/domain/usecases/get_data_radio.dart';
import 'package:radio/domain/usecases/play_radio.dart';
import 'package:radio/domain/usecases/stop_radio.dart';
import 'package:radio/presentation/bloc/radio_data_bloc/data_radio_bloc.dart';
import 'package:radio/presentation/bloc/radio_player_bloc/radio_player_bloc.dart';
import 'package:schedule/data/datasources/schedule_data_source.dart';
import 'package:schedule/data/repositories/schedule_repository_impl.dart';
import 'package:schedule/domain/repositories/schedule_repository.dart';
import 'package:schedule/domain/usecases/get_data_schedule.dart';
import 'package:schedule/presentation/bloc/schedule_data_bloc/schedule_data_bloc.dart';
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

  locator.registerFactory(
    () => ScheduleDataBloc(
      locator(),
    ),
  );

  locator.registerFactory(
    () => InfoDataBloc(
      locator(),
    ),
  );

  //usecases
  locator.registerLazySingleton(() => GetDataRadio(locator()));
  locator.registerLazySingleton(() => PlayRadio(locator()));
  locator.registerLazySingleton(() => StopRadio(locator()));
  locator.registerLazySingleton(() => GetDataSchedule(locator()));
  locator.registerLazySingleton(() => GetDataInfo(locator()));

  //repository
  locator.registerLazySingleton<RadioRepository>(
      () => RadioRepositoryImpl(radioDataSource: locator()));
  locator.registerLazySingleton<ScheduleRepository>(
      () => ScheduleRepositoryImpl(scheduleDataSource: locator()));
  locator.registerLazySingleton<InfoRepository>(
      () => InfoRepositoryImpl(infoDataSource: locator()));

  //datasource
  locator.registerLazySingleton<RadioDataSource>(
      () => RadioDataSourceImpl(client: locator(), audioPlayer: locator()));
  locator.registerLazySingleton<ScheduleDataSource>(
      () => ScheduleDataSourceImpl(client: locator()));
  locator.registerLazySingleton<InfoDataSource>(
      () => InfoDataSourceImpl(client: locator()));

  //client http
  locator.registerLazySingleton(() => http.Client());

  //shared preferences
  final sharedPreferences = await SharedPreferences.getInstance();
  locator.registerLazySingleton(() => sharedPreferences);

  //audio player
  locator.registerLazySingleton(() => AudioPlayer());
}
