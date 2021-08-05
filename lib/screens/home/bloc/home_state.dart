part of 'home_bloc.dart';

enum HomeStatus { initial, loading, loaded, error }

class HomeState extends Equatable {
  final List<Movie> movies;
  final HomeStatus status;
  final Failure failure;

  const HomeState({
    @required this.movies,
    @required this.status,
    @required this.failure,
  });

  factory HomeState.initial() {
    return HomeState(
      movies: [],
      status: HomeStatus.initial,
      failure: const Failure(),
    );
  }

  @override
  List<Object> get props => [movies, status, failure];

  HomeState copyWith({
    List<Movie> movies,
    HomeStatus status,
    Failure failure,
  }) {
    return HomeState(
      movies: movies ?? this.movies,
      status: status ?? this.status,
      failure: failure ?? this.failure,
    );
  }
}
