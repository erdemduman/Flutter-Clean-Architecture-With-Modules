import 'package:core/core.dart';

abstract class StreamEvent extends BaseEvent {
  const StreamEvent();
}

class InitStreamBlocEvent extends StreamEvent {
  const InitStreamBlocEvent();

  @override
  List<Object?> get props => [];
}

class DisposeStreamBlocEvent extends StreamEvent {
  const DisposeStreamBlocEvent();

  @override
  List<Object?> get props => [];
}
