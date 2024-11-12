import 'dart:math';

import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../model/random_number_model.dart';

abstract class RandomNumberStreamDataSource {
  Stream<RandomNumberModel> getRandomNumberStream(int maxLimit);
  void stopNumberGeneration();
}

class RandomNumberStreamDataSourceImpl implements RandomNumberStreamDataSource {
  final Random _rng;
  final Logger _logger;
  @visibleForTesting
  bool isRunning = false;

  RandomNumberStreamDataSourceImpl(this._rng, this._logger);

  @override
  Stream<RandomNumberModel> getRandomNumberStream(int maxLimit) async* {
    try {
      isRunning = true;
      while (isRunning) {
        await Future.delayed(const Duration(seconds: 1));
        var number = _rng.nextInt(maxLimit);
        _logger.i('Number $number has been generated to be returned.');
        yield RandomNumberModel(number: number);
      }
    } catch (_) {
      throw const RandomNumberException();
    }
  }

  @override
  void stopNumberGeneration() {
    _logger.i("Number generator stopped");
    isRunning = false;
  }
}
