import '../base_event.dart';

abstract class WebsocketEvent extends BaseEvent {
  const WebsocketEvent();

  @override
  List<Object?> get props => [];
}

class FetchNumberStreamEvent extends WebsocketEvent {
  final int maxLimit;

  const FetchNumberStreamEvent({
    required this.maxLimit,
  });

  @override
  List<Object?> get props => [maxLimit];
}

class StopNumberStreamEvent extends WebsocketEvent {
  const StopNumberStreamEvent();

  @override
  List<Object?> get props => [];
}
