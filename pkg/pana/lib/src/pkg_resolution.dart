// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library pana.pkg_resolution;

import 'dart:convert';
import 'dart:io' hide exitCode;

import 'package:path/path.dart' as p;
import 'package:pub_semver/pub_semver.dart';
import 'package:json_annotation/json_annotation.dart';

import 'pubspec.dart';
import 'utils.dart';

part 'pkg_resolution.g.dart';

final _solvePkgLine = new RegExp(
    r"(?:[><\+\! ]) (\w+) (\S+)(?: \((\S+) available\))?(?: from .+)?");

@JsonSerializable()
class PkgResolution extends Object with _$PkgResolutionSerializerMixin {
  final List<PkgDependency> dependencies;

  PkgResolution(this.dependencies);

  static PkgResolution create(Pubspec pubspec, String procStdout,
      {String path}) {
    var pkgVersions = <String, Version>{};
    var availVersions = <String, Version>{};

    var entries = PubEntry
        .parse(procStdout)
        .where((entry) => entry.header == 'MSG')
        .where((entry) =>
            entry.content.every((line) => _solvePkgLine.hasMatch(line)))
        .toList();

    if (entries.length == 1) {
      for (var match in entries.single.content.map(_solvePkgLine.firstMatch)) {
        var pkg = match.group(1);
        pkgVersions[pkg] = new Version.parse(match.group(2));
        var availVerStr = match.group(3);
        if (availVerStr != null) {
          availVersions[pkg] = new Version.parse(availVerStr);
        }
      }
    } else if (entries.length > 1) {
      throw "Seems that we have two sections of packages solves - weird!";
    } else {
      // it's empty – which is fine for a package with no dependencies
    }

    if (path != null) {
      _validateLockedVersions(path, pkgVersions);
    }

    final deps = _buildDeps(pubspec, pkgVersions, availVersions);
    return new PkgResolution(deps);
  }

  factory PkgResolution.fromJson(Map<String, dynamic> json) =>
      _$PkgResolutionFromJson(json);

  List<PkgDependency> get outdated =>
      dependencies.where((pd) => pd.isOutdated).toList();

  Map<String, int> getStats(Pubspec pubspec) {
    // counts: direct, dev, transitive
    // outdated count, by constraint: direct, dev
    // outdated count, other: all
    var directDeps = pubspec.dependencies?.length ?? 0;
    var devDeps = pubspec.devDependencies?.length ?? 0;

    var transitiveDeps = dependencies.where((pd) => pd.isTransitive).length;

    var data = <String, int>{
      'deps_direct': directDeps,
      'deps_dev': devDeps,
      'deps_transitive': transitiveDeps,
      'outdated_direct': outdated.where((pvd) => pvd.isDirect).length,
      'outdated_dev': outdated.where((pvd) => pvd.isDev).length,
      'outdated_transitive': outdated.where((pvd) => pvd.isTransitive).length,
    };

    return data;
  }
}

void _validateLockedVersions(String path, Map<String, Version> pkgVersions) {
  var theFile = new File(p.join(path, 'pubspec.lock'));
  if (theFile.existsSync()) {
    var lockFileContent = theFile.readAsStringSync();
    if (lockFileContent.isNotEmpty) {
      Map lockMap = yamlToJson(lockFileContent);
      Map<String, Object> pkgs = lockMap['packages'];
      if (pkgs != null) {
        var expectedPackages = pkgVersions.keys.toSet();

        pkgs.forEach((String key, Object v) {
          if (!expectedPackages.remove(key)) {
            throw new StateError(
                "Did not parse package `$key` from pub output, "
                "but it was found in `pubspec.lock`.");
          }

          var m = v as Map;

          var lockedVersion = new Version.parse(m['version']);
          if (pkgVersions[key] != lockedVersion) {
            throw new StateError(
                "For $key, the parsed version ${pkgVersions[key]} did not "
                "match the locked version $lockedVersion.");
          }
        });

        if (expectedPackages.isNotEmpty) {
          throw new StateError(
              "We parsed more packaged than were found in the lock file: "
              "${expectedPackages.join(', ')}");
        }
      }
    }
  }
}

List<PkgDependency> _buildDeps(Pubspec pubspec,
    Map<String, Version> pkgVersions, Map<String, Version> availVersions) {
  var loggedWeird = false;
  void logWeird(String input) {
    if (!loggedWeird) {
      // only write the header if there is "weirdness" in processing
      stderr.writeln("Package: ${pubspec.name}");
      loggedWeird = true;
    }
    // write every line of the input indented 2 spaces
    stderr.writeAll(LineSplitter.split(input).map((line) => '  $line\n'));
  }

  var deps = <PkgDependency>[];

  /// [versionConstraint] can be a `String` or `Map`
  /// If it's a `Map` – just log and continue.
  void addDetail(String package, versionConstraint, String dependencyType) {
    String constraintType;
    final errors = <String>[];
    String constraintValue;
    if (dependencyType == DependencyTypes.transitive) {
      constraintType = ConstraintTypes.inherited;
    } else if (versionConstraint == null) {
      constraintType = ConstraintTypes.empty;
    } else if (versionConstraint is Map) {
      if (versionConstraint.containsKey('sdk')) {
        constraintType = ConstraintTypes.sdk;
        if (versionConstraint['sdk'] != 'flutter') {
          errors.add(
              'Unsupported SDK for package $package: ${versionConstraint['sdk']}');
        }
      } else if (versionConstraint.containsKey('git')) {
        constraintType = ConstraintTypes.git;
        if (dependencyType != DependencyTypes.dev) {
          errors.add(
              'Git constraint for package $package: ${versionConstraint['git']}');
        }
      } else if (versionConstraint.containsKey('path')) {
        constraintType = ConstraintTypes.path;
        errors.add(
            'Path constraint for package $package: ${versionConstraint['path']}');
      } else if (versionConstraint.containsKey('version') &&
          versionConstraint['version'] is String) {
        constraintType = ConstraintTypes.normal;
        constraintValue = versionConstraint['version'];
      } else if (versionConstraint.isEmpty) {
        constraintType = ConstraintTypes.empty;
      } else {
        constraintType = ConstraintTypes.unknown;
        errors.add(
            'Unknown constraint for package $package:\n$versionConstraint');
      }
    } else if (versionConstraint is String) {
      constraintType = ConstraintTypes.normal;
      constraintValue = versionConstraint;
    } else {
      constraintType = ConstraintTypes.unknown;
    }

    VersionConstraint constraint;
    if (constraintValue != null) {
      try {
        constraint = new VersionConstraint.parse(constraintValue);
      } catch (e) {
        errors.add(
            'Error parsing constraint for package $package: $constraintValue');
      }
    }
    var resolved = pkgVersions[package];
    var available = availVersions[package];
    if (resolved == null && dependencyType != DependencyTypes.dev) {
      errors.add('No resolved version for package $package');
    }

    if (resolved != null &&
        constraint != null &&
        !constraint.allows(resolved)) {
      errors.add(
          'Package $package has version $resolved but $constraint does not allow it!');
    }

    errors.forEach(logWeird);

    deps.add(new PkgDependency(
      package,
      dependencyType,
      constraintType,
      constraint,
      resolved,
      available,
      errors.isEmpty ? null : errors,
    ));
  }

  final packageNames = new Set<String>();

  pubspec.dependencies?.forEach((k, v) {
    if (packageNames.add(k)) {
      addDetail(k, v, DependencyTypes.direct);
    }
  });

  pubspec.devDependencies?.forEach((k, v) {
    if (packageNames.add(k)) {
      addDetail(k, v, DependencyTypes.dev);
    }
  });

  pkgVersions.forEach((k, v) {
    if (packageNames.add(k)) {
      addDetail(k, null, DependencyTypes.transitive);
    }
  });

  availVersions.forEach((k, v) {
    if (packageNames.add(k)) {
      addDetail(k, null, DependencyTypes.transitive);
    }
  });

  deps.sort((a, b) => a.package.compareTo(b.package));
  return deps;
}

enum VersionResolutionType {
  /// The resolved version is the latest.
  latest,

  /// The latest version is not available due to a version constraint.
  constrained,

  /// Other, unknown?
  other,
}

abstract class DependencyTypes {
  static final String direct = 'direct';
  static final String dev = 'dev';
  static final String transitive = 'transitive';
}

abstract class ConstraintTypes {
  static final String empty = 'empty';
  static final String normal = 'normal';
  static final String sdk = 'sdk';
  static final String git = 'git';
  static final String path = 'path';
  static final String inherited = 'inherited';
  static final String unknown = 'unknown';
}

@JsonSerializable()
class PkgDependency extends Object
    with _$PkgDependencySerializerMixin
    implements Comparable<PkgDependency> {
  final String package;

  final String dependencyType;

  final String constraintType;

  @JsonKey(includeIfNull: false)
  final VersionConstraint constraint;

  @JsonKey(includeIfNull: false)
  final Version resolved;

  @JsonKey(includeIfNull: false)
  final Version available;

  @JsonKey(includeIfNull: false)
  final List<String> errors;

  PkgDependency(this.package, this.dependencyType, this.constraintType,
      this.constraint, this.resolved, this.available, this.errors);

  factory PkgDependency.fromJson(Map<String, dynamic> json) =>
      _$PkgDependencyFromJson(json);

  bool get isDirect => dependencyType == DependencyTypes.direct;
  bool get isDev => dependencyType == DependencyTypes.dev;
  bool get isTransitive => dependencyType == DependencyTypes.transitive;

  bool get isLatest => available == null;
  bool get isOutdated => !isLatest;

  VersionResolutionType get resolutionType {
    if (isLatest) return VersionResolutionType.latest;

    if (constraint != null && constraint.allows(available)) {
      return VersionResolutionType.constrained;
    }

    if (available.isPreRelease) {
      // If the pre-release isn't allowed by the constraint, then ignore it
      // ... call it a match
      return VersionResolutionType.latest;
    }

    return VersionResolutionType.other;
  }

  @override
  int compareTo(PkgDependency other) => package.compareTo(other.package);

  @override
  String toString() {
    var items = <Object>[package];
    if (isDev) {
      items.add('(dev)');
    } else if (isTransitive) {
      items.add('(transitive)');
    }
    items.add('@$resolved');

    items.add(resolutionType.toString().split('.').last);

    if (resolutionType != VersionResolutionType.latest) {
      items.add(available);
    }
    return items.join(' ');
  }
}

class PubEntry {
  static final _headerMatch = new RegExp(r"^([A-Z]{2,4})[ ]{0,2}: (.*)");
  static final _lineMatch = new RegExp(r"^    \|(.*)");

  final String header;
  final List<String> content;

  PubEntry(this.header, this.content);

  static Iterable<PubEntry> parse(String input) sync* {
    String header;
    List<String> entryLines;

    for (var line in LineSplitter.split(input)) {
      if (line.trim().isEmpty) {
        continue;
      }
      var match = _headerMatch.firstMatch(line);

      if (match != null) {
        if (header != null || entryLines != null) {
          assert(entryLines.isNotEmpty);
          yield new PubEntry(header, entryLines);
          header = null;
          entryLines = null;
        }
        header = match[1];
        entryLines = <String>[match[2]];
      } else {
        match = _lineMatch.firstMatch(line);

        if (match == null) {
          // Likely due to Flutter silly
          // stderr.writeln("Could not parse pub line `$line`.");
          continue;
        }

        assert(entryLines != null);
        entryLines.add(match[1]);
      }
    }

    if (header != null || entryLines != null) {
      assert(entryLines.isNotEmpty);
      yield new PubEntry(header, entryLines);
      header = null;
      entryLines = null;
    }
  }

  @override
  String toString() => '$header: ${content.join('\n')}';
}
