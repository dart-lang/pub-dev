// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

final RegExp identifierExpr = RegExp(r'^[a-zA-Z0-9_]+$');
final RegExp startsWithLetterOrUnderscore = RegExp(r'^[a-zA-Z_]');
const reservedWords = <String>{
  'abstract',
  'as',
  'assert',
  // 'async', // reserved, but allowed because package:async already exists.
  'await',
  'break',
  'case',
  'catch',
  'class',
  'const',
  'continue',
  'covariant',
  'default',
  'deferred',
  'do',
  'dynamic',
  'else',
  'enum',
  'export',
  'extends',
  'extension',
  'external',
  'factory',
  'false',
  'final',
  'finally',
  'for',
  'get',
  'hide',
  'if',
  'implements',
  'import',
  'in',
  'interface',
  'is',
  'late',
  'library',
  'mixin',
  'new',
  'null',
  'of',
  'on',
  'operator',
  'part',
  'required',
  'rethrow',
  'return',
  'set',
  'show',
  'static',
  'super',
  'switch',
  'sync',
  'this',
  'throw',
  'true',
  'try',
  'typedef',
  'var',
  'void',
  // 'when', // reserved, but allowed because package:when already exists.
  'while',
  'with',
  'yield',
};

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
