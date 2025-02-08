import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

import '../base_bloc.dart';
import 'language_event.dart';
import 'language_state.dart';

class LanguageBloc extends BaseBloc<LanguageEvent, LanguageState> {
  final Logger _logger;

  LanguageBloc(this._logger) : super(LanguageState.create()) {
    on<ChangeLanguageEvent>(_changeLanguage);
  }

  void _changeLanguage(ChangeLanguageEvent event, Emitter<LanguageState> emit) {
    _logger.i("Language changed to: ${event.language}!");
    emit(state.copyWith(language: event.language));
  }
}
