part of 'add_movie_cubit.dart';

enum AddMovieStatus { initial, submitting, success, error }

class AddMovieState extends Equatable {
  final String movieName;
  final String director;
  final File photo;
  final AddMovieStatus status;
  final Failure failure;

  const AddMovieState({
    @required this.movieName,
    @required this.director,
    @required this.photo,
    @required this.status,
    @required this.failure,
  });

  bool get isFormValid => movieName.isNotEmpty && director.isNotEmpty;

  factory AddMovieState.initial() {
    return AddMovieState(
      movieName: '',
      director: '',
      photo: null,
      status: AddMovieStatus.initial,
      failure: const Failure(),
    );
  }

  @override
  List<Object> get props => [movieName, director, photo, status, failure];

  AddMovieState copyWith({
    String movieName,
    String director,
    File photo,
    AddMovieStatus status,
    Failure failure,
  }) {
    return AddMovieState(
      movieName: movieName ?? this.movieName,
      director: director ?? this.director,
      photo: photo ?? this.photo,
      status: status ?? this.status,
      failure: failure ?? this.failure,
    );
  }
}
