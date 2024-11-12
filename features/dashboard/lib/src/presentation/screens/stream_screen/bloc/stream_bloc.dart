import 'package:core/core.dart';
import 'stream_event.dart';
import 'stream_state.dart';

class StreamBloc extends BaseBloc<StreamEvent, StreamState> {
  final GetStoredRandomNumberUseCase _getStoredRandomNumberUseCase;
  final GetRandomNumberStreamUseCase _getRandomNumberStreamUseCase;
  final StopNumberGenerationUseCase _stopNumberGenerationUseCase;
  final Logger _logger;

  StreamBloc(
    this._getStoredRandomNumberUseCase,
    this._getRandomNumberStreamUseCase,
    this._stopNumberGenerationUseCase,
    this._logger,
  ) : super(StreamState.create()) {
    on<InitStreamBlocEvent>(_initStreamBloc);
    on<FetchNumberStreamEvent>(_fetchNumberStream, transformer: restartable());
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
  ) async {
    RandomNumberEntity entity = await _getStoredRandomNumberUseCase(
      parameter: UseCaseNoParameter(),
    );
    emit(state.copyWith(number: entity.number.toString()));
  }

  Future<void> _fetchNumberStream(
    FetchNumberStreamEvent event,
    Emitter<StreamState> emit,
  ) async {
    try {
      if (event.isRunning) {
        var stream = _getRandomNumberStreamUseCase(
          parameter: GetRandomNumberStreamUseCaseParameter(
            maxLimit: event.maxLimit,
          ),
        );
        emit(state.copyWith(isRunning: true));
        await emit.forEach(
          stream,
          onData: (entity) {
            _logger.i("The number is ${entity.number}");
            return state.copyWith(number: entity.number.toString());
          },
        );
      } else {
        _stopNumberGenerationUseCase(parameter: UseCaseNoParameter());
        emit(state.copyWith(isRunning: false));
      }
    } on RandomNumberException catch (_) {
      _logger.e("Error");
      emit(state.copyWith(status: StreamStatus.error));
    }
  }

  void _disposeStreamBloc(
      DisposeStreamBlocEvent event, Emitter<StreamState> emit) {
    _stopNumberGenerationUseCase(parameter: UseCaseNoParameter());
    emit(state.copyWith(isRunning: false));
  }
}
