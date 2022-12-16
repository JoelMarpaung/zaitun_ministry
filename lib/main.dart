import 'package:core/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radio/presentation/bloc/radio_data_bloc/data_radio_bloc.dart';
import 'package:radio/presentation/bloc/radio_player_bloc/radio_player_bloc.dart';
import 'package:zaitun_ministry/injection.dart' as di;
import 'package:zaitun_ministry/pages/homepage.dart';
import 'package:zaitun_ministry/pages/splashscreen.dart';
import 'package:core/common/utils.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => di.locator<DataRadioBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<RadioPlayerBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Radio Zaitun Ministry',
        home: const SplashScreen(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case splashScreenPage:
              return MaterialPageRoute(builder: (_) => const SplashScreen());
            case homePage:
              return MaterialPageRoute(builder: (_) => const HomePage());
            default:
              return MaterialPageRoute(
                builder: (_) {
                  return const Scaffold(
                    body: Center(
                      child: Text('Page not found :('),
                    ),
                  );
                },
              );
          }
        },
      ),
    );
  }
}
