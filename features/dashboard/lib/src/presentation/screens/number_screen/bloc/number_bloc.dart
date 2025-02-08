import 'package:core/core.dart';
import 'package:dashboard/dashboard.dart';

import 'number_event.dart';
import 'number_state.dart';

class NumberBloc extends BaseBloc<NumberEvent, NumberState> {
  final GetStoredRandomNumberUseCase _getStoredRandomNumberUseCase;
  final GetRandomNumberUseCase _getRandomNumberUseCase;
  final Logger _logger;

  NumberBloc(
    this._getStoredRandomNumberUseCase,
    this._getRandomNumberUseCase,
    this._logger,
  ) : super(NumberState.create()) {
    on<InitNumberBlocEvent>(_initNumberBloc);
    on<FetchNumberEvent>(_fetchNumber);

    add(const InitNumberBlocEvent());
  }

  void _initNumberBloc(
    InitNumberBlocEvent event,
    Emitter<NumberState> emit,
  ) async {
    RandomNumberEntity entity = await _getStoredRandomNumberUseCase(
      parameter: UseCaseNoParameter(),
    );
    emit(state.copyWith(number: entity.number.toString()));
  }

  void _fetchNumber(FetchNumberEvent event, Emitter<NumberState> emit) async {
    try {
      RandomNumberEntity entity = await _getRandomNumberUseCase(
        parameter: GetRandomNumberUseCaseParameter(
          maxLimit: event.maxLimit,
        ),
      );
      _logger.i("The number is: ${entity.number}");
      emit(state.copyWith(number: entity.number.toString()));
    } on RandomNumberException catch (_) {
      _logger.e("Error");
      emit(state.copyWith(status: NumberStatus.error));
    }
  }
}
