import 'dart:async';

import 'package:core/core.dart';

class WebsocketBloc extends BaseBloc<WebsocketEvent, WebsocketState> {
  final Logger _logger;
  final GetRandomNumberStreamUseCase _getRandomNumberStreamUseCase;
  final StopNumberGenerationUseCase _stopNumberGenerationUseCase;
  final BehaviorSubject<String> _numberStreamController =
      BehaviorSubject<String>();
  StreamSubscription<RandomNumberEntity>? _currentSubscription;

  WebsocketBloc(
    this._getRandomNumberStreamUseCase,
    this._stopNumberGenerationUseCase,
    this._logger,
  ) : super(WebsocketState.create()) {
    on<FetchNumberStreamEvent>(_fetchNumberStream, transformer: restartable());
    on<StopNumberStreamEvent>(_stopNumberStream);
  }

  @override
  void init({required BlocParameter parameter}) {
    _logger.d("Init");
  }

  Future<void> _fetchNumberStream(
    FetchNumberStreamEvent event,
    Emitter<WebsocketState> emit,
  ) async {
    await _currentSubscription?.cancel();

    try {
      var stream = _getRandomNumberStreamUseCase(
        parameter: GetRandomNumberStreamUseCaseParameter(
          maxLimit: event.maxLimit,
        ),
      );

      // Listen to the stream and emit values to the BehaviorSubject
      _currentSubscription = stream.listen(
        (data) {
          _logger.d("Data from the stream: ${data.number}");
          _numberStreamController.add(data.number.toString());
        },
        onError: (e) {
          _logger.e("Error: $e");
          emit(state.copyWith(status: WebSocketStatus.error));
        },
      );
    } catch (e) {
      _logger.e("Unexpected error: $e");
      emit(state.copyWith(status: WebSocketStatus.error));
    }
  }

  Future<void> _stopNumberStream(
    StopNumberStreamEvent event,
    Emitter<WebsocketState> emit,
  ) async {
    await _currentSubscription?.cancel();
    _stopNumberGenerationUseCase(parameter: UseCaseNoParameter());
  }

  @override
  void dispose() async {
    await _currentSubscription?.cancel();
    _numberStreamController.close();
    _logger.d("Dispose");
  }

  Stream<String> get numberStream => _numberStreamController.stream;
}
