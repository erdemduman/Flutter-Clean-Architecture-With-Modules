import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'dart:math';

import 'package:core/core.dart';

class MockRandom extends Mock implements Random {}

class MockLogger extends Mock implements Logger {}

void main() {
  late MockRandom mockRandom;
  late MockLogger mockLogger;
  late RandomNumberDataSourceImpl randomNumberDataSource;

  setUp(() {
    mockRandom = MockRandom();
    mockLogger = MockLogger();
    randomNumberDataSource = RandomNumberDataSourceImpl(mockRandom, mockLogger);
  });

  test('getRandomNumber generates a random number within the limit and logs it',
      () async {
    // Arrange
    const int maxLimit = 25;
    final random = Random();
    int expectedRandomNumber = random.nextInt(maxLimit);

    when(() => mockRandom.nextInt(maxLimit)).thenReturn(expectedRandomNumber);

    // Act
    final result = await randomNumberDataSource.getRandomNumber(maxLimit);

    // Assert
    expect(result.number, lessThan(maxLimit));
    verify(() => mockLogger.i(
            'Number $expectedRandomNumber has been generated to be returned.'))
        .called(1);
  });

  test('getRandomNumber throws a RandomNumberException on error', () async {
    // Arrange
    const int maxLimit = 25;

    when(() => mockRandom.nextInt(maxLimit)).thenThrow(
      const RandomNumberException(),
    );

    // Act & Assert
    expect(
      () async => await randomNumberDataSource.getRandomNumber(maxLimit),
      throwsA(const RandomNumberException()),
    );
  });
}
