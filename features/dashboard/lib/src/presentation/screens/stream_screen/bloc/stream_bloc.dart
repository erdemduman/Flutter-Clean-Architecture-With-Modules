import 'package:core/core.dart';
import 'stream_event.dart';
import 'stream_state.dart';

class StreamBloc extends BaseBloc<StreamEvent, StreamState> {
  final GetStoredRandomNumberUseCase _getStoredRandomNumberUseCase;
  final Logger _logger;

  StreamBloc(
    this._getStoredRandomNumberUseCase,
    this._logger,
  ) : super(StreamState.create()) {
    on<InitStreamBlocEvent>(_initStreamBloc);
    on<DisposeStreamBlocEvent>(_disposeStreamBloc);
  }

  @override
  void init({required BlocParameter parameter}) {
    _logger.d("Init");
    add(const InitStreamBlocEvent());
  }

  @override
  void dispose() {
    _logger.d("Dispose");
    add(const DisposeStreamBlocEvent());
  }

  Future<void> _initStreamBloc(
    InitStreamBlocEvent event,
    Emitter<StreamState> emit,
  ) async {}

  void _disposeStreamBloc(
    DisposeStreamBlocEvent event,
    Emitter<StreamState> emit,
  ) {}
}
