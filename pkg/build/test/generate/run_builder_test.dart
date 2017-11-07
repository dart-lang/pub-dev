// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('vm')
import 'dart:async';

import 'package:build_test/build_test.dart';
import 'package:test/test.dart';

import 'package:build/build.dart';
import 'package:build/src/generate/run_builder.dart';

main() {
  InMemoryAssetWriter writer;
  InMemoryAssetReader reader;
  final primary = makeAssetId('a|web/primary.txt');
  final inputs = {
    primary: 'foo',
  };
  Resource resource;
  bool resourceDisposed;
  Builder builder;

  setUp(() async {
    resourceDisposed = false;
    resource = new Resource(() => 0, dispose: (_) {
      resourceDisposed = true;
    });
    builder = new FetchingCopyBuilder(resource);
    writer = new InMemoryAssetWriter();
    reader = new InMemoryAssetReader(sourceAssets: writer.assets);
    addAssets(inputs, writer);
  });

  group('Given a ResourceManager', () {
    TrackingResourceManager resourceManager;

    setUp(() async {
      resourceManager = new TrackingResourceManager();
      await runBuilder(builder, inputs.keys, reader, writer, null,
          resourceManager: resourceManager);
    });

    tearDown(() async {
      await resourceManager.disposeAll();
    });

    test('uses the provided resource manager', () async {
      expect(resourceManager.fetchedResources, orderedEquals([resource]));
    });

    test('doesn\'t dispose the provided resource manager', () async {
      expect(resourceDisposed, false);
      expect(resourceManager.disposed, false);
      // sanity check
      await resourceManager.disposeAll();
      expect(resourceDisposed, true);
      expect(resourceManager.disposed, true);
    });
  });

  group('With a default ResourceManager', () {
    setUp(() async {
      await runBuilder(builder, inputs.keys, reader, writer, null);
    });

    test('disposes the default resource manager', () async {
      expect(resourceDisposed, true);
    });
  });
}

class TrackingResourceManager extends ResourceManager {
  bool disposed = false;
  final fetchedResources = new Set<Resource>();

  @override
  Future<T> fetch<T>(Resource<T> resource) {
    fetchedResources.add(resource);
    return super.fetch(resource);
  }

  @override
  Future<Null> disposeAll() {
    disposed = true;
    return super.disposeAll();
  }
}

class FetchingCopyBuilder<T> extends CopyBuilder {
  final Resource<T> resourceToFetch;

  FetchingCopyBuilder(this.resourceToFetch) : super();

  @override
  Future build(BuildStep buildStep) async {
    await super.build(buildStep);
    await buildStep.fetchResource(resourceToFetch);
  }
}
