import 'package:core/core.dart';

extension RandomNumberMapper on RandomNumberModel {
  RandomNumberEntity toEntity() => RandomNumberEntity(number: number ?? -1);
}
