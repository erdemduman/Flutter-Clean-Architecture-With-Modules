import 'package:dashboard/dashboard.dart';
import 'package:core/src/data/mapper/random_number_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late RandomNumberMemoryDataSourceImpl memoryDataSource;

  setUp(() {
    memoryDataSource = RandomNumberMemoryDataSourceImpl();
  });

  test('set and get randomNumber', () {
    // Arrange
    const RandomNumberModel randomNumber = RandomNumberModel(number: 42);

    // Act
    memoryDataSource.randomNumber = randomNumber;
    final retrievedRandomNumber = memoryDataSource.randomNumber;

    // Assert
    expect(retrievedRandomNumber, equals(randomNumber));
  });
}
