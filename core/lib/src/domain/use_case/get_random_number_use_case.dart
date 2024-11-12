import 'package:core/core.dart';

import '../repository/random_number_repository.dart';

class GetRandomNumberUseCase implements UseCase<Future<RandomNumberEntity>> {
  final RandomNumberRepository _randomNumberRepository;

  const GetRandomNumberUseCase(this._randomNumberRepository);

  @override
  Future<RandomNumberEntity> call({required UseCaseParameter parameter}) async {
    try {
      var param = parameter as GetRandomNumberUseCaseParameter;
      RandomNumberEntity randomEntity =
          await _randomNumberRepository.getRandomNumber(param.maxLimit);
      return randomEntity;
    } on RandomNumberException catch (_) {
      rethrow;
    }
  }
}

class GetRandomNumberUseCaseParameter extends UseCaseParameter {
  final int maxLimit;

  GetRandomNumberUseCaseParameter({required this.maxLimit});
}
