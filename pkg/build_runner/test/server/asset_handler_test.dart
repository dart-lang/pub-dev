// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:shelf/shelf.dart';
import 'package:test/test.dart';

import 'package:build_runner/src/server/server.dart';

import '../common/common.dart';

void main() {
  AssetHandler handler;
  InMemoryRunnerAssetReader reader;

  setUp(() async {
    reader = new InMemoryRunnerAssetReader();
    handler = new AssetHandler(reader, 'a');
  });

  test('can read from the root package', () async {
    reader.cacheStringAsset(makeAssetId('a|web/index.html'), 'content');
    var response = await handler.handle(
        new Request('GET', Uri.parse('http://server.com/web/index.html')));
    expect(await response.readAsString(), 'content');
  });

  test('can read from dependencies', () async {
    reader.cacheStringAsset(makeAssetId('b|lib/b.dart'), 'content');
    var response = await handler.handle(
        new Request('GET', Uri.parse('http://server.com/packages/b/b.dart')));
    expect(await response.readAsString(), 'content');
  });

  test('can read from dependencies nested under top-level dir', () async {
    reader.cacheStringAsset(makeAssetId('b|lib/b.dart'), 'content');
    var response = await handler.handle(new Request(
        'GET', Uri.parse('http://server.com/web/packages/b/b.dart')));
    expect(await response.readAsString(), 'content');
  });

  test('defaults to index.html if URI ends with slash', () async {
    reader.cacheStringAsset(makeAssetId('a|web/index.html'), 'content');
    var response = await handler
        .handle(new Request('GET', Uri.parse('http://server.com/web/')));
    expect(await response.readAsString(), 'content');
  });

  test('does not default to index.html if URI does not end in slash', () async {
    reader.cacheStringAsset(makeAssetId('a|web/index.html'), 'content');
    var response = await handler
        .handle(new Request('GET', Uri.parse('http://server.com/web')));
    expect(response.statusCode, 404);
  });
}
