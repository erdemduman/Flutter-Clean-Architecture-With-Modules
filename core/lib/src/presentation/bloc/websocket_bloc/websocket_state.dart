import 'package:core/core.dart';

class WebsocketState extends BaseState {
  final WebSocketStatus status;

  const WebsocketState._({
    required this.status,
  });

  WebsocketState copyWith({
    WebSocketStatus? status,
  }) {
    return WebsocketState._(
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [status];

  factory WebsocketState.create() => const WebsocketState._(
        status: WebSocketStatus.initial,
      );
}

enum WebSocketStatus { initial, success, error }
