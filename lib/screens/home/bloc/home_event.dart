part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class HomeFetchMovies extends HomeEvent {}

class HomeNewMovies extends HomeEvent {
  final List<Movie> movies;

  HomeNewMovies(this.movies);

  @override
  List<Object> get props => [movies];
}
