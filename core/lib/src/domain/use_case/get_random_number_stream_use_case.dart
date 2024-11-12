import 'package:core/core.dart';

import '../repository/random_number_repository.dart';

class GetRandomNumberStreamUseCase
    implements UseCase<Stream<RandomNumberEntity>> {
  final RandomNumberRepository _randomNumberRepository;

  const GetRandomNumberStreamUseCase(this._randomNumberRepository);

  @override
  Stream<RandomNumberEntity> call(
      {required UseCaseParameter parameter}) async* {
    try {
      var param = parameter as GetRandomNumberStreamUseCaseParameter;
      Stream<RandomNumberEntity> randomEntityStream =
          _randomNumberRepository.getRandomNumberStream(param.maxLimit);
      yield* randomEntityStream;
    } on RandomNumberException catch (_) {
      rethrow;
    }
  }
}

class GetRandomNumberStreamUseCaseParameter extends UseCaseParameter {
  final int maxLimit;

  GetRandomNumberStreamUseCaseParameter({required this.maxLimit});
}
