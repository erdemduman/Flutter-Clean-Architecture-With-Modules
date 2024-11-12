import '../base_event.dart';

abstract class WebsocketEvent extends BaseEvent {
  const WebsocketEvent();

  @override
  List<Object?> get props => [];
}

class FetchNumberStreamEvent extends WebsocketEvent {
  final int maxLimit;
  final bool isRunning;

  const FetchNumberStreamEvent({
    required this.maxLimit,
    required this.isRunning,
  });

  @override
  List<Object?> get props => [maxLimit, isRunning];
}
