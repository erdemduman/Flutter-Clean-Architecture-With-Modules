import 'package:core/core.dart';

import 'settings_event.dart';
import 'settings_state.dart';

class SettingsBloc extends BaseBloc<SettingsEvent, SettingsState> {
  final Logger _logger;

  SettingsBloc(this._logger) : super(SettingsState.create());
}
