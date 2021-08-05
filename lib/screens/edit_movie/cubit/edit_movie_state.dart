part of 'edit_movie_cubit.dart';

enum EditMovieStatus { initial, submitting, success, error }

class EditMovieState extends Equatable {
  final String movieName;
  final String director;
  final File photo;
  final EditMovieStatus status;
  final Failure failure;

  const EditMovieState({
    @required this.movieName,
    @required this.director,
    @required this.photo,
    @required this.status,
    @required this.failure,
  });

  bool get isFormValid => movieName.isNotEmpty && director.isNotEmpty;

  factory EditMovieState.initial() {
    return EditMovieState(
      movieName: '',
      director: '',
      photo: null,
      status: EditMovieStatus.initial,
      failure: const Failure(),
    );
  }

  @override
  List<Object> get props => [movieName, director, photo, status, failure];

  EditMovieState copyWith({
    String movieName,
    String director,
    File photo,
    EditMovieStatus status,
    Failure failure,
  }) {
    return EditMovieState(
      movieName: movieName ?? this.movieName,
      director: director ?? this.director,
      photo: photo ?? this.photo,
      status: status ?? this.status,
      failure: failure ?? this.failure,
    );
  }
}
