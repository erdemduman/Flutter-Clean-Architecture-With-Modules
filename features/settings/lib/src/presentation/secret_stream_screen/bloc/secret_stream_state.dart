import 'package:core/core.dart';

class SecretStreamState extends BaseState {
  final SecretStreamStatus status;

  const SecretStreamState._({
    required this.status,
  });

  SecretStreamState copyWith({
    SecretStreamStatus? status,
  }) {
    return SecretStreamState._(
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [status];

  factory SecretStreamState.create() => const SecretStreamState._(
        status: SecretStreamStatus.initial,
      );
}

enum SecretStreamStatus { initial }
