// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
import 'dart:async';
import 'dart:io';

import 'package:build/build.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart' as p;
import 'package:shelf/shelf.dart';

import '../generate/build_result.dart';
import '../generate/watch_impl.dart';

Future<ServeHandler> createServeHandler(WatchImpl watch) async {
  var rootPackage = watch.packageGraph.root.name;
  var assetHandler = new AssetHandler(await watch.reader, rootPackage);
  return new ServeHandler._(watch, assetHandler);
}

class ServeHandler implements BuildState {
  final BuildState _state;
  final AssetHandler _assetHandler;

  ServeHandler._(this._state, this._assetHandler);

  @override
  Future<BuildResult> get currentBuild => _state.currentBuild;
  @override
  Stream<BuildResult> get buildResults => _state.buildResults;

  Future<Response> handle(Request request) async {
    await currentBuild;
    return _assetHandler.handle(request);
  }
}

class AssetHandler {
  final AssetReader _reader;
  final String _rootPackage;

  final _typeResolver = new MimeTypeResolver();

  AssetHandler(this._reader, this._rootPackage);

  Future<Response> handle(Request request) {
    var pathSegments = request.url.pathSegments;
    if (request.url.path.endsWith('/')) {
      pathSegments = new List.from(pathSegments)..add('index.html');
    }
    return _handle(pathSegments);
  }

  Future<Response> _handle(List<String> pathSegments) async {
    var packagesIndex = pathSegments.indexOf('packages');
    var assetId = packagesIndex >= 0
        ? new AssetId(pathSegments[packagesIndex + 1],
            p.join('lib', p.joinAll(pathSegments.sublist(packagesIndex + 2))))
        : new AssetId(_rootPackage, p.joinAll(pathSegments));
    try {
      if (!await _reader.canRead(assetId)) {
        return new Response.notFound('Not Found');
      }
    } on ArgumentError catch (_) {
      return new Response.notFound('Not Found');
    }
    var bytes = await _reader.readAsBytes(assetId);
    var headers = {
      HttpHeaders.CONTENT_LENGTH: '${bytes.length}',
      HttpHeaders.CONTENT_TYPE: _typeResolver.lookup(assetId.path)
    };
    return new Response.ok(bytes, headers: headers);
  }
}
