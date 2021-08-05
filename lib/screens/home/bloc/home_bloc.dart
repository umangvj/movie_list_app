import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:movie_list/models/models.dart';
import 'package:movie_list/repositories/repositories.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final DatabaseRepository _databaseRepository;

  StreamSubscription<BoxEvent> _moviesSubscription;

  HomeBloc({@required DatabaseRepository databaseRepository})
      : _databaseRepository = databaseRepository,
        super(HomeState.initial());

  @override
  Future<void> close() {
    _moviesSubscription.cancel();
    return super.close();
  }

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is HomeFetchMovies) {
      yield* _mapFetchMoviesToState();
    } else if (event is HomeNewMovies) {
      yield* _mapNewMoviesToState(event);
    }
  }

  Stream<HomeState> _mapFetchMoviesToState() async* {
    yield state.copyWith(status: HomeStatus.loading);
    try {
      final movies = _databaseRepository.getMovies();
      _moviesSubscription?.cancel();
      _moviesSubscription =
          _databaseRepository.getNewMovies().listen((movie) async {
        final allMovies = _databaseRepository.getMovies();
        add(HomeNewMovies(allMovies));
      });
      yield state.copyWith(movies: movies, status: HomeStatus.loaded);
    } catch (err) {
      yield state.copyWith(
        status: HomeStatus.error,
        failure: const Failure(
          message:
              'Unable to load your list. Please try again after some time.',
        ),
      );
    }
  }

  Stream<HomeState> _mapNewMoviesToState(HomeNewMovies event) async* {
    yield state.copyWith(movies: event.movies);
  }
}
