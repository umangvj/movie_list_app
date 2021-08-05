import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:movie_list/config/custom_router.dart';
import 'package:movie_list/models/models.dart';
import 'package:movie_list/repositories/repositories.dart';
import 'package:movie_list/screens/screens.dart';
import 'package:path_provider/path_provider.dart';
import 'blocs/blocs.dart';
import 'blocs/simple_bloc_observer.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'config/paths.dart';
import 'config/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final dir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(dir.path);
  Hive.registerAdapter(MovieAdapter());
  await Hive.openBox(Paths.boxName);
  await Hive.openBox(Paths.boxTheme);
  EquatableConfig.stringify = kDebugMode;
  Bloc.observer = SimpleBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(
          create: (_) => AuthRepository(),
        ),
        RepositoryProvider<DatabaseRepository>(
          create: (_) => DatabaseRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) =>
                AuthBloc(authRepository: context.read<AuthRepository>()),
          ),
          BlocProvider(
            create: (context) => ThemeBloc(
              databaseRepository: context.read<DatabaseRepository>(),
            ),
          ),
        ],
        child: BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, state) {
            return MaterialApp(
              title: 'Movie List',
              debugShowCheckedModeBanner: false,
              theme: state.status == ThemeStatus.light
                  ? Themes.lightTheme
                  : Themes.darkTheme,
              initialRoute: SplashScreen.routeName,
              onGenerateRoute: CustomRouter.onGenerateRoute,
            );
          },
        ),
      ),
    );
  }
}
