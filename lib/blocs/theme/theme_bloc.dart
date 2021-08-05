import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:movie_list/config/themes.dart';
import 'package:movie_list/repositories/repositories.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  DatabaseRepository _databaseRepository;
  ThemeBloc({@required DatabaseRepository databaseRepository})
      : _databaseRepository = databaseRepository,
        super(ThemeState.light()) {
    add(GetTheme());
  }

  @override
  Stream<ThemeState> mapEventToState(
    ThemeEvent event,
  ) async* {
    if (event is ThemeChanged) {
      yield* _mapThemeChangedToState(event);
    } else if (event is GetTheme) {
      yield* _mapGetThemeToState();
    }
  }

  Stream<ThemeState> _mapThemeChangedToState(ThemeChanged event) async* {
    _databaseRepository.addTheme(themeData: event.theme);
    yield event.theme == Themes.lightTheme
        ? ThemeState.light()
        : ThemeState.dark();
  }

  Stream<ThemeState> _mapGetThemeToState() async* {
    ThemeData theme = _databaseRepository.getTheme();
    yield theme == Themes.lightTheme ? ThemeState.light() : ThemeState.dark();
  }
}
