import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:radio/data/datasources/radio_data_source.dart';
import 'package:radio/data/repositories/radio_repository_impl.dart';
import 'package:radio/domain/repositories/radio_repository.dart';
import 'package:radio/domain/usecases/get_data_radio.dart';
import 'package:radio/presentation/bloc/data_radio_bloc/data_radio_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final locator = GetIt.instance;

void init() {
  //bloc radio
  locator.registerFactory(
    () => DataRadioBloc(
      locator(),
    ),
  );
  
  //shared preferences
  //locator.registerLazySingletonAsync<SharedPreferences>(() async => await SharedPreferences.getInstance());
  locator.registerSingletonAsync<SharedPreferences>(
          () => SharedPreferences.getInstance());
  //usecases
  locator.registerLazySingleton(() => GetDataRadio(locator()));

  //repository
  locator.registerLazySingleton<RadioRepository>(() => RadioRepositoryImpl(radioDataSource: locator()));

  //datasource
  locator.registerLazySingleton<RadioDataSource>(() => RadioDataSourceImpl(client: locator()));

  //client http
  locator.registerLazySingleton(() => http.Client());
  
}
