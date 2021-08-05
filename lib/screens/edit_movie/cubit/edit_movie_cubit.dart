import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:movie_list/models/models.dart';
import 'package:movie_list/repositories/repositories.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

part 'edit_movie_state.dart';

class EditMovieCubit extends Cubit<EditMovieState> {
  final DatabaseRepository _databaseRepository;
  final Movie _movie;
  final int _index;
  EditMovieCubit(
      {@required DatabaseRepository databaseRepository,
      @required Movie movie,
      @required int index})
      : _databaseRepository = databaseRepository,
        _movie = movie,
        _index = index,
        super(EditMovieState.initial()) {
    emit(
      state.copyWith(
        movieName: _movie.movieName,
        director: _movie.director,
        photo: _movie.image.isNotEmpty ? File(_movie.image) : null,
      ),
    );
  }

  void movieNameChanged(String value) {
    emit(state.copyWith(movieName: value, status: EditMovieStatus.initial));
  }

  void directorChanged(String value) {
    emit(state.copyWith(director: value, status: EditMovieStatus.initial));
  }

  void posterChanged(File photo) {
    emit(state.copyWith(photo: photo, status: EditMovieStatus.initial));
  }

  void editMovie() async {
    if (!state.isFormValid || state.status == EditMovieStatus.submitting)
      return;
    emit(state.copyWith(status: EditMovieStatus.submitting));
    try {
      String imagePath = '';
      if (state.photo != null) {
        final appDir = await getApplicationDocumentsDirectory();
        print('app dir is $appDir');
        final fileName = path.basename(state.photo.path);
        final savedImage = await state.photo.copy('${appDir.path}/$fileName');
        imagePath = savedImage.path;
      }
      Movie movie = Movie(
        movieName: state.movieName,
        director: state.director,
        image: imagePath,
        date: DateTime.now(),
      );
      _databaseRepository.editMovie(movie: movie, index: _index);
      emit(state.copyWith(status: EditMovieStatus.success));
    } catch (err) {
      emit(
        state.copyWith(
          status: EditMovieStatus.error,
          failure: Failure(
            message: 'Unable to edit movie. Please try again after some time.',
          ),
        ),
      );
    }
  }
}
