import 'dart:math';

import 'package:core/core.dart';

import '../model/random_number_model.dart';

abstract class RandomNumberDataSource {
  Future<RandomNumberModel> getRandomNumber(int maxLimit);
}

class RandomNumberDataSourceImpl implements RandomNumberDataSource {
  final Random _rng;
  final Logger _logger;

  RandomNumberDataSourceImpl(this._rng, this._logger);

  @override
  Future<RandomNumberModel> getRandomNumber(int maxLimit) async {
    try {
      RandomNumberModel number =
          RandomNumberModel(number: _rng.nextInt(maxLimit));
      _logger.i('Number ${number.number} has been generated to be returned.');
      return Future.value(number);
    } catch (_) {
      throw const RandomNumberException();
    }
  }
}
