// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library pub_dartlang_org.utils;

import 'dart:async';
import 'dart:io';

import 'package:pub_semver/pub_semver.dart' as semver;

Future withTempDirectory(Future func(Directory dir),
                         {String prefix: 'dart-tempdir'}) {
  return Directory.systemTemp.createTemp(prefix).then((Directory dir) {
    return func(dir).whenComplete(() {
      return dir.delete(recursive: true);
    });
  });
}

Future<List<String>> listTarball(String path) async {
  var result = await Process.run('tar', ['--exclude=*/*/*', '-tzf', path]);
  if (result.exitCode != 0) {
    throw 'Failed to list tarball contents.';
  }

  return result.stdout.split('\n').where((part) => part != '').toList();
}

Future<String> readTarballFile(String path, String name) async {
  var result = await Process.run('tar', ['-xzf', path, name, '-O']);
  if (result.exitCode != 0) throw 'Failed to read tarball contents.';

  return result.stdout;
}

String canonicalizeVersion(String version) {
  // NOTE: This is a hack because [semver.Version.parse] does not remove
  // leading zeros for integer fields.
  var v = new semver.Version.parse(version);
  var pre = v.preRelease != null && v.preRelease.isNotEmpty ?
      v.preRelease.join('.') : null;
  var build = v.build != null && v.build.isNotEmpty ? v.build.join('.') : null;

  var canonicalVersion = new semver.Version(
      v.major, v.minor, v.patch, pre: pre, build: build);

  if (v != canonicalVersion) {
    throw new StateError(
        'This should never happen: Canonicalization of versions is wrong.');
  }
  return canonicalVersion.toString();
}
