// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:args/args.dart';

import 'package:pub_dev/account/backend.dart';
import 'package:pub_dev/package/backend.dart';
import 'package:pub_dev/package/models.dart';
import 'package:pub_dev/shared/datastore.dart';
import 'package:pub_dev/shared/exceptions.dart';

final _argParser = ArgParser()
  ..addOption('lookup', allowed: ['package', 'publisher', 'userid', 'email'])
  ..addOption('update', allowed: ['true', 'false'])
  ..addOption('reason', help: 'The reason of blocked status.')
  ..addFlag('help', abbr: 'h', defaultsTo: false, help: 'Show help.');

Future<String> executeSetPackageBlocked(List<String> args) async {
  final argv = _argParser.parse(args);
  final blockedStatus = _parseValue(argv['update'] as String?);
  final blockedReason = argv['reason'] as String?;
  final lookupKey = argv['lookup'] as String?;

  if (argv['help'] as bool || lookupKey == null) {
    return 'Usage: <tool> --lookup package [pkg1] [pkg2] -- list status of packages\n'
        'Usage: <tool> --lookup publisher [publisher1] [publisher2] -- list status of packages from publishers\n'
        'Usage: <tool> --lookup userid [user1] [user2] -- list status of packages from uploaders\n'
        'Usage: <tool> --lookup email [email1] [email2] -- list status of packages from uploaders\n'
        'Usage: <tool> --update true --lookup email [email1] [email2] -- update status of packages from uploaders\n'
        '${_argParser.usage}';
  }

  final packages = <String, Package>{};

  Future<void> loadPackages(String name, String? value) async {
    final query = dbService.query<Package>()..filter('$name =', value);
    await for (final p in query.run()) {
      packages[p.name!] = p;
    }
  }

  InvalidInputException.checkAnyOf(
      lookupKey, 'lookupKey', ['package', 'publisher', 'userid', 'email']);
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
      InvalidInputException.check(
          users.isNotEmpty, 'Email lookup failed: $email');
      for (final u in users) {
        await loadPackages('uploaders', u.userId);
      }
    }
  }

  final output = StringBuffer();
  output.writeln('Found ${packages.length} packages.');
  final orderedNames = packages.keys.toList()..sort();
  for (final name in orderedNames) {
    final p = packages[name]!;
    output.writeln('${p.name!.padRight(40)} - ${p.isBlocked}');
  }

  if (blockedStatus != null) {
    for (final name in orderedNames) {
      final p = packages[name]!;
      final out = await _updateStatus(p, blockedStatus, blockedReason);
      if (out.isNotEmpty) {
        output.writeln(out);
      }
    }
  }
  return output.toString();
}

Future<String> _updateStatus(Package pkg, bool status, String? reason) async {
  if (pkg.isBlocked == status) {
    return '';
  }
  await withRetryTransaction(dbService, (tx) async {
    final p = await tx.lookupValue<Package>(pkg.key);
    p.updateIsBlocked(isBlocked: status, reason: reason);
    tx.insert(p);
  });
  await purgePackageCache(pkg.name!);
  return ('Updating ${pkg.name!.padRight(40)} - ${pkg.isBlocked} -> $status');
}

bool? _parseValue(String? value) {
  if (value == null) return null;
  if (value == 'true') return true;
  if (value == 'false') return false;
  throw ArgumentError('Unknown bool value: $value');
}
