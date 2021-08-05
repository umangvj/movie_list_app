import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_list/config/gradients.dart';
import 'package:movie_list/helper/image_helper.dart';
import 'package:movie_list/models/models.dart';
import 'package:movie_list/repositories/repositories.dart';
import 'package:movie_list/screens/edit_movie/cubit/edit_movie_cubit.dart';
import 'package:movie_list/widgets/widgets.dart';

class EditMovieArgs {
  int index;
  Movie movie;
  EditMovieArgs({@required this.movie, @required this.index});
}

class EditMovieScreen extends StatelessWidget {
  static const String routeName = '/editMovie';

  static Route route({@required EditMovieArgs args}) {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => BlocProvider<EditMovieCubit>(
        create: (context) => EditMovieCubit(
          databaseRepository: context.read<DatabaseRepository>(),
          movie: args.movie,
          index: args.index,
        ),
        child: EditMovieScreen(),
      ),
    );
  }

  EditMovieScreen({Key key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditMovieCubit, EditMovieState>(
      listener: (context, state) {
        if (state.status == EditMovieStatus.error) {
          showDialog(
            context: context,
            builder: (context) => ErrorDialog(content: state.failure.message),
          );
        } else if (state.status == EditMovieStatus.success) {
          _formKey.currentState.reset();
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 1),
              content: Text('Movie Edited!'),
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 25.0, horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (state.status == EditMovieStatus.submitting)
                    LinearProgressIndicator(),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Theme.of(context).primaryColor,
                      size: 28.0,
                    ),
                  ),
                  Text(
                    'Edit Movie',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 25.0,
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  MovieTile(
                    gradient: Gradients.pinkGradient,
                    movieName: state.movieName,
                    director: state.director,
                    imagePath: state.photo != null ? state.photo.path : '',
                    otherChild: SizedBox(),
                  ),
                  SizedBox(height: 20.0),
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextFormField(
                          style: TextStyle(fontSize: 16.0),
                          decoration: InputDecoration(
                            labelText: 'Movie Name',
                          ),
                          textCapitalization: TextCapitalization.words,
                          validator: (input) =>
                              input.trim().isEmpty && state.movieName.isEmpty
                                  ? 'Please enter a Movie Name'
                                  : null,
                          onChanged: (value) => context
                              .read<EditMovieCubit>()
                              .movieNameChanged(value),
                        ),
                        const SizedBox(height: 15.0),
                        TextFormField(
                          style: const TextStyle(fontSize: 16.0),
                          decoration: InputDecoration(
                            labelText: 'Director',
                          ),
                          textCapitalization: TextCapitalization.words,
                          validator: (input) =>
                              input.trim().isEmpty && state.director.isEmpty
                                  ? 'Please enter Director\'s Name'
                                  : null,
                          onChanged: (value) => context
                              .read<EditMovieCubit>()
                              .directorChanged(value),
                        ),
                        SizedBox(height: 15.0),
                        OutlinedButton(
                          onPressed: () async {
                            File photo = await ImageHelper.pickImageFromGallery(
                              context: context,
                            );
                            context.read<EditMovieCubit>().posterChanged(photo);
                          },
                          child: Text(
                            state.photo == null
                                ? 'Select Movie Poster'
                                : 'Poster selected! Tap to change.',
                          ),
                          style: Theme.of(context).outlinedButtonTheme.style,
                        ),
                        const SizedBox(height: 30.0),
                        ElevatedButton(
                          onPressed: () {
                            _submitForm(
                              context,
                              state.status == EditMovieStatus.submitting,
                            );
                          },
                          child: Text(
                            'Edit Movie',
                            style: const TextStyle(fontSize: 18.0),
                          ),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 16.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _submitForm(BuildContext context, bool isSubmitting) {
    if (_formKey.currentState.validate() && !isSubmitting) {
      context.read<EditMovieCubit>().editMovie();
    }
  }
}
