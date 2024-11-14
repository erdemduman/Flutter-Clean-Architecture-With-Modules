import 'package:core/core.dart';

class StreamState extends BaseState {
  final StreamStatus status;

  const StreamState._({
    required this.status,
  });

  StreamState copyWith({
    StreamStatus? status,
  }) {
    return StreamState._(
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [status];

  factory StreamState.create() => const StreamState._(
        status: StreamStatus.initial,
      );
}

enum StreamStatus { initial, error }
