part of 'theme_bloc.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object> get props => [];
}

class ThemeChanged extends ThemeEvent {
  final ThemeData theme;

  const ThemeChanged({this.theme});

  @override
  List<Object> get props => [theme];
}

class GetTheme extends ThemeEvent {}
