import 'dart:async';
import 'dart:math';

import 'package:core/core.dart';
import 'package:flutter/material.dart';

abstract class RandomNumberStreamDataSource {
  Stream<RandomNumberModel> getRandomNumberStream(int maxLimit);
  void stopNumberGeneration();
}

class RandomNumberStreamDataSourceImpl implements RandomNumberStreamDataSource {
  final Random _rng;
  final Logger _logger;
  @visibleForTesting
  bool isRunning = false;
  var controller = StreamController<RandomNumberModel>.broadcast();

  RandomNumberStreamDataSourceImpl(this._rng, this._logger);

  @override
  Stream<RandomNumberModel> getRandomNumberStream(int maxLimit) async* {
    controller = StreamController<RandomNumberModel>.broadcast(
      onListen: () async {
        isRunning = true;
        try {
          while (isRunning) {
            await Future.delayed(const Duration(seconds: 1));
            var number = _rng.nextInt(maxLimit);
            _logger.i('Number $number has been generated to be returned.');
            controller.add(RandomNumberModel(number: number));
          }
        } catch (_) {
          controller.addError(const RandomNumberException());
        }
      },
      onCancel: () {
        _logger.i("Number generator stopped");
        isRunning = false;
      },
    );

    yield* controller.stream;
  }

  @override
  void stopNumberGeneration() {
    _logger.i("Number generator stopped");
    isRunning = false;
  }
}
