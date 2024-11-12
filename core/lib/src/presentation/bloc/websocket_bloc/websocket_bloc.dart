import 'package:core/core.dart';
import 'package:core/src/presentation/bloc/websocket_bloc/websocket_event.dart';
import 'package:core/src/presentation/bloc/websocket_bloc/websocket_state.dart';

class WebsocketBloc extends BaseBloc<WebsocketEvent, WebsocketState> {
  final Logger _logger;
  final GetRandomNumberStreamUseCase _getRandomNumberStreamUseCase;

  WebsocketBloc(this._getRandomNumberStreamUseCase, this._logger)
      : super(WebsocketState.create()) {
    on<FetchNumberStreamEvent>(_fetchNumberStream, transformer: restartable());
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
    try {} on RandomNumberException catch (_) {
      _logger.e("Error");
      emit(state.copyWith(status: WebSocketStatus.error));
    }
  }
}
