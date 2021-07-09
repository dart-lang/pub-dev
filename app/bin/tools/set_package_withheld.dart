// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import 'package:args/args.dart';

import 'package:pub_dev/account/backend.dart';
import 'package:pub_dev/package/backend.dart';
import 'package:pub_dev/package/models.dart';
import 'package:pub_dev/service/entrypoint/tools.dart';
import 'package:pub_dev/shared/datastore.dart';

final _argParser = ArgParser()
  ..addOption('lookup', allowed: ['package', 'publisher', 'userid', 'email'])
  ..addOption('update', allowed: ['true', 'false'])
  ..addOption('reason', help: 'The reason of withheld status.')
  ..addFlag('help', abbr: 'h', defaultsTo: false, help: 'Show help.');

/// Sets the private key value.
Future main(List<String> args) async {
  final argv = _argParser.parse(args);
  final withheldStatus = _parseValue(argv['update'] as String?);
  final withheldReason = argv['reason'] as String?;
  final lookupKey = argv['lookup'] as String?;

  if (argv['help'] as bool || lookupKey == null) {
    print(
        'Usage: dart set_package_withheld.dart --lookup package [pkg1] [pkg2] -- list status of packages');
    print(
        'Usage: dart set_package_withheld.dart --lookup publisher [publisher1] [publisher2] -- list status of packages from publishers');
    print(
        'Usage: dart set_package_withheld.dart --lookup userid [user1] [user2] -- list status of packages from uploaders');
    print(
        'Usage: dart set_package_withheld.dart --lookup email [email1] [email2] -- list status of packages from uploaders');
    print(
        'Usage: dart set_package_withheld.dart --update true --lookup email [email1] [email2] -- update status of packages from uploaders');
    print(_argParser.usage);
    return;
  }

  await withToolRuntime(() async {
    print('Scanning packages...');
    final packages = <String, Package>{};

    Future<void> loadPackages(String name, String? value) async {
      final query = dbService.query<Package>()..filter('$name =', value);
      await for (final p in query.run()) {
        packages[p.name!] = p;
      }
    }

    if (lookupKey == 'package') {
      for (final name in argv.rest) {
        final p = (await packageBackend.lookupPackage(name))!;
        packages[p.name!] = p;
      }
    } else if (lookupKey == 'publisher') {
      for (final publisherId in argv.rest) {
        await loadPackages('publisherId', publisherId);
      }
    } else if (lookupKey == 'userid') {
      for (final userId in argv.rest) {
        await loadPackages('uploaders', userId);
      }
    } else if (lookupKey == 'email') {
      for (final email in argv.rest) {
        final users = await accountBackend.lookupUsersByEmail(email);
        if (users.isEmpty) {
          throw Exception('Email lookup failed: $email');
        }
        for (final u in users) {
          await loadPackages('uploaders', u.userId);
        }
      }
    } else {
      throw Exception('Lookup not recognized: $lookupKey');
    }

    print('Found ${packages.length} packages.');
    final orderedNames = packages.keys.toList()..sort();
    for (final name in orderedNames) {
      final p = packages[name]!;
      print('${p.name!.padRight(40)} - ${p.isWithheld}');
    }

    if (withheldStatus != null) {
      print('Are you sure you want to do that? Type `y` or `yes`:');
      final confirm = stdin.readLineSync()!;
      if (confirm.toLowerCase() == 'y' || confirm.toLowerCase() == 'yes') {
        for (final name in orderedNames) {
          final p = packages[name]!;
          await _updateStatus(p, withheldStatus, withheldReason);
        }
      } else {
        print('Aborted.');
      }
    }
  });
}

Future<void> _updateStatus(Package pkg, bool status, String? reason) async {
  if (pkg.isWithheld == status) return;
  print('Updating ${pkg.name!.padRight(40)} - ${pkg.isWithheld} -> $status');
  await withRetryTransaction(dbService, (tx) async {
    final p = await tx.lookupValue<Package>(pkg.key);
    p.isWithheld = status;
    p.withheldReason = reason;
    p.updated = DateTime.now().toUtc();
    tx.insert(p);
  });
  await purgePackageCache(pkg.name!);
}

bool? _parseValue(String? value) {
  if (value == null) return null;
  if (value == 'true') return true;
  if (value == 'false') return false;
  throw ArgumentError('Unknown bool value: $value');
}
