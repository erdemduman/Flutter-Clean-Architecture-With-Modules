import 'package:core/core.dart';
import 'package:core/src/presentation/bloc/websocket_bloc/websocket_event.dart';
import 'package:core/src/presentation/bloc/websocket_bloc/websocket_state.dart';

class WebsocketBloc extends BaseBloc<WebsocketEvent, WebsocketState> {
  final Logger _logger;

  WebsocketBloc(this._logger) : super(WebsocketState.create()) {
    on<FetchNumberStreamEvent>(_fetchNumberStream);
  }

  @override
  void init({required BlocParameter parameter}) {
    _logger.d("Init");
  }

  @override
  void dispose() {
    _logger.d("Dispose");
  }

  Future<void> _fetchNumberStream(
    FetchNumberStreamEvent event,
    Emitter<WebsocketState> emit,
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
      emit(state.copyWith(status: WebSocketStatus.error));
    }
  }
}