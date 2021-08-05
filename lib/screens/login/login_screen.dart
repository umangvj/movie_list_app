import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_list/repositories/auth/auth_repository.dart';
import 'package:movie_list/widgets/widgets.dart';

import 'cubit/login_cubit.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = '/login';

  static Route route() {
    return PageRouteBuilder(
      settings: const RouteSettings(name: routeName),
      transitionDuration: const Duration(seconds: 0),
      pageBuilder: (context, _, __) => BlocProvider<LoginCubit>(
        create: (context) =>
            LoginCubit(authRepository: context.read<AuthRepository>()),
        child: LoginScreen(),
      ),
    );
  }

  const LoginScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async => false,
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state.status == LoginStatus.error) {
            showDialog(
              context: context,
              builder: (context) => ErrorDialog(content: state.failure.message),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: Stack(
              children: [
                Column(
                  children: [
                    Container(
                      height: size.height / 3,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Color(0xFF4A8299),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: size.height,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Color(0xFF315E71),
                        ),
                      ),
                    ),
                    if (state.status == LoginStatus.submitting)
                      LinearProgressIndicator(minHeight: 6),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 50.0),
                      height: 0.54 * size.height,
                      width: double.infinity,
                      child: Image.asset(
                        'assets/images/watch movie.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 50.0),
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: ElevatedButton(
                        onPressed: () {
                          _login(
                              context, state.status == LoginStatus.submitting);
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red[800],
                          padding: EdgeInsets.symmetric(vertical: 10.0),
                        ),
                        child: Text(
                          'Login with Google',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _login(BuildContext context, bool isSubmitting) {
    if (!isSubmitting) {
      context.read<LoginCubit>().login();
    }
  }
}
