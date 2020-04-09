// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library pub_server.shelf_pubserver;

import 'dart:async';
import 'dart:convert' as convert;

import 'package:logging/logging.dart';
import 'package:shelf/shelf.dart' as shelf;

import '../../package/backend.dart' show purgePackageCache;
import '../../shared/exceptions.dart';
import '../../shared/redis_cache.dart' show cache;

import 'repository.dart';

final Logger _logger = Logger('pubserver.shelf_pubserver');

/// It will use the pub [PackageRepository] given in the constructor to provide
/// this HTTP endpoint.
class ShelfPubServer {
  final PackageRepository repository;

  ShelfPubServer(this.repository);

  // Upload async handlers.

  Future<shelf.Response> finishUploadAsync(Uri uri) async {
    try {
      final vers = await repository.finishAsyncUpload(uri);
      if (cache != null) {
        _logger.info('Invalidating cache for package ${vers.packageName}.');
        await purgePackageCache(vers.packageName);
      }
      return _jsonResponse({
        'success': {
          'message': 'Successfully uploaded package.',
        },
      });
    } on ResponseException catch (error, stack) {
      _logger.info('A problem occured while finishing upload.', error, stack);
      // [ResponseException] is pass-through, no need to do anything here.
      rethrow;
    } catch (error, stack) {
      _logger.warning('An error occured while finishing upload.', error, stack);
      return _jsonResponse({
        'error': {
          'message': '$error.',
        },
      }, status: 500);
    }
  }

  // Helper functions.

  shelf.Response _jsonResponse(Map json, {int status = 200}) =>
      shelf.Response(status,
          body: convert.json.encode(json),
          headers: {'content-type': 'application/json'});
}
