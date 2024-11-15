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
  bool _isRunning = false;
  StreamController<RandomNumberModel>? _controller;

  RandomNumberStreamDataSourceImpl(this._rng, this._logger);

  @override
  Stream<RandomNumberModel> getRandomNumberStream(int maxLimit) {
    if (_controller != null && !_controller!.isClosed) {
      return _controller!.stream;
    }

    _controller = StreamController<RandomNumberModel>.broadcast(
      onListen: () {
        _startNumberGeneration(maxLimit);
      },
      onCancel: () {
        if (!_controller!.hasListener) {
          _stopNumberGeneration();
        }
      },
    );

    return _controller!.stream;
  }

  void _startNumberGeneration(int maxLimit) {
    if (_isRunning) return;

    _isRunning = true;
    _logger.i("Number generator started");

    Future.doWhile(() async {
      if (!_isRunning) return false;

      await Future.delayed(const Duration(seconds: 1));
      var number = _rng.nextInt(maxLimit);
      _logger.i('Number $number has been generated to be returned.');

      if (_isRunning) _controller?.add(RandomNumberModel(number: number));
      return true;
    }).catchError((e) {
      _controller?.addError(const RandomNumberException());
    });
  }

  @override
  void stopNumberGeneration() {
    _stopNumberGeneration();
    _controller?.close();
  }

  void _stopNumberGeneration() {
    if (!_isRunning) return;

    _isRunning = false;
    _logger.i("Number generator stopped");
  }
}
