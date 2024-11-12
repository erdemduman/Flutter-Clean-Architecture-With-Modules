import 'package:core/core.dart';

class GetStoredRandomNumberUseCase
    implements UseCase<Future<RandomNumberEntity>> {
  final RandomNumberRepository _randomNumberRepository;

  const GetStoredRandomNumberUseCase(this._randomNumberRepository);

  @override
  Future<RandomNumberEntity> call({required UseCaseParameter parameter}) async {
    return await _randomNumberRepository.getStoredRandomNumber();
  }
}
