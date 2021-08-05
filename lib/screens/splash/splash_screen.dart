import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_list/blocs/blocs.dart';
import 'package:movie_list/screens/screens.dart';

class SplashScreen extends StatelessWidget {
  static const String routeName = '/splash';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (_) => SplashScreen(),
    );
  }

  const SplashScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (prevState, state) {
        return prevState.status != state.status;
      },
      listener: (context, state) {
        if (state.status == AuthStatus.authenticated) {
          Navigator.of(context).pushNamed(HomeScreen.routeName);
        } else if (state.status == AuthStatus.unauthenticated) {
          Navigator.of(context).pushNamed(LoginScreen.routeName);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Text(
            ' Movie List',
            style: TextStyle(
              color: Colors.red[800],
              fontSize: 35.0,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.1,
              fontFamily: 'STIXTwoMath',
            ),
          ),
        ),
      ),
    );
  }
}
