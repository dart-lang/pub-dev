// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library pub_dartlang_org.utils;

import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:appengine/appengine.dart';
import 'package:intl/intl.dart';
import 'package:logging/logging.dart';
// ignore: implementation_imports
import 'package:mime/src/default_extension_map.dart' as mime;
import 'package:path/path.dart' as p;
import 'package:pub_semver/pub_semver.dart' as semver;
import 'package:stream_transform/stream_transform.dart';

export 'package:pana/pana.dart' show exampleFileCandidates;

final Duration twoYears = const Duration(days: 2 * 365);

/// The value `X-Cloud-Trace-Context`.
///
/// Standard trace header used by
/// [StackDriver](https://cloud.google.com/trace/docs/support) and supported by
/// Appengine.
const _cloudTraceContextHeader = 'X-Cloud-Trace-Context';

final Logger _logger = Logger('pub.utils');
final _random = Random.secure();

final DateFormat shortDateFormat = DateFormat.yMMMd();

final jsonUtf8Encoder = JsonUtf8Encoder();
final utf8JsonDecoder = utf8.decoder.fuse(json.decoder);

Future<T> withTempDirectory<T>(Future<T> Function(Directory dir) func,
    {String prefix = 'dart-tempdir'}) {
  return Directory.systemTemp.createTemp(prefix).then((Directory dir) {
    return func(dir).whenComplete(() {
      return dir.delete(recursive: true);
    });
  });
}

/// Returns null if version is invalid or cannot be normalized.
String? canonicalizeVersion(String? version) {
  if (version == null || version.trim().isEmpty) {
    return null;
  }
  // NOTE: This is a hack because [semver.Version.parse] does not remove
  // leading zeros for integer fields.
  semver.Version v;
  try {
    v = semver.Version.parse(version);
  } on FormatException {
    return null;
  }
  final pre = v.preRelease.isNotEmpty ? v.preRelease.join('.') : null;
  final build = v.build.isNotEmpty ? v.build.join('.') : null;

  final canonicalVersion =
      semver.Version(v.major, v.minor, v.patch, pre: pre, build: build);

  if (v != canonicalVersion) {
    return null;
  }
  return canonicalVersion.toString();
}

/// Compares two versions according to the semantic versioning specification.
///
/// If [pubSorted] is `true` then pub's priorization ordering is used, which
/// will rank pre-release versions lower than stable versions (e.g. it will
/// order "0.9.0-dev.1 < 0.8.0").  Otherwise it will use semantic version
/// sorting (e.g. it will order "0.8.0 < 0.9.0-dev.1").
int compareSemanticVersionsDesc(
    semver.Version a, semver.Version b, bool decreasing, bool pubSorted) {
  if (pubSorted) {
    if (decreasing) {
      return semver.Version.prioritize(b, a);
    } else {
      return semver.Version.prioritize(a, b);
    }
  } else {
    if (decreasing) {
      return b.compareTo(a);
    } else {
      return a.compareTo(b);
    }
  }
}

/// Returns true if [b] is considered newer than [a].
///
/// If [pubSorted] is `true` then pub's priorization ordering is used, which
/// will rank pre-release versions lower than stable versions (e.g. it will
/// order "0.9.0-dev.1 < 0.8.0").  Otherwise it will use semantic version
/// sorting (e.g. it will order "0.8.0 < 0.9.0-dev.1").
bool isNewer(semver.Version a, semver.Version b, {bool pubSorted = true}) =>
    compareSemanticVersionsDesc(a, b, false, pubSorted) < 0;

List<List<T>> _sliceList<T>(List<T> list, int limit) {
  if (list.length <= limit) return [list];
  final int maxPageIndex = (list.length - 1) ~/ limit;
  return List.generate(maxPageIndex + 1,
      (p) => list.sublist(p * limit, min(list.length, (p + 1) * limit)));
}

/// Buffers for [duration] and then randomizes the order of the items in the
/// stream. For every single item, their final position would be in the range of
/// [maxPositionDiff] of its original position.
Stream<T> randomizeStream<T>(
  Stream<T> stream, {
  Duration duration = const Duration(minutes: 1),
  int maxPositionDiff = 1000,
  Random? random,
}) {
  random ??= Random.secure();
  final Stream trigger = Stream.periodic(duration);
  return stream.buffer(trigger).transform(StreamTransformer.fromHandlers(
    handleData: (List<T> items, Sink<T> sink) {
      for (List<T> list in _sliceList(items, maxPositionDiff)) {
        list.shuffle(random);
        for (T task in list) {
          sink.add(task);
        }
      }
    },
  ));
}

class LastNTracker<T extends Comparable<T>> {
  final Queue<T> _lastItems = Queue();
  final int _n;

  LastNTracker({int lastN = 1000}) : _n = lastN;

  void add(T d) {
    _lastItems.addLast(d);
    if (_lastItems.length > _n) _lastItems.removeFirst();
  }

  T? get median => _getP(0.5);
  T? get p90 => _getP(0.9);
  T? get p99 => _getP(0.99);

  Map<T, int> toCounts() {
    return _lastItems.fold<Map<T, int>>({}, (Map<T, int> m, T item) {
      m[item] = (m[item] ?? 0) + 1;
      return m;
    });
  }

  double get average {
    if (_lastItems.isEmpty) return 0.0;
    final double sum = _lastItems.whereType<num>().fold(0.0, (a, b) => a + b);
    return sum / _lastItems.length;
  }

  T? _getP(double p) {
    if (_lastItems.isEmpty) return null;
    final List<T> list = List.from(_lastItems);
    list.sort();
    return list[(list.length * p).floor()];
  }
}

class DurationTracker extends LastNTracker<Duration> {
  Map toShortStat() => {
        'median': median?.inMilliseconds,
        'p90': p90?.inMilliseconds,
        'p99': p99?.inMilliseconds,
      };
}

String formatDuration(Duration d) {
  final List<String> parts = [];
  int minutes = d.inMinutes;
  if (minutes == 0) return '0 mins';

  int hours = minutes ~/ 60;
  minutes = minutes % 60;
  final int days = hours ~/ 24;
  hours = hours % 24;

  if (days > 0) parts.add('$days days');
  if (hours > 0) parts.add('$hours hours');
  if (minutes > 0) parts.add('$minutes mins');

  return parts.join(' ');
}

/// Returns the MIME content type based on the name of the file.
String contentType(String name) {
  final ext = p.extension(name).replaceAll('.', '');
  return mime.defaultExtensionMap[ext] ?? 'application/octet-stream';
}

/// Returns a subset of the list, bounded by [offset] and [limit].
List<T> boundedList<T>(List<T> list, {int? offset, int? limit}) {
  Iterable<T> iterable = list;
  if (offset != null && offset > 0) {
    if (offset >= list.length) {
      return <T>[];
    } else {
      iterable = iterable.skip(offset);
    }
  }
  if (limit != null && limit > 0) {
    iterable = iterable.take(limit);
  }
  return iterable.toList();
}

/// Executes [body] and returns with the same result.
/// When it throws an exception, it will be re-run until [maxAttempt] is reached.
Future<R> retryAsync<R>(
  Future<R> Function() body, {
  int maxAttempt = 3,
  bool Function(Object)? shouldRetryOnError,
  String description = 'Async operation',
  Duration sleep = const Duration(seconds: 1),
}) async {
  for (int i = 1;; i++) {
    try {
      return await body();
    } catch (e, st) {
      _logger.info('$description failed (attempt: $i of $maxAttempt).', e, st);
      if (i < maxAttempt &&
          (shouldRetryOnError == null || shouldRetryOnError(e))) {
        await Future.delayed(sleep);
        continue;
      }
      rethrow;
    }
  }
}

/// Returns a UUID in v4 format as a `String`.
///
/// If [bytes] is provided, it must be length 16 and have values between `0` and
/// `255` inclusive.
///
/// If [bytes] is not provided, it is generated using `Random.secure`.
String createUuid([List<int>? bytes]) {
  bytes ??= List<int>.generate(16, (_) => _random.nextInt(256));
  if (bytes.length != 16) {
    throw ArgumentError('16 bytes expected, got: ${bytes.length}');
  }
  // See http://www.cryptosys.net/pki/uuid-rfc4122.html for notes
  bytes[6] = (bytes[6] & 0x0F) | 0x40;
  bytes[8] = (bytes[8] & 0x3f) | 0x80;

  String formatByte(int byte) => byte.toRadixString(16).padLeft(2, '0');

  return [
    bytes.sublist(0, 4).map(formatByte).join(),
    bytes.sublist(4, 6).map(formatByte).join(),
    bytes.sublist(6, 8).map(formatByte).join(),
    bytes.sublist(8, 10).map(formatByte).join(),
    bytes.sublist(10).map(formatByte).join(),
  ].join('-');
}

/// Returns a header map when appengine context's is active and `traceId` is set.
///
/// Returns `null` otherwise.
Map<String, String>? cloudTraceHeaders() {
  // [context] is defined as non-nullable in package:appengine, but in practice
  // it may be missing if the current processing is outside of a regular request
  // (e.g. triggered by a Timer).
  // TODO: remove try-catch after [context] gets fixed in package:appengine.
  try {
    if (context.traceId == null) return null;
    return {_cloudTraceContextHeader: context.traceId!};
  } catch (_) {
    return null;
  }
}

extension LoggerExt on Logger {
  /// Reports an error [message] with the current stacktrace.
  void reportError(String message) =>
      shout(message, Exception(message), StackTrace.current);
}

/// Statistics for delete + filter operations.
class DeleteCounts {
  /// The number of items found by the query.
  final int found;

  /// The number of items deleted by the query (matching the filter condition).
  final int deleted;

  DeleteCounts(this.found, this.deleted);
  factory DeleteCounts.empty() => DeleteCounts(0, 0);

  DeleteCounts operator +(DeleteCounts other) {
    return DeleteCounts(found + other.found, deleted + other.deleted);
  }

  @override
  String toString() => '$deleted/$found';
}

extension ByteArrayEqualsExt on List<int> {
  /// Returns `true` only if the two arrays are identical.
  bool byteToByteEquals(List<int>? other) {
    if (other == null) {
      return false;
    }
    if (length != other.length) {
      return false;
    }
    for (var i = 0; i < length; i++) {
      if (this[i] != other[i]) {
        return false;
      }
    }
    return true;
  }
}

/// Compare two strings with with fixed number of operations to prevent timing attacks.
bool fixedTimeEquals(String a, String b) {
  final N = a.length;
  var result = 0;
  if (N != b.length) {
    b = a; // always cycle through a to avoid leaking length
    result = 1; // return false
  }
  for (var i = 0; i < N; i++) {
    result |= a.codeUnitAt(i) ^ b.codeUnitAt(i);
  }
  return result == 0;
}
