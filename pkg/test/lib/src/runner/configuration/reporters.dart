// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:collection';
import 'dart:io';

import '../../util/io.dart';
import '../configuration.dart';
import '../engine.dart';
import '../reporter.dart';
import '../reporter/compact.dart';
import '../reporter/expanded.dart';
import '../reporter/json.dart';

/// Constructs a reporter for the provided engine with the provided
/// configuration.
typedef Reporter ReporterFactory(Configuration configuration, Engine engine);

/// Container for a reporter description and corresponding factory.
class ReporterDetails {
  final String description;
  final ReporterFactory factory;
  ReporterDetails(this.description, this.factory);
}

/// All reporters and their corresponding details.
final UnmodifiableMapView<String, ReporterDetails> allReporters =
    new UnmodifiableMapView<String, ReporterDetails>(_allReporters);

final _allReporters = <String, ReporterDetails>{
  "expanded": new ReporterDetails(
      "A separate line for each update.",
      (config, engine) => ExpandedReporter.watch(engine,
          color: config.color,
          printPath: config.paths.length > 1 ||
              new Directory(config.paths.single).existsSync(),
          printPlatform: config.suiteDefaults.platforms.length > 1)),
  "compact": new ReporterDetails("A single line, updated continuously.",
      (_, engine) => CompactReporter.watch(engine)),
  "json": new ReporterDetails(
      "A machine-readable format (see https://goo.gl/gBsV1a).",
      (_, engine) => JsonReporter.watch(engine)),
};

final defaultReporter =
    inTestTests ? 'expanded' : (Platform.isWindows ? 'expanded' : 'compact');

/// **Do not call this function without express permission from the test package
/// authors**.
///
/// This globally registers a reporter.
void registerReporter(String name, ReporterDetails reporterDetails) {
  _allReporters[name] = reporterDetails;
}
