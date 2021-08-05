import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:movie_list/models/movie_model.dart';

abstract class BaseDatabaseRepository {
  Future<void> addMovie({Movie movie});
  List<Movie> getMovies();
  Stream<BoxEvent> getNewMovies();
  Future<void> editMovie({int index});
  Future<void> deleteMovie({int index});
  Future<void> addTheme({ThemeData themeData});
  ThemeData getTheme();
}
