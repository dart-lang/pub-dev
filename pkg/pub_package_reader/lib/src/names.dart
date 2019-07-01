// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

final RegExp identifierExpr = RegExp(r'^[a-zA-Z0-9_]+$');
final RegExp startsWithLetterOrUnderscore = RegExp(r'^[a-zA-Z_]');
const List<String> reservedWords = <String>[
  'assert',
  'break',
  'case',
  'catch',
  'class',
  'const',
  'continue',
  'default',
  'do',
  'else',
  'extends',
  'false',
  'final',
  'finally',
  'for',
  'if',
  'in',
  'is',
  'mixin',
  'new',
  'null',
  'return',
  'super',
  'switch',
  'this',
  'throw',
  'true',
  'try',
  'var',
  'void',
  'while',
  'with',
];

const knownMixedCasePackages = <String>{
  'Autolinker',
  'Babylon',
  'DartDemoCLI',
  'FileTeCouch',
  'Flutter_Nectar',
  'Google_Search_v2',
  'LoadingBox',
  'PolymerIntro',
  'Pong',
  'RAL',
  'Transmission_RPC',
  'ViAuthClient',
};
const knownGoodLowerCasePackages = [
  'babylon',
];
final blockedLowerCasePackages = knownMixedCasePackages
    .map((s) => s.toLowerCase())
    .toSet()
      ..removeAll(knownGoodLowerCasePackages);

final invalidHostNames = const <String>[
  '-',
  '--',
  '---',
  '..',
  '...',
  'example.com',
  'example.org',
  'example.net',
  'google.com',
  'www.example.com',
  'www.example.org',
  'www.example.net',
  'www.google.com',
  'none',
];
