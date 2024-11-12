import 'package:core/core.dart';

abstract class RandomNumberRepository {
  /// Returns a random number between 0 and [maxLimit]
  Future<RandomNumberEntity> getRandomNumber(int maxLimit);

  /// Returns a stream that generates a random number
  /// between 0 and [maxLimit] every second.
  Stream<RandomNumberEntity> getRandomNumberStream(int maxLimit);

  /// Returns the random number that is stored in memory.
  Future<RandomNumberEntity> getStoredRandomNumber();

  /// Stops the random number stream
  void stopNumberGeneration();
}
