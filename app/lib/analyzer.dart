// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library pub_dartlang_org.analysis;

import 'dart:async';
import 'dart:io';

import 'package:yaml/yaml.dart' as yaml;

import 'model_properties.dart';
import 'utils.dart';

/// Collects the preparation, analysis and cleanup functions for analyzing a
/// package.
class Analyzer {
  final File _sourceTarGz;
  final Directory _workDir;
  final bool _clearWorkDir;
  Directory _packageDir;

  Pubspec pubspec;
  PubspecLock pubspecLock;

  Analyzer._(this._sourceTarGz, this._workDir, this._clearWorkDir);

  factory Analyzer(String source, {String workDir}) {
    final Directory wd = workDir != null
        ? new Directory(workDir)
        : Directory.systemTemp.createTempSync();
    return new Analyzer._(new File(source), wd, workDir == null);
  }

  /// Prepares the directories for the analysis and extracts the package.
  Future setUp() async {
    if (!_sourceTarGz.existsSync()) {
      throw new Exception('Source file not found: ${_sourceTarGz.path}');
    }
    if (!_workDir.existsSync()) {
      await _workDir.create(recursive: true);
    }
    _packageDir = await _workDir.createTemp('package-');
    await extractTarball(_sourceTarGz.path, _packageDir.path);
  }

  Future analyzeAll() async {
    await runPubGet();
    await readPubspecs();
    await runDartAnalyzer();
    await runDartFormatter();
  }

  /// Runs pub get in the package directory to fetch the dependencies.
  Future runPubGet() async {
    // TODO: control the version of Dart SDK
    // TODO: control the cache location
    // TODO: add timeout handling
    final ProcessResult pr =
        await Process.run('pub', ['get'], workingDirectory: _packageDir.path);
    if (pr.exitCode != 0) {
      throw new Exception('pub get error: ${pr.stdout} ${pr.stderr}');
    }
  }

  /// Reads pubspec.yaml and pubspec.lock.
  Future readPubspecs() async {
    final String pubspecContent = await new File(
            _packageDir.path + Platform.pathSeparator + 'pubspec.yaml')
        .readAsString();
    pubspec = new Pubspec.fromYaml(pubspecContent);
    final String pubspecLockContent = await new File(
            _packageDir.path + Platform.pathSeparator + 'pubspec.lock')
        .readAsString();
    pubspecLock = new PubspecLock.fromYaml(pubspecLockContent);
  }

  Future runDartAnalyzer() async {
    // TODO: implement
  }

  Future runDartFormatter() async {
    // TODO: implement
  }

  void createReport() {
    // TODO: implement
  }

  /// Deletes all directories and files that were created during the analysis.
  Future tearDown() async {
    if (_clearWorkDir) {
      await _workDir?.delete(recursive: true);
    } else {
      await _packageDir?.delete(recursive: true);
    }
  }
}

class PubspecLock {
  Map _content;
  List<LockedDependency> _packages;

  PubspecLock.fromYaml(String yamlContent) {
    _content = yaml.loadYaml(yamlContent);
  }

  List<LockedDependency> get packages {
    if (_packages == null) {
      _packages = [];
      final Map pkgs = _content['packages'];
      if (pkgs != null) {
        pkgs.forEach((String key, Map m) {
          _packages.add(new LockedDependency.fromMap(key, m));
        });
      }
      _packages.sort((a, b) => a.key.compareTo(b.key));
    }
    return _packages;
  }
}

class LockedDependency {
  final String key;
  final String descriptionName;
  final String descriptionUrl;
  final String source;
  final String version;

  LockedDependency(
      {this.key,
      this.descriptionName,
      this.descriptionUrl,
      this.source,
      this.version});

  factory LockedDependency.fromMap(String key, Map map) {
    final Map description = map['description'] ?? {};
    return new LockedDependency(
        key: key,
        descriptionName: description['name'],
        descriptionUrl: description['url'],
        source: map['source'],
        version: map['version']);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LockedDependency &&
          runtimeType == other.runtimeType &&
          key == other.key &&
          descriptionName == other.descriptionName &&
          descriptionUrl == other.descriptionUrl &&
          source == other.source &&
          version == other.version;

  @override
  int get hashCode =>
      key.hashCode ^
      descriptionName.hashCode ^
      descriptionUrl.hashCode ^
      source.hashCode ^
      version.hashCode;

  @override
  String toString() {
    return 'LockedDependency{key: $key, descriptionName: $descriptionName, '
        'descriptionUrl: $descriptionUrl, source: $source, version: $version}';
  }
}
