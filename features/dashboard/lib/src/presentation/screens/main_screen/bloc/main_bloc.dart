import 'package:core/core.dart';

import 'main_event.dart';
import 'main_state.dart';

class MainBloc extends BaseBloc<MainEvent, MainState> {
  final Logger _logger;

  MainBloc(this._logger) : super(MainState.create());
}
