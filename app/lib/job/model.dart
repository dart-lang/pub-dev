// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:math' as math;

import 'package:clock/clock.dart';
import 'package:pub_semver/pub_semver.dart';

import '../shared/datastore.dart';

/// Identifies the service which creates and processes the [Job].
enum JobService {
  /// The `analyzer` service will process the job.
  analyzer,

  /// The `dartdoc` service will process the job.
  dartdoc,
}

/// Identifies the current state of the [Job].
enum JobState {
  /// The [Job] is available for processing (it was scheduled to be processed),
  /// any worker can lock it.
  available,

  /// The [Job] was selected and locked by a worker, which should process the
  /// related package in a reasonable amount of time.
  processing,

  /// The [Job] does not need processing, and it is not currently under processing.
  idle,
}

/// Identifies the last status of processing of the [Job].
enum JobStatus {
  /// There is no last status, the [Job] was never selected for processing.
  none,

  /// The last processing was successful.
  success,

  /// The last processing considered the package flags and decided not to
  /// process it with full scope, only taking a shortcut.
  skipped,

  /// The last processing completed, but it has warnings.
  failed,

  /// The last processing was aborted (timeout or other `Exception`).
  aborted,
}

@Kind(name: 'Job', idType: IdType.String)
class Job extends ExpandoModel<String> {
  @StringProperty()
  String? runtimeVersion;

  @JobServiceProperty()
  JobService? service;

  @StringProperty()
  String? packageName;

  @StringProperty(indexed: false)
  String? packageVersion;

  @DateTimeProperty(indexed: false)
  DateTime? packageVersionUpdated;

  @BoolProperty(indexed: false)
  bool isLatestStable = false;

  @BoolProperty(indexed: false)
  bool isLatestPrerelease = false;

  @BoolProperty(indexed: false)
  bool isLatestPreview = false;

  @JobStateProperty()
  JobState? state;

  @DateTimeProperty()
  DateTime? lockedUntil;

  // fields for state = available

  @IntProperty()
  int priority = 0;

  // fields for state = processing

  @StringProperty(indexed: false)
  String? processingKey;

  // fields for state = idle

  @JobStatusProperty()
  JobStatus? lastStatus;

  @IntProperty(indexed: false)
  int? lastRunDurationInSeconds;

  @IntProperty(indexed: false)
  int? attemptCount = 0;

  @IntProperty(indexed: false)
  int errorCount = 0;

  bool get isLatest => isLatestStable || isLatestPrerelease || isLatestPreview;

  @override
  String toString() => '$packageName $packageVersion';

  void updatePriority(double popularity, {int? fixPriority}) {
    if (fixPriority != null) {
      priority = fixPriority;
      return;
    }
    priority = 0;

    // newer versions first
    final now = clock.now().toUtc();
    final age = now.difference(packageVersionUpdated!).abs();
    priority += age.inDays;

    // popular packages first, with a compensation for age
    final ageCompensation = math.min(age.inDays, 60) / 60;
    final normalizedPopularity = math.max(0.0, math.min(1.0, popularity));
    priority += ((1 - normalizedPopularity) * 2000 * ageCompensation).round();

    // non-latest versions get pushed back in the queue
    if (!isLatest) {
      priority += 100000;

      // pre-release versions get pushed back even further
      final parsed = Version.parse(packageVersion!);
      if (parsed.isPreRelease) {
        priority += 100000;
      }
    }

    // errors encountered, pushing it back in the queue
    priority += errorCount * 100;
  }
}

class JobServiceProperty extends StringProperty {
  const JobServiceProperty({String? propertyName, bool required = false})
      : super(propertyName: propertyName, required: required, indexed: true);

  @override
  bool validate(ModelDB db, Object? value) =>
      (!required || value != null) && (value == null || value is JobService);

  @override
  String? encodeValue(ModelDB db, Object? value, {bool forComparison = false}) {
    if (value == null) return null;
    if (value is JobService) {
      return jobServiceAsString(value);
    } else {
      throw Exception('Unknown job service: $value');
    }
  }

  @override
  Object? decodePrimitiveValue(ModelDB db, Object? value) {
    if (value == null) return null;
    return JobService.values
        .firstWhere((js) => jobServiceAsString(js) == value);
  }
}

class JobStateProperty extends StringProperty {
  const JobStateProperty({String? propertyName, bool required = false})
      : super(propertyName: propertyName, required: required, indexed: true);

  @override
  bool validate(ModelDB db, Object? value) =>
      (!required || value != null) && (value == null || value is JobState);

  @override
  String? encodeValue(ModelDB db, Object? value, {bool forComparison = false}) {
    if (value == null) return null;
    if (value is JobState) {
      return jobStateAsString(value);
    } else {
      throw Exception('Unknown job state: $value');
    }
  }

  @override
  Object? decodePrimitiveValue(ModelDB db, Object? value) {
    if (value == null) return null;
    return JobState.values.firstWhere((js) => jobStateAsString(js) == value);
  }
}

class JobStatusProperty extends StringProperty {
  const JobStatusProperty({String? propertyName, bool required = false})
      : super(propertyName: propertyName, required: required, indexed: true);

  @override
  bool validate(ModelDB db, Object? value) =>
      (!required || value != null) && (value == null || value is JobStatus);

  @override
  String? encodeValue(ModelDB db, Object? value, {bool forComparison = false}) {
    if (value == null) return null;
    if (value is JobStatus) {
      return jobStatusAsString(value);
    } else {
      throw Exception('Unknown job status: $value');
    }
  }

  @override
  Object? decodePrimitiveValue(ModelDB db, Object? value) {
    if (value == null) return null;
    return JobStatus.values.firstWhere((js) => jobStatusAsString(js) == value);
  }
}

String jobServiceAsString(JobService value) => value.toString().split('.').last;
String jobStateAsString(JobState value) => value.toString().split('.').last;
String jobStatusAsString(JobStatus value) => value.toString().split('.').last;
