// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:math' as math;

import 'package:gcloud/db.dart';
import 'package:pub_semver/pub_semver.dart';

enum JobService { analyzer, dartdoc }
enum JobState { available, processing, idle }
enum JobStatus { none, success, skipped, failed, aborted }

@Kind(name: 'Job', idType: IdType.String)
class Job extends ExpandoModel {
  @StringProperty()
  String runtimeVersion;

  @JobServiceProperty()
  JobService service;

  @StringProperty()
  String packageName;

  @StringProperty()
  String packageVersion;

  @DateTimeProperty()
  DateTime packageVersionUpdated;

  @BoolProperty()
  bool isLatestStable;

  @JobStateProperty()
  JobState state;

  @DateTimeProperty()
  DateTime lockedUntil;

  // fields for state = available

  @IntProperty()
  int priority;

  // fields for state = processing

  @StringProperty()
  String processingKey;

  // fields for state = idle

  @JobStatusProperty()
  JobStatus lastStatus;

  @IntProperty()
  int errorCount;

  Version get semanticRuntimeVersion => Version.parse(runtimeVersion);

  @override
  String toString() => '$packageName $packageVersion';

  void updatePriority() {
    priority = 0;

    // newer versions first
    final now = DateTime.now().toUtc();
    final age = now.difference(packageVersionUpdated).abs();
    priority += age.inDays;

    // non-latest stable versions get pushed back in the queue
    if (!isLatestStable) {
      priority += 100000;
      priority +=
          math.max(0, age.inDays - 180) * 100; // penalty for older versions
    }

    // errors encountered, pushing it back in the queue
    priority += math.min(errorCount, 100) * 1000 + errorCount;
  }
}

class JobServiceProperty extends StringProperty {
  const JobServiceProperty({String propertyName, bool required = false})
      : super(propertyName: propertyName, required: required, indexed: true);

  @override
  bool validate(ModelDB db, Object value) =>
      (!this.required || value != null) &&
      (value == null || value is JobService);

  @override
  String encodeValue(ModelDB db, Object value, {bool forComparison = false}) {
    if (value == null) return null;
    if (value is JobService) {
      return jobServiceAsString(value);
    } else {
      throw Exception('Unknown job service: $value');
    }
  }

  @override
  Object decodePrimitiveValue(ModelDB db, Object value) {
    if (value == null) return null;
    return JobService.values
        .firstWhere((js) => jobServiceAsString(js) == value);
  }
}

class JobStateProperty extends StringProperty {
  const JobStateProperty({String propertyName, bool required = false})
      : super(propertyName: propertyName, required: required, indexed: true);

  @override
  bool validate(ModelDB db, Object value) =>
      (!this.required || value != null) && (value == null || value is JobState);

  @override
  String encodeValue(ModelDB db, Object value, {bool forComparison = false}) {
    if (value == null) return null;
    if (value is JobState) {
      return jobStateAsString(value);
    } else {
      throw Exception('Unknown job state: $value');
    }
  }

  @override
  Object decodePrimitiveValue(ModelDB db, Object value) {
    if (value == null) return null;
    return JobState.values.firstWhere((js) => jobStateAsString(js) == value);
  }
}

class JobStatusProperty extends StringProperty {
  const JobStatusProperty({String propertyName, bool required = false})
      : super(propertyName: propertyName, required: required, indexed: true);

  @override
  bool validate(ModelDB db, Object value) =>
      (!this.required || value != null) &&
      (value == null || value is JobStatus);

  @override
  String encodeValue(ModelDB db, Object value, {bool forComparison = false}) {
    if (value == null) return null;
    if (value is JobStatus) {
      return jobStatusAsString(value);
    } else {
      throw Exception('Unknown job status: $value');
    }
  }

  @override
  Object decodePrimitiveValue(ModelDB db, Object value) {
    if (value == null) return null;
    return JobStatus.values.firstWhere((js) => jobStatusAsString(js) == value);
  }
}

String jobServiceAsString(JobService value) => value.toString().split('.').last;
String jobStateAsString(JobState value) => value.toString().split('.').last;
String jobStatusAsString(JobStatus value) => value.toString().split('.').last;
