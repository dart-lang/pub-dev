// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cli_util/cli_util.dart' as cli;
import 'package:path/path.dart' as p;

import 'analysis_options.dart';
import 'logging.dart';
import 'utils.dart';

class DartSdk {
  final String _sdkDir;
  final Map<String, String> _environment = {};
  final String _dartCmd;
  final String _dartAnalyzerCmd;
  final String _dartfmtCmd;
  final String _pubCmd;
  String _version;

  DartSdk._(String sdkDir, Map<String, String> environment)
      : _sdkDir = sdkDir,
        _dartCmd = _join(sdkDir, 'bin', 'dart'),
        _dartAnalyzerCmd = _join(sdkDir, 'bin', 'dartanalyzer'),
        _dartfmtCmd = _join(sdkDir, 'bin', 'dartfmt'),
        _pubCmd = _join(sdkDir, 'bin', 'pub') {
    if (environment != null) {
      _environment.addAll(environment);
    }
  }

  factory DartSdk({String sdkDir, Map<String, String> environment}) =>
      new DartSdk._(sdkDir ?? cli.getSdkPath(), environment);

  String get sdkDir => _sdkDir;

  String get version {
    if (_version == null) {
      var r = handleProcessErrors(
          Process.runSync(_dartCmd, ['--version'], environment: _environment));
      _version = r.stderr.toString().trim();
    }
    return _version;
  }

  Future<ProcessResult> runAnalyzer(
      String packageDir, List<String> dirs) async {
    final optionsFileName =
        'pana_analysis_options_${new DateTime.now().microsecondsSinceEpoch}.g.yaml';
    final optionsFile = new File(p.join(packageDir, optionsFileName));
    await optionsFile.writeAsString(analysisOptions);
    final params = ['--options', optionsFile.path, '--format', 'machine']
      ..addAll(dirs);
    final pr = await runProc(
      _dartAnalyzerCmd,
      params,
      environment: _environment,
      workingDirectory: packageDir,
    );
    await optionsFile.delete();
    return pr;
  }

  Future<List<String>> filesNeedingFormat(String packageDir) async {
    final dirs = await listFocusDirs(packageDir);
    if (dirs.isEmpty) {
      return const [];
    }
    final files = <String>[];
    for (final dir in dirs) {
      var result = await runProc(
        _dartfmtCmd,
        ['--dry-run', '--set-exit-if-changed', p.join(packageDir, dir)],
        environment: _environment,
      );
      if (result.exitCode == 0) {
        return const [];
      }

      final lines = LineSplitter
          .split(result.stdout)
          .map((file) => p.join(dir, file))
          .toList();
      if (result.exitCode == 1) {
        assert(lines.isNotEmpty);
        files.addAll(lines);
        continue;
      }

      throw [
        "dartfmt on $dir/ failed with exit code ${result.exitCode}",
        result.stderr
      ].join('\n').toString();
    }
    files.sort();
    return files;
  }

  Future<ProcessResult> _execUpgrade(String packageDir) => runProc(
        _pubCmd,
        ['upgrade', '--verbosity', 'io', '--no-precompile'],
        workingDirectory: packageDir,
        environment: _environment,
      );
}

class FlutterSdk {
  final String _flutterBin;

  FlutterSdk({String sdkDir}) : _flutterBin = _join(sdkDir, 'bin', 'flutter');

  Future<ProcessResult> _execUpgrade(
          String packageDir, Map<String, String> environment) =>
      runProc(
        _flutterBin,
        ['packages', 'pub', 'upgrade', '--verbosity', 'io', '--no-precompile'],
        workingDirectory: packageDir,
        environment: environment,
      );

  Future<Map<String, Object>> getVersion() async {
    var result = await runProc(_flutterBin, ['--version', '--machine']);
    assert(result.exitCode == 0);
    return JSON.decode(result.stdout);
  }
}

class PubEnvironment {
  final DartSdk dartSdk;
  final FlutterSdk flutterSdk;
  final String pubCacheDir;
  final Map<String, String> _environment = {};

  PubEnvironment({DartSdk dartSdk, FlutterSdk flutterSdk, this.pubCacheDir})
      : this.dartSdk = dartSdk ?? new DartSdk(),
        this.flutterSdk = flutterSdk ?? new FlutterSdk() {
    _environment.addAll(this.dartSdk._environment);
    if (!_environment.containsKey(_pubEnvironmentKey)) {
      // Then do the standard behavior. Extract the current value, if any,
      // and append the default value

      var pubEnvironment = <String>[];

      var currentEnv = Platform.environment[_pubEnvironmentKey];

      if (currentEnv != null) {
        pubEnvironment.addAll(currentEnv
                .split(
                    ':') // if there are many values, they should be separated by `:`
                .map((v) => v.trim()) // don't want whitespace
                .where((v) => v.isNotEmpty) // don't want empty values
            );
      }

      pubEnvironment.add('bot.pkg_pana');

      _environment[_pubEnvironmentKey] = pubEnvironment.join(':');
    }
    if (pubCacheDir != null) {
      var resolvedDir = new Directory(pubCacheDir).resolveSymbolicLinksSync();
      if (resolvedDir != pubCacheDir) {
        throw new ArgumentError([
          "Make sure you resolve symlinks:",
          pubCacheDir,
          resolvedDir
        ].join('\n'));
      }
      _environment['PUB_CACHE'] = pubCacheDir;
    }
  }

  Future<ProcessResult> runUpgrade(String packageDir, bool isFlutter,
      {int retryCount: 3}) async {
    ProcessResult result;
    do {
      retryCount--;

      if (isFlutter) {
        result = await flutterSdk._execUpgrade(packageDir, _environment);
      } else {
        result = await dartSdk._execUpgrade(packageDir);
      }

      if (result.exitCode > 0) {
        var errOutput = result.stderr as String;

        // find cases where retrying is not going to help – and short-circuit
        if (errOutput.contains("Could not get versions for flutter from sdk")) {
          log.severe("Flutter SDK required!");
          retryCount = 0;
        } else if (errOutput
            .contains("FINE: Exception type: NoVersionException")) {
          log.severe("Version solve failure");
          retryCount = 0;
        }
      }
    } while (result.exitCode > 0 && retryCount > 0);
    return result;
  }

  Future<PackageLocation> getLocation(String package, {String version}) async {
    var args = ['cache', 'add', '--verbose'];
    if (version != null) {
      args.addAll(['--version', version]);
    }
    args.add(package);

    var result = handleProcessErrors(await runProc(
      dartSdk._pubCmd,
      args,
      environment: _environment,
    ));

    var match = _versionDownloadRexexp.allMatches(result.stdout.trim()).single;
    var pkgMatch = match[1];
    assert(pkgMatch == package);

    var versionString = match[2];
    assert(versionString.endsWith('.'));
    while (versionString.endsWith('.')) {
      versionString = versionString.substring(0, versionString.length - 1);
    }

    if (version != null) {
      assert(versionString == version);
    }

    // now get all installed packages
    result = handleProcessErrors(await runProc(
      dartSdk._pubCmd,
      ['cache', 'list'],
      environment: _environment,
    ));

    var json = JSON.decode(result.stdout) as Map;

    var location =
        json['packages'][package][versionString]['location'] as String;

    if (location == null) {
      throw "Huh? This should be cached!";
    }

    return new PackageLocation(package, versionString, location);
  }

  ProcessResult listPackageDirsSync(String packageDir, bool useFlutter) {
    if (useFlutter) {
      // flutter env
      return runProcSync(
        flutterSdk._flutterBin,
        ['packages', 'pub', 'list-package-dirs'],
        workingDirectory: packageDir,
        environment: _environment,
      );
    } else {
      // normal pub
      return runProcSync(
        dartSdk._pubCmd,
        ['list-package-dirs'],
        workingDirectory: packageDir,
        environment: _environment,
      );
    }
  }

  /// Removes the dev_dependencies from the pubspec.yaml
  Future removeDevDependencies(String packageDir) async {
    final file = new File(p.join(packageDir, 'pubspec.yaml'));
    final original = await file.readAsString();
    final parsed = yamlToJson(original);
    parsed.remove('dev_dependencies');
    await file.writeAsString(JSON.encode(parsed));
  }
}

class PackageLocation {
  final String package;
  final String version;
  final String location;

  PackageLocation(this.package, this.version, this.location);
}

final _versionDownloadRexexp =
    new RegExp(r"^MSG : (?:Downloading |Already cached )([\w-]+) (.+)$");

const _pubEnvironmentKey = 'PUB_ENVIRONMENT';

String _join(String path, String binDir, String executable) =>
    path == null ? executable : p.join(path, binDir, executable);
