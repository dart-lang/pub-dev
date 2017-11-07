// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library pana.license;

import 'dart:async';
import 'dart:io';

import 'package:json_annotation/json_annotation.dart';
import 'package:path/path.dart' as p;

part 'license.g.dart';

@JsonSerializable()
class LicenseFile extends Object with _$LicenseFileSerializerMixin {
  final String path;
  final String name;

  @JsonKey(includeIfNull: false)
  final String version;

  LicenseFile(this.path, this.name, {this.version});

  factory LicenseFile.fromJson(Map<String, dynamic> json) =>
      _$LicenseFileFromJson(json);

  String get shortFormatted => version == null ? name : '$name $version';

  @override
  String toString() => '$path: $shortFormatted';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LicenseFile &&
          runtimeType == other.runtimeType &&
          path == other.path &&
          name == other.name &&
          version == other.version;

  @override
  int get hashCode => path.hashCode ^ name.hashCode ^ version.hashCode;
}

abstract class LicenseNames {
  static const String AGPL = 'AGPL';
  static const String Apache = 'Apache';
  static const String BSD = 'BSD';
  static const String GPL = 'GPL';
  static const String LGPL = 'LGPL';
  static const String MIT = 'MIT';
  static const String MPL = 'MPL';
  static const String Unlicense = 'Unlicense';
  static const String unknown = 'unknown';
}

Future<List<LicenseFile>> detectLicensesInDir(String baseDir) async {
  final rootFiles = await new Directory(baseDir).list().toList();
  final licenseCandidates = rootFiles
      .where((fse) => fse is File)
      .where(_isLicenseFile)
      .take(5) // only the first 5 files are considered
      .toList();
  if (licenseCandidates.isEmpty) return [];

  final licenses = await Future.wait(licenseCandidates.map(
    (FileSystemEntity fse) {
      final relativePath = p.relative(fse.path, from: baseDir);
      return detectLicenseInFile(fse, relativePath: relativePath);
    },
  ));

  licenses.sort((l1, l2) => Comparable.compare(l1.path, l2.path));
  return licenses;
}

Future<LicenseFile> detectLicenseInFile(File file,
    {String relativePath}) async {
  var content = await file.readAsString();
  var license = detectLicenseInContent(content, relativePath: relativePath);
  return license ?? new LicenseFile(relativePath, LicenseNames.unknown);
}

LicenseFile detectLicenseInContent(String content, {String relativePath}) {
  var stripped = _longTextPrepare(content);

  String version;
  var versionMatch = _version.firstMatch(stripped);
  if (versionMatch != null) {
    version = versionMatch.group(1);
    if (version.isNotEmpty && !version.contains('.')) {
      version += '.0';
    }
  }

  if (_mpl.hasMatch(stripped)) {
    return new LicenseFile(relativePath, LicenseNames.MPL, version: version);
  }
  if (_agpl.hasMatch(stripped) && !_useWithAgpl.hasMatch(stripped)) {
    return new LicenseFile(relativePath, LicenseNames.AGPL, version: version);
  }
  if (_apache.hasMatch(stripped)) {
    return new LicenseFile(relativePath, LicenseNames.Apache, version: version);
  }
  if (_lgpl.hasMatch(stripped) && !_useLgplInstead.hasMatch(stripped)) {
    return new LicenseFile(relativePath, LicenseNames.LGPL, version: version);
  }
  if (_gplLong.hasMatch(stripped)) {
    return new LicenseFile(relativePath, LicenseNames.GPL, version: version);
  }
  if (_gplShort.hasMatch(stripped)) {
    return new LicenseFile(relativePath, LicenseNames.GPL, version: version);
  }
  if (_mit.hasMatch(stripped)) {
    return new LicenseFile(relativePath, LicenseNames.MIT, version: version);
  }
  if (_unlicense.hasMatch(stripped)) {
    return new LicenseFile(relativePath, LicenseNames.Unlicense,
        version: version);
  }

  if (_bsdPreamble.hasMatch(stripped) && _bsdEmphasis.hasMatch(stripped)) {
    return new LicenseFile(relativePath, LicenseNames.BSD);
  }

  return null;
}

final RegExp _whitespace = new RegExp('\\s+');
final RegExp _extraCharacters = new RegExp('\\"|\\\'|\\*');

final RegExp _agpl =
    new RegExp('GNU AFFERO GENERAL PUBLIC LICENSE', caseSensitive: false);
final RegExp _useWithAgpl = new RegExp(
    'Use with the GNU Affero General Public License',
    caseSensitive: false);
final RegExp _apache = new RegExp(r'Apache License', caseSensitive: false);
final RegExp _gplLong =
    new RegExp('GENERAL PUBLIC LICENSE', caseSensitive: false);
final RegExp _gplShort = new RegExp('GNU GPL', caseSensitive: false);
final RegExp _lgpl =
    new RegExp(r'GNU LESSER GENERAL PUBLIC LICENSE', caseSensitive: false);
final RegExp _useLgplInstead = new RegExp(
    'use the GNU Lesser General Public License instead',
    caseSensitive: false);
final RegExp _mit = new RegExp(r'(^|\s)MIT License', caseSensitive: false);
final RegExp _mpl = new RegExp('Mozilla Public License', caseSensitive: false);
final RegExp _unlicense = new RegExp(
    'This is free and unencumbered software released into the public domain',
    caseSensitive: true);
final RegExp _version =
    new RegExp(r'Version (\d+(\.\d*)?)', caseSensitive: false);

final RegExp _bsdPreamble = new RegExp(
    'Redistribution and use in source and binary forms, with or without '
    'modification, are permitted (\\(subject to the limitations in the disclaimer below\\) )?'
    'provided that the following conditions are met',
    caseSensitive: false);

final RegExp _bsdEmphasis = _longTextRegExp('''
THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED.
''');

bool _isLicenseFile(FileSystemEntity fse) {
  if (fse is File) {
    var relative = p.relative(fse.path, from: fse.parent.path);
    var lower = relative.toLowerCase();
    return lower == 'license' ||
        (lower.startsWith('license') &&
            (lower.endsWith('.txt') || lower.endsWith('.md')));
  }
  return false;
}

String _longTextPrepare(String text) =>
    text.replaceAll(_extraCharacters, ' ').replaceAll(_whitespace, ' ').trim();

RegExp _longTextRegExp(String text) =>
    new RegExp(_longTextPrepare(text), caseSensitive: false);
