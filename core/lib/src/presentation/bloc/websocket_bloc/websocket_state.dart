import 'package:core/core.dart';

class WebsocketState extends BaseState {
  final String number;
  final bool isRunning;
  final WebSocketStatus status;

  const WebsocketState._({
    required this.number,
    required this.isRunning,
    required this.status,
  });

  WebsocketState copyWith({
    String? number,
    bool? isRunning,
    WebSocketStatus? status,
  }) {
    return WebsocketState._(
      number: number ?? this.number,
      isRunning: isRunning ?? this.isRunning,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [number, isRunning, status];

  factory WebsocketState.create() => const WebsocketState._(
        number: "",
        isRunning: false,
        status: WebSocketStatus.initial,
      );
}

enum WebSocketStatus { initial, error }
