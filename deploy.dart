// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';
import 'dart:io';

HttpClient httpClient = HttpClient();

void die(String msg) {
  print('$msg:');
  print('deploy.dart ( app | analyzer | dartdoc | search | all ) '
      '[ --delete-old ] [ --migrate ] [ --stop-first ]');
  exit(1);
}

Future main(List<String> args) async {
  List<String> services;
  if (args.isNotEmpty) {
    switch (args[0]) {
      case 'all':
        services = ['analyzer', 'dartdoc', 'search', 'default'];
        break;
      case 'analyzer':
      case 'analyzer.yaml':
        services = ['analyzer'];
        break;
      case 'dartdoc':
      case 'dartdoc.yaml':
        services = ['dartdoc'];
        break;
      case 'search':
      case 'search.yaml':
        services = ['search'];
        break;
      case 'app':
      case 'app.yaml':
      case 'default':
        services = ['default'];
        break;
    }
  }

  if (services == null) {
    die('Specify at least one argument');
  }

  final bool deleteOld = args.contains('--delete-old');
  final bool migrateTraffic = args.contains('--migrate');
  final bool stopFirst = args.contains('--stop-first') &&
      Platform.environment['GCLOUD_PROJECT'] == 'dartlang-pub-dev';

  if (deleteOld && !migrateTraffic) {
    die('Cannot delete the old version without migrating traffic');
  }

  final newVersion = DateTime.now()
      .toIso8601String()
      .replaceAll('-', '')
      .replaceAll(':', '')
      .replaceAll('T', 't')
      .split('.')
      .first;
  print('New version: $newVersion');

  for (String service in services) {
    print('\nDeploying $service...\n');
    await _ServiceDeployer(
            service, newVersion, deleteOld, migrateTraffic, stopFirst)
        .deploy();
  }

  httpClient.close(force: true);
}

class _ServiceDeployer {
  final String project;
  final String service;
  final String newVersion;
  final bool deleteOld;
  final bool migrateTraffic;
  final bool stopFirst;
  String _oldVersion;

  _ServiceDeployer(this.service, this.newVersion, this.deleteOld,
      this.migrateTraffic, this.stopFirst)
      : project = Platform.environment['GCLOUD_PROJECT'] {
    if (project == null) {
      throw StateError('GCLOUD_PROJECT must be set!');
    }
  }

  Future deploy() async {
    await _detectOldVersion();
    if (stopFirst) {
      await _stopOldVersion();
    }
    await _gcloudDeploy();
    await _checkHealth();
    if (migrateTraffic) {
      await _migrateTraffic();
    }
    if (deleteOld) {
      await _deleteOldVersion();
    }
  }

  Future _detectOldVersion() async {
    final pr = await _runGCloudApp(
        ['versions', 'list', '--service', service, '--format=value(id)'],
        'Couldn\'t detect old $service version.');

    _oldVersion = (pr.stdout as String).trim();
    if (_oldVersion.contains('\n')) {
      print('[WARN] Multiple existing versions detected: '
          '$_oldVersion, none will be deleted.');
      _oldVersion = null;
    } else {
      print('Old $service version: $_oldVersion');
    }
  }

  Future _stopOldVersion() async {
    if (_oldVersion == null) return;
    print('Stopping old version of $service: $_oldVersion');
    await _runGCloudApp(
        ['versions', 'stop', '--service', service, _oldVersion, '-q'],
        'Couldn\'t stop old version of $service.');
  }

  Future _gcloudDeploy() async {
    final String yamlFile = service == 'default' ? 'app.yaml' : '$service.yaml';
    await _runGCloudApp(
        ['deploy', yamlFile, '--no-promote', '-v', newVersion, '-q'],
        'Couldn\'t deploy $service.');
  }

  String get baseUrl {
    switch (service) {
      case 'analyzer':
      case 'dartdoc':
      case 'search':
        return 'https://$newVersion-dot-$service-dot-$project.appspot.com';
      case 'default':
        return 'https://$newVersion-dot-$project.appspot.com';
    }
    throw StateError('Unknown service: $service');
  }

  Future _checkHealth() async {
    final String debugUrl = '$baseUrl/debug';
    print('Checking $debugUrl');
    Future<HttpClientResponse> request() async {
      final req = await httpClient.openUrl('GET', Uri.parse(debugUrl));
      return req.close();
    }

    for (int i = 5; i > 0; i--) {
      final res = await request();
      if (res.statusCode == 200) {
        final List<int> bytes =
            await res.fold([], (List<int> all, List<int> d) => all..addAll(d));
        final map = json.decode(utf8.decode(bytes)) as Map;
        if (map != null && map.isNotEmpty) {
          print('$service health check OK.');
          return;
        }
      }

      // wait before retry
      if (i > 0) {
        await Future.delayed(const Duration(seconds: 15));
      }
    }

    print('[ERR] $service health check failed.');
    exit(1);
  }

  Future _migrateTraffic() async {
    final List<String> args = [
      'services',
      'set-traffic',
      service,
      '--splits',
      '$newVersion=1',
    ];
    args.add('-q');
    await _runGCloudApp(args, 'Couldn\'t migrate traffic for $service.');
  }

  Future _deleteOldVersion() async {
    if (_oldVersion == null) return;
    await _runGCloudApp(
        ['versions', 'delete', '--service', service, _oldVersion, '-q'],
        'Couldn\'t delete old version of $service.');
  }

  Future<ProcessResult> _runGCloudApp(
      List<String> args, String errorMessage) async {
    final allArgs = [
      '--project',
      project,
      'app',
    ]..addAll(args);

    final pr = await Process.run('gcloud', allArgs);
    if (pr.exitCode != 0) {
      print('[ERR] $errorMessage');
      print('Due to executing "gcloud ${allArgs.join(' ')}":');
      print('stdout:\n    ${pr.stdout.replaceAll('\n', '    \n')}');
      print('stderr:\n    ${pr.stderr.replaceAll('\n', '    \n')}');
      exit(1);
    }
    return pr;
  }
}
