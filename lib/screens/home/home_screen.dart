import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_list/blocs/blocs.dart';
import 'package:movie_list/config/gradients.dart';
import 'package:movie_list/config/themes.dart';
import 'package:movie_list/models/models.dart';
import 'package:movie_list/repositories/repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_list/screens/screens.dart';
import 'package:movie_list/widgets/widgets.dart';

import 'bloc/home_bloc.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/home';

  static Route route() {
    return PageRouteBuilder(
      settings: const RouteSettings(name: routeName),
      transitionDuration: const Duration(seconds: 0),
      pageBuilder: (_, __, ___) => BlocProvider(
        create: (context) => HomeBloc(
          databaseRepository: context.read<DatabaseRepository>(),
        )..add(HomeFetchMovies()),
        child: HomeScreen(),
      ),
    );
  }

  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return Scaffold(
            // backgroundColor: Colors.white,
            body: _buildBody(context, state),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AddMovieScreen.routeName);
              },
              child: const Icon(Icons.add, color: Colors.white),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context, HomeState state) {
    switch (state.status) {
      case HomeStatus.loading:
        return Column(
          children: [
            introContainer(context),
            SizedBox(height: 100.0),
            Center(child: CircularProgressIndicator()),
          ],
        );
      case HomeStatus.initial:
        return Column(
          children: [
            introContainer(context),
            SizedBox(height: 80.0),
            Center(child: CircularProgressIndicator()),
          ],
        );
      default:
        return CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: introContainer(context),
            ),
            state.movies.length == 0
                ? SliverFillRemaining(
                    child: Center(
                      child: Text(
                        'Tap \'+\' icon to add a new Movie.',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  )
                : SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, int index) {
                        int num = state.movies.length - 1 - index;
                        final movie = state.movies[num];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 3.0,
                            horizontal: 15.0,
                          ),
                          child: MovieTile(
                            gradient: getGradient(index),
                            movieName: movie.movieName,
                            director: movie.director,
                            imagePath: movie.image,
                            otherChild: otherChild(context, movie, num),
                          ),
                        );
                      },
                      childCount: state.movies.length,
                    ),
                  ),
            SliverToBoxAdapter(
              child: SizedBox(height: 80.0),
            ),
          ],
        );
    }
  }

  Row otherChild(BuildContext context, Movie movie, int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(EditMovieScreen.routeName,
                arguments: EditMovieArgs(movie: movie, index: index));
          },
          child: Icon(
            Icons.edit,
            color: Colors.white,
          ),
        ),
        SizedBox(width: 8.0),
        GestureDetector(
          onTap: () {
            print('delete');
            context.read<DatabaseRepository>().deleteMovie(index: index);
          },
          child: Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Container introContainer(BuildContext context) {
    return Container(
      height: 100.0,
      width: double.infinity,
      margin: EdgeInsets.fromLTRB(15.0, 30.0, 15.0, 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              BlocBuilder<ThemeBloc, ThemeState>(
                builder: (context, state) {
                  return Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      onPressed: () {
                        if (state.status == ThemeStatus.light) {
                          context
                              .read<ThemeBloc>()
                              .add(ThemeChanged(theme: Themes.darkTheme));
                        } else {
                          context
                              .read<ThemeBloc>()
                              .add(ThemeChanged(theme: Themes.lightTheme));
                        }
                      },
                      icon: state.status == ThemeStatus.light
                          ? Icon(Icons.light_mode)
                          : Icon(Icons.dark_mode),
                      alignment: Alignment.topRight,
                    ),
                  );
                },
              ),
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  onPressed: () {
                    context.read<AuthRepository>().logout();
                  },
                  icon: Icon(Icons.logout),
                  alignment: Alignment.topRight,
                ),
              ),
            ],
          ),
          FittedBox(
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Hello ',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  TextSpan(
                    text: context.read<AuthRepository>().username(),
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 30.0,
                    ),
                  ),
                ],
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  LinearGradient getGradient(int index) {
    switch (index) {
      case 0:
        return Gradients.pinkGradient;
      case 1:
        return Gradients.blueGradient;
      case 2:
        return Gradients.orangeGradient;
      case 3:
        return Gradients.greenGradient;
      case 4:
        return Gradients.purpleGradient;
      default:
        return Gradients.pinkGradient;
    }
  }
}
