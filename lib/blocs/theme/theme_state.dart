part of 'theme_bloc.dart';

enum ThemeStatus { light, dark }

class ThemeState extends Equatable {
  final ThemeData theme;
  final ThemeStatus status;

  const ThemeState({this.theme, this.status = ThemeStatus.light});

  factory ThemeState.light() =>
      ThemeState(theme: Themes.lightTheme, status: ThemeStatus.light);

  factory ThemeState.dark() =>
      ThemeState(theme: Themes.darkTheme, status: ThemeStatus.dark);

  @override
  List<Object> get props => [theme, status];
}
