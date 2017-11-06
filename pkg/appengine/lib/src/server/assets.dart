// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library appengine.assets;

import 'dart:async';
import 'dart:io';

import 'package:http_server/http_server.dart' show VirtualDirectory;
import 'package:path/path.dart' show normalize;

import '../appengine_context.dart';
import '../client_context.dart';

class AssetsManager {
  static final root = 'build/web';

  final Uri pubServeUrl;
  final bool usePubServe;
  final client = new HttpClient();
  final VirtualDirectory vd = new VirtualDirectory(root);

  AssetsManager(Uri pubServeUrl, bool isDevEnvironment)
      : usePubServe = isDevEnvironment && pubServeUrl != null,
        pubServeUrl = pubServeUrl;

  Future _proxyToPub(HttpRequest request, String path) {
    const RESPONSE_HEADERS = const [
        HttpHeaders.CONTENT_LENGTH,
        HttpHeaders.CONTENT_TYPE ];

    var uri = pubServeUrl.resolve(path);
    return client.openUrl(request.method, uri)
        .then((proxyRequest) {
          proxyRequest.headers.removeAll(HttpHeaders.ACCEPT_ENCODING);
          return proxyRequest.close();
        })
        .then((proxyResponse) {
          proxyResponse.headers.forEach((name, values) {
            if (RESPONSE_HEADERS.contains(name)) {
              request.response.headers.set(name, values);
            }
          });
          request.response.statusCode = proxyResponse.statusCode;
          request.response.reasonPhrase = proxyResponse.reasonPhrase;
          return proxyResponse.pipe(request.response);
        })
        .catchError((e) {
          // TODO(kevmoo) Use logging here
          print("Unable to connect to 'pub serve' for '${request.uri}': $e");
          throw new AssetError(
              "Unable to connect to 'pub serve' for '${request.uri}': $e");
        });
  }

  Future _serveFromFile(HttpRequest request, String path) {
    // Check if the request path is pointing to a static resource.
    path = normalize(path);
    return FileSystemEntity.isFile(root + path).then((exists) {
      if (exists) {
        vd.serveFile(new File(root + path), request);
      } else {
        return _serve404(request);
      }
    });
  }

  Future<Stream<List<int>>> _readFromPub(String path) {
    var uri = pubServeUrl.resolve(path);
    return client.openUrl('GET', uri)
        .then((request) => request.close())
        .then((response) {
          if (response.statusCode == HttpStatus.OK) {
            return response;
          } else {
            throw new AssetError(
                "Failed to fetch asset '$path' from pub: "
                "${response.statusCode}.");
          }
        })
        .catchError((error) {
          if (error is! AssetError) {
            error = new AssetError(
                "Failed to fetch asset '$path' from pub: '${path}': $error");
          }
          throw error;
        });
  }

  Future<Stream<List<int>>> _readFromFile(String path) {
    path = normalize(path);
    return FileSystemEntity.isFile(root + path).then((exists) {
      if (exists) {
        return new File(root + path).openRead();
      } else {
        throw new AssetError("Asset '$path' not found");
      }
    });
  }

  Future _serve404(HttpRequest request) {
    // Serve 404.
    return request.drain().then((_) {
      request.response.statusCode = HttpStatus.NOT_FOUND;
      return request.response.close();
    });
  }

  Future<Stream<List<int>>> read(String path) {
    if (usePubServe) {
      return _readFromPub(path);
    } else {
      return _readFromFile(path);
    }
  }

  Future serve(HttpRequest request, String path) {
    if (usePubServe) {
      return _proxyToPub(request, path);
    } else {
      return _serveFromFile(request, path);
    }
  }
}

class AssetsImpl implements Assets {
  final HttpRequest request;
  final AppengineContext appengineContext;

  AssetsImpl(this.request, this.appengineContext);

  Future<Stream<List<int>>> read([String path]) {
    return appengineContext.assets.read(
        path == null ? request.uri.path : path);
  }

  void serve([String path]) {
    appengineContext.assets.serve(request,
        path == null ? request.uri.path : path);
  }
}
