import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:movie_list/models/models.dart';
import 'package:movie_list/repositories/repositories.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

part 'add_movie_state.dart';

class AddMovieCubit extends Cubit<AddMovieState> {
  final DatabaseRepository _databaseRepository;
  AddMovieCubit({@required DatabaseRepository databaseRepository})
      : _databaseRepository = databaseRepository,
        super(AddMovieState.initial());

  void movieNameChanged(String value) {
    emit(state.copyWith(movieName: value, status: AddMovieStatus.initial));
  }

  void directorChanged(String value) {
    emit(state.copyWith(director: value, status: AddMovieStatus.initial));
  }

  void posterChanged(File photo) {
    emit(state.copyWith(photo: photo, status: AddMovieStatus.initial));
  }

  void addMovie() async {
    if (!state.isFormValid || state.status == AddMovieStatus.submitting) return;
    emit(state.copyWith(status: AddMovieStatus.submitting));
    try {
      String imagePath = '';
      if (state.photo != null) {
        final appDir = await getApplicationDocumentsDirectory();
        print('app dir is $appDir');
        final fileName = path.basename(state.photo.path);
        final savedImage = await state.photo.copy('${appDir.path}/$fileName');
        imagePath = savedImage.path;
      }
      print(imagePath);
      Movie movie = Movie(
        movieName: state.movieName,
        director: state.director,
        image: imagePath,
        date: DateTime.now(),
      );
      _databaseRepository.addMovie(movie: movie);
      emit(state.copyWith(status: AddMovieStatus.success));
    } catch (err) {
      emit(
        state.copyWith(
          status: AddMovieStatus.error,
          failure: Failure(
            message: 'Unable to add movie. Please try again after some time.',
          ),
        ),
      );
    }
  }

  void reset() {
    emit(AddMovieState.initial());
  }
}
