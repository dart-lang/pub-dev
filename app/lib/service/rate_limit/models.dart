// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:clock/clock.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../admin/actions/actions.dart';

part 'models.g.dart';

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class RateLimitRequestCounter {
  final DateTime started;
  final int value;

  RateLimitRequestCounter({
    required this.started,
    required this.value,
  });
  RateLimitRequestCounter.init([this.value = 0]) : started = clock.now().toUtc();

  factory RateLimitRequestCounter.fromJson(Map<String, dynamic> json) =>
      _$RateLimitRequestCounterFromJson(json);

  Map<String, dynamic> toJson() => _$RateLimitRequestCounterToJson(this);

  RateLimitRequestCounter incrementOrThrow({
    required int limit,
    required Duration window,
    required String windowAsText,
  }) {
    final now = clock.now().toUtc();
    final age = now.difference(started);
    var newStarted = started;
    var newValue = value + 1;
    // reset the counter after the window has expired
    if (age > window) {
      newStarted = now;
      newValue = 1;
    }
    // verify the counter is under the limit
    if (newValue > limit) {
      throw RateLimitException(
        operation: 'search',
        maxCount: limit,
        windowAsText: windowAsText,
        window: window,
      );
    }
    return RateLimitRequestCounter(
      started: newStarted,
      value: newValue,
    );
  }
}
