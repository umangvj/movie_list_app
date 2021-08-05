import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:movie_list/config/paths.dart';
import 'package:movie_list/config/themes.dart';
import 'package:movie_list/models/movie_model.dart';
import 'package:movie_list/repositories/repositories.dart';

class DatabaseRepository extends BaseDatabaseRepository {
  final moviesBox = Hive.box(Paths.boxName);
  final themeBox = Hive.box(Paths.boxTheme);

  DatabaseRepository();

  @override
  Future<void> addMovie({@required Movie movie}) async {
    await moviesBox.add(movie);
  }

  @override
  List<Movie> getMovies() {
    final fetchedMovies = moviesBox.values.toList();
    List<Movie> movies = List<Movie>.from(fetchedMovies);
    return movies;
  }

  @override
  Stream<BoxEvent> getNewMovies() {
    return moviesBox.watch();
  }

  @override
  Future<void> editMovie({@required int index, @required Movie movie}) async {
    await moviesBox.putAt(index, movie);
  }

  @override
  Future<void> deleteMovie({@required int index}) async {
    await moviesBox.deleteAt(index);
  }

  @override
  Future<void> addTheme({ThemeData themeData}) async {
    if (themeData == Themes.darkTheme)
      await themeBox.put('theme', 'dark');
    else
      await themeBox.put('theme', 'light');
  }

  @override
  ThemeData getTheme() {
    String theme = themeBox.get('theme', defaultValue: 'light').toString();
    if (theme == 'dark')
      return Themes.darkTheme;
    else
      return Themes.lightTheme;
  }
}
