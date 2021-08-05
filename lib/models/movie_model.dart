import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

part 'movie_model.g.dart';

@HiveType(typeId: 0)
class Movie extends Equatable {
  @HiveField(0)
  final String movieName;

  @HiveField(1)
  final String director;

  @HiveField(2)
  final String image;

  @HiveField(3)
  final DateTime date;

  const Movie({
    @required this.movieName,
    @required this.director,
    this.image,
    @required this.date,
  });

  factory Movie.initial() {
    return Movie(
      movieName: '',
      director: '',
      image: '',
      date: DateTime.now(),
    );
  }

  @override
  List<Object> get props => [movieName, director, image, date];

  Movie copyWith({
    String movieName,
    String director,
    String image,
    DateTime date,
  }) {
    return Movie(
        movieName: movieName ?? this.movieName,
        director: director ?? this.director,
        image: image ?? this.image,
        date: date ?? this.date);
  }
}
