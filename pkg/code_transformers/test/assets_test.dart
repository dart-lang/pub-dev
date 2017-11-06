// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('vm')
library code_transformers.test.assets_test;

import 'dart:async';

import 'package:barback/barback.dart';
import 'package:code_transformers/assets.dart';
import 'package:transformer_test/utils.dart';
import 'package:test/test.dart';

main() {
  group('uriToAssetId', uriToAssetIdTests);
  group('assetIdToUri', assetIdToUriTests);
}

void assetIdToUriTests() {
  void testAssetIdToUri(String name, AssetId assetId,
      {String result, AssetId from, String message}) {
    test(name, () {
      var transformer = new Validator((transform) {
        var uriOut = assetIdToUri(assetId,
            logger: transform.logger, span: null, from: from);
        expect(uriOut, result);
      });
      var messages = <String>[];
      if (message != null) messages.add(message);

      return applyTransformers([
        [transformer]
      ], inputs: {
        assetId.toString(): ''
      }, messages: messages);
    });
  }

  testAssetIdToUri('resolves relative URIs', new AssetId('a', 'web/main.dart'),
      result: 'main.dart', from: new AssetId('a', 'web/foo.dart'));

  testAssetIdToUri('resolves relative URIs in subfolders',
      new AssetId('a', 'web/foo/main.dart'),
      result: 'foo/main.dart', from: new AssetId('a', 'web/foo.dart'));

  testAssetIdToUri('resolves package: URIs', new AssetId('foo', 'lib/foo.dart'),
      result: 'package:foo/foo.dart');

  testAssetIdToUri(
      'resolves package: URIs from libs', new AssetId('foo', 'lib/foo.dart'),
      result: 'package:foo/foo.dart', from: new AssetId('a', 'lib/main.dart'));

  testAssetIdToUri(
      'resolves packages paths', new AssetId('foo', 'lib/foo.dart'),
      from: new AssetId('a', 'web/main.dart'), result: 'package:foo/foo.dart');

  testAssetIdToUri('resolves relative packages paths',
      new AssetId('foo', 'lib/src/bar.dart'),
      from: new AssetId('foo', 'lib/foo.dart'),
      result: 'package:foo/src/bar.dart');

  testAssetIdToUri('does not allow non-lib assets without specifying `from`',
      new AssetId('foo', 'not-lib/foo.dart'),
      message: 'warning: Cannot create URI for foo|not-lib/foo.dart without '
          'specifying where to import it from.');

  testAssetIdToUri('does not allow non-lib, non-relative assets',
      new AssetId('foo', 'not-lib/foo.dart'),
      from: new AssetId('bar', 'lib/bar.dart'),
      message: 'warning: Not possible to import foo|not-lib/foo.dart from '
          'bar|lib/bar.dart');
}

void uriToAssetIdTests() {
  void testAssetUri(String name,
      {AssetId source,
      String uri,
      AssetId result,
      String message,
      bool errorOnAbsolute: true}) {
    test(name, () {
      var transformer = new Validator((transform) {
        var assetId = uriToAssetId(source, uri, transform.logger, null,
            errorOnAbsolute: errorOnAbsolute);
        expect(assetId, result);
      });
      var messages = <String>[];
      if (message != null) messages.add(message);

      return applyTransformers([
        [transformer]
      ], inputs: {
        source.toString(): ''
      }, messages: messages);
    });
  }

  testAssetUri('resolves relative URIs',
      source: new AssetId('a', 'web/main.dart'),
      uri: 'foo.dart',
      result: new AssetId('a', 'web/foo.dart'));

  testAssetUri('resolves package: URIs',
      source: new AssetId('a', 'web/main.dart'),
      uri: 'package:foo/foo.dart',
      result: new AssetId('foo', 'lib/foo.dart'));

  testAssetUri('resolves package: URIs from libs',
      source: new AssetId('a', 'lib/main.dart'),
      uri: 'package:foo/foo.dart',
      result: new AssetId('foo', 'lib/foo.dart'));

  testAssetUri('resolves packages paths',
      source: new AssetId('a', 'web/main.dart'),
      uri: 'packages/foo/foo.dart',
      result: new AssetId('foo', 'lib/foo.dart'));

  testAssetUri('resolves relative packages paths',
      source: new AssetId('a', 'web/main.dart'),
      uri: '../lib/foo.dart',
      result: new AssetId('a', 'lib/foo.dart'));

  testAssetUri('does not allow packages from non-dart lib files',
      source: new AssetId('a', 'lib/index.html'),
      uri: 'packages/foo/bar',
      message: 'warning: Invalid URL to reach to another package: '
          'packages/foo/bar. Path reaching to other packages must first '
          'reach up all the way to the packages directory. For example, try '
          'changing the URL to: ../../packages/foo/bar');

  testAssetUri('allows relative packages from non-dart lib files',
      source: new AssetId('a', 'lib/index.html'),
      uri: '../../packages/foo/bar',
      result: new AssetId('foo', 'lib/bar'));

  testAssetUri('does not allow package: imports from non-dart files',
      source: new AssetId('a', 'lib/index.html'),
      uri: 'package:foo/bar.dart',
      message: 'warning: absolute paths not allowed: "package:foo/bar.dart"');

  testAssetUri('does not allow absolute /packages by default',
      source: new AssetId('a', 'lib/index.html'),
      uri: '/packages/foo/bar.dart',
      message: 'warning: absolute paths not allowed: "/packages/foo/bar.dart"');

  testAssetUri('can suppress error on absolute /packages ',
      source: new AssetId('a', 'lib/index.html'),
      uri: '/packages/foo/bar.dart',
      errorOnAbsolute: false,
      result: null);
}

class Validator extends Transformer {
  final Function validation;

  Validator(this.validation);

  Future apply(Transform transform) {
    return new Future.value(validation(transform));
  }
}
