// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';
import 'dart:io';

HttpClient httpClient = new HttpClient();

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
    print('Specify at least one argument:');
    print(
        'deploy.dart ( app | analyzer | dartdoc | search | all ) [ --delete-old ]');
    exit(1);
  }

  String newVersion = new DateTime.now()
      .toIso8601String()
      .replaceAll('-', '')
      .replaceAll(':', '')
      .replaceAll('T', 't')
      .split('.')
      .first;
  print('New version: $newVersion');

  final bool deleteOld = args.contains('--delete-old');
  for (String service in services) {
    print('\nDeploying $service...\n');
    await new _ServiceDeployer(service, newVersion, deleteOld).deploy();
  }

  httpClient.close(force: true);
}

class _ServiceDeployer {
  final String project;
  final String service;
  final String newVersion;
  final bool migrateTraffic;
  final bool deleteOld;
  String _oldVersion;

  _ServiceDeployer(this.service, this.newVersion, this.deleteOld)
      : project = Platform.environment['GCLOUD_PROJECT'],
        migrateTraffic =
            Platform.environment['GCLOUD_PROJECT'] != 'dartlang-pub-dev' {
    if (project == null) {
      throw new StateError('GCLOUD_PROJECT must be set!');
    }
  }

  Future deploy() async {
    await _detectOldVersion();
    await _gcloudDeploy();
    await _checkHealth();
    await _migrateTraffic();
    await _deleteOldVersion();
  }

  Future _detectOldVersion() async {
    final pr = await Process.run(
      'gcloud',
      ['app', 'versions', 'list', '--service', service, '--format=value(id)'],
    );
    if (pr.exitCode != 0) {
      print('[ERR] Couldn\'t detect old $service version.');
      print(pr.stderr);
      return;
    }
    _oldVersion = pr.stdout.trim();
    if (_oldVersion.contains('\n')) {
      print('[WARN] Multiple existing versions detected: '
          '${_oldVersion}, none will be deleted.');
      _oldVersion = null;
    } else {
      print('Old $service version: $_oldVersion');
    }
  }

  Future _gcloudDeploy() async {
    final String yamlFile = service == 'default' ? 'app.yaml' : '$service.yaml';
    final pr = await Process.run(
      'gcloud',
      ['app', 'deploy', yamlFile, '--no-promote', '-v', newVersion, '-q'],
    );
    if (pr.exitCode != 0) {
      print('[ERR] Couldn\'t deploy $service.');
      print(pr.stderr);
      exit(1);
    }
  }

  String get baseUrl {
    switch (service) {
      case 'analyzer':
      case 'search':
        return 'https://$newVersion-dot-$service-dot-$project.appspot.com';
      case 'default':
        return 'https://$newVersion-dot-$project.appspot.com';
    }
    throw new StateError('Unknown service: $service');
  }

  Future _checkHealth() async {
    final String debugUrl = '$baseUrl/debug';
    print('Checking $debugUrl');
    final req = await httpClient.openUrl('GET', Uri.parse(debugUrl));
    final res = await req.close();
    if (res.statusCode != 200) {
      print('[ERR] $service health check failed.');
      exit(1);
    }
    List<int> bytes =
        await res.fold([], (List<int> all, List<int> d) => all..addAll(d));
    Map map = JSON.decode(UTF8.decode(bytes));
    if (map != null && map.isNotEmpty) {
      print('$service health check OK.');
    } else {
      print('[ERR] $service health check failed.');
      exit(1);
    }
  }

  Future _migrateTraffic() async {
    final List<String> args = [
      'app',
      'services',
      'set-traffic',
      service,
      '--splits',
      '$newVersion=1',
    ];
    if (migrateTraffic) {
      args.add('--migrate');
    }
    args.add('-q');
    final pr = await Process.run('gcloud', args);
    if (pr.exitCode != 0) {
      print('[ERR] Couldn\'t migrate traffic for $service.');
      print(pr.stderr);
      exit(1);
    }
  }

  Future _deleteOldVersion() async {
    if (_oldVersion == null) return;
    final pr = await Process.run('gcloud',
        ['app', 'versions', 'delete', '--service', service, _oldVersion, '-q']);
    if (pr.exitCode != 0) {
      print('[ERR] Couldn\'t delete old version of $service.');
      print(pr.stderr);
      exit(1);
    }
  }
}
