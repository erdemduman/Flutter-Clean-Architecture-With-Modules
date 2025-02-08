import 'package:core/core.dart';

class SettingsState extends BaseState {
  final SettingsStatus status;

  const SettingsState._({required this.status});

  SettingsState copyWith({SettingsStatus? status}) {
    return SettingsState._(status: status ?? this.status);
  }

  @override
  List<Object?> get props => [status];

  factory SettingsState.create() => const SettingsState._(
        status: SettingsStatus.initial,
      );
}

enum SettingsStatus { initial }
