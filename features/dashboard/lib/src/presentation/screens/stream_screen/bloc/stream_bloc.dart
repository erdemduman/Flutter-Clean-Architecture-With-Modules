import 'package:core/core.dart';
import 'package:dashboard/dashboard.dart';

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

    add(const InitStreamBlocEvent());
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

  @override
  Future<void> close() {
    _logger.d("Closing StreamBloc...");
    _stopNumberGenerationUseCase(
      parameter: UseCaseNoParameter(),
    );
    return super.close();
  }
}
