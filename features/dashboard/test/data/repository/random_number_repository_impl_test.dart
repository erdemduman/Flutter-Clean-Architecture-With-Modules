import 'package:core/src/data/mapper/random_number_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:core/core.dart';
import 'package:dashboard/dashboard.dart';

class MockRandomNumberDataSource extends Mock
    implements RandomNumberDataSource {}

class MockRandomNumberStreamDataSource extends Mock
    implements RandomNumberStreamDataSource {}

class MockRandomNumberMemoryDataSource extends Mock
    implements RandomNumberMemoryDataSource {}

void main() {
  late MockRandomNumberDataSource mockRandomNumberDataSource;
  late MockRandomNumberStreamDataSource mockRandomNumberStreamDataSource;
  late MockRandomNumberMemoryDataSource mockRandomNumberMemoryDataSource;
  late RandomNumberRepositoryImpl randomNumberRepository;

  setUp(() {
    mockRandomNumberDataSource = MockRandomNumberDataSource();
    mockRandomNumberStreamDataSource = MockRandomNumberStreamDataSource();
    mockRandomNumberMemoryDataSource = MockRandomNumberMemoryDataSource();
    randomNumberRepository = RandomNumberRepositoryImpl(
      mockRandomNumberDataSource,
      mockRandomNumberStreamDataSource,
      mockRandomNumberMemoryDataSource,
    );
  });

  test('getRandomNumber returns a random number entity', () async {
    // Arrange
    const int maxLimit = 25;
    const RandomNumberModel expectedNumberModel = RandomNumberModel(number: 23);
    final expectedNumberEntity =
        RandomNumberEntity(number: expectedNumberModel.number ?? -1);

    when(() => mockRandomNumberDataSource.getRandomNumber(maxLimit))
        .thenAnswer((_) => Future.value(expectedNumberModel));

    // Act
    final result = await randomNumberRepository.getRandomNumber(maxLimit);

    // Assert
    expect(result, equals(expectedNumberEntity));
    verify(() => mockRandomNumberDataSource.getRandomNumber(maxLimit))
        .called(1);
  });

  test('getRandomNumberStream yields random number entities', () {
    // Arrange
    const int maxLimit = 100;
    final expectedValues = Stream.fromIterable([
      const RandomNumberModel(number: 23),
      const RandomNumberModel(number: 33),
      const RandomNumberModel(number: 91),
    ]);

    when(() => mockRandomNumberStreamDataSource.getRandomNumberStream(maxLimit))
        .thenAnswer((_) => expectedValues);

    // Act
    final result = randomNumberRepository.getRandomNumberStream(maxLimit);

    // Assert
    expectLater(
      result,
      emitsInOrder([
        const RandomNumberEntity(number: 23),
        const RandomNumberEntity(number: 33),
        const RandomNumberEntity(number: 91),
        emitsDone,
      ]),
    );
  });

  test('getStoredRandomNumber returns a stored random number entity', () async {
    // Arrange
    const RandomNumberModel expectedNumberModel = RandomNumberModel(number: 23);
    final expectedNumberEntity =
        RandomNumberEntity(number: expectedNumberModel.number ?? -1);

    when(() => mockRandomNumberMemoryDataSource.randomNumber)
        .thenReturn(expectedNumberModel);

    // Act
    final result = await randomNumberRepository.getStoredRandomNumber();

    // Assert
    expect(result, equals(expectedNumberEntity));
    verify(() => mockRandomNumberMemoryDataSource.randomNumber).called(1);
  });

  test('getRandomNumber throws RandomNumberException', () async {
    // Arrange
    const int maxLimit = 23;
    when(() => mockRandomNumberDataSource.getRandomNumber(maxLimit)).thenAnswer(
      (_) async => throw const RandomNumberException(),
    );

    // Act & Assert
    expect(
      () async => await randomNumberRepository.getRandomNumber(maxLimit),
      throwsA(const RandomNumberException()),
    );
    verify(() => mockRandomNumberDataSource.getRandomNumber(maxLimit))
        .called(1);
  });

  test('getRandomNumberStream throws RandomNumberException on exception',
      () async {
    // Arrange
    const int maxLimit = 25;

    when(() => mockRandomNumberStreamDataSource.getRandomNumberStream(maxLimit))
        .thenThrow(const RandomNumberException());

    // Act
    final result = randomNumberRepository.getRandomNumberStream(maxLimit);

    // Assert
    expect(result, emitsError(isA<RandomNumberException>()));
  });

  test('stopNumberGeneration stops number generation', () async {
    // Act
    randomNumberRepository.stopNumberGeneration();

    // Assert
    verify(() => mockRandomNumberStreamDataSource.stopNumberGeneration())
        .called(1);
  });
}
