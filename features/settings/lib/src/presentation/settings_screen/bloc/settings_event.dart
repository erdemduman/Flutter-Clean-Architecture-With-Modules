import 'package:core/core.dart';

abstract class SettingsEvent extends BaseEvent {
  const SettingsEvent();
}

class InitSettingsBlocEvent extends SettingsEvent {
  const InitSettingsBlocEvent();

  @override
  List<Object?> get props => [];
}
