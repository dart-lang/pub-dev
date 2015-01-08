// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library pubserver.shelf_pubserver;

import 'dart:async';
import 'dart:convert';

import 'package:mime/mime.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:shelf/shelf.dart' as shelf;
import 'package:yaml/yaml.dart';

import 'repository.dart';

// TODO: Error handling from [PackageRepo] class.
/// A shelf handler for serving a pub [PackageRepository].
///
/// The following API endpoints are provided by this shelf handler:
///
///   * /api/packages/<package-name>
///     [200 OK] [Content-Type: application/json]
///     {
///       "name" : "<package-name>",
///       "latest" : { ...},
///       "versions" : [
///         {
///           "version" : "<version>",
///           "archive_url" : "<download-url tar.gz>",
///           "pubspec" : {
///             "author" : ...,
///             "dependencies" : { ... },
///             ...
///           },
///         },
///         ...
///       ],
///     }
///     or
///     [404 Not Found]
///
///   * /api/packages/<package-name>/versions/<version-name>
///     [200 OK] [Content-Type: application/json]
///     {
///       "version" : "<version>",
///       "archive_url" : "<download-url tar.gz>",
///       "pubspec" : {
///         "author" : ...,
///         "dependencies" : { ... },
///         ...
///       },
///     }
///     or
///     [404 Not Found]
///
///   * /api/packages/<package-name>/versions/<version-name>.tar.gz
///     [200 OK] [Content-Type: octet-stream ??? FIXME ???]
///     or
///     [302 Found / Temporary Redirect] [Location: <new-location>]
///     or
///     [404 Not Found]
///
///   * /api/packages/versions/new
///
///   *
/// It will use the pub [PackageRepository] given in the constructor to provide
/// this HTTP endpoint.
class ShelfPubServer {
  static final RegExp _packageRegexp =
      new RegExp(r'^/api/packages/([^/]+)$');

  static final RegExp _versionRegexp =
      new RegExp(r'^/api/packages/([^/]+)/versions/([^/]+)$');

  static final RegExp _downloadRegexp =
      new RegExp(r'^/packages/([^/]+)/versions/([^/]+)\.tar\.gz$');

  static final RegExp _boundaryRegExp = new RegExp(r'^.*boundary="([^"]+)"$');


  final PackageRepository repository;

  ShelfPubServer(this.repository);


  Future<shelf.Response> requestHandler(shelf.Request request) {
    String path = request.requestedUri.path;
    if (request.method == 'GET') {
      var downloadMatch = _downloadRegexp.matchAsPrefix(path);
      if (downloadMatch != null) {
        var package = Uri.decodeComponent(downloadMatch.group(1));
        var version = Uri.decodeComponent(downloadMatch.group(2));
        return _download(request.requestedUri, package, version);
      }

      var packageMatch = _packageRegexp.matchAsPrefix(path);
      if (packageMatch != null) {
        var package = Uri.decodeComponent(packageMatch.group(1));
        return _listVersions(request.requestedUri, package);
      }

      var versionMatch = _versionRegexp.matchAsPrefix(path);
      if (versionMatch != null) {
        var package = Uri.decodeComponent(versionMatch.group(1));
        var version = Uri.decodeComponent(versionMatch.group(2));
        return _showVersion(request.requestedUri, package, version);
      }

      if (path == '/api/packages/versions/new') {
        if (repository.supportsAsyncUpload) {
          return _startUploadAsync(request.requestedUri);
        } else {
          return _startUploadCustom(request.requestedUri);
        }
      }

      if (path == '/api/packages/versions/newUploadFinish') {
        if (repository.supportsAsyncUpload) {
          return _finishUploadAsync(request.requestedUri);
        } else {
          return _finishUploadCustom(request.requestedUri);
        }
      }
    } else if (request.method == 'POST') {
      if (path == '/api/packages/versions/newUpload') {
        return _uploadCustom(
            request.requestedUri,
            request.headers['content-type'],
            request.read());
      }
    }
    return new Future.value(new shelf.Response.notFound(''));
  }


  // Metadata handlers.

  Future<shelf.Response> _listVersions(Uri uri, String package) {
    return repository.versions(package).toList()
        .then((List<PackageVersion> packageVersions) {
      if (packageVersions.length == 0) {
        return new shelf.Response.notFound('');
      }

      packageVersions.sort((a, b) {
        return a.version.compareTo(b.version);
      });

      // TODO: Add legacy entries (if necessary), such as version_url.
      Map packageVersion2Json(PackageVersion version) {
        return {
          'archive_url':
              '${_downloadUrl(
                  uri, version.packageName, version.versionString)}',
          'pubspec': loadYaml(version.pubspecYaml),
          'version': version.versionString,
        };
      }
      // TODO: The 'latest' is something we should get rid of, since it's
      // duplicated in 'versions'.
      return {
        'name' : package,
        'latest' : packageVersion2Json(packageVersions.last),
        'versions' : packageVersions.map(packageVersion2Json).toList(),
      };
    }).then(_jsonResponse);
  }

  Future<shelf.Response> _showVersion(Uri uri, String package, String version) {
    return repository
        .versions(package)
        .where((pv) => pv.versionString == version)
        .toList().then((versions) {
          if (versions.length == 0) {
            return new shelf.Response.notFound('');
          }

          var version = versions.first;
          // TODO: Add legacy entries (if necessary), such as version_url.
          return {
            'archive_url':
                '${_downloadUrl(
                    uri, version.packageName, version.versionString)}',
            'pubspec': loadYaml(version.pubspecYaml),
            'version': version.versionString,
          };
    }).then(_jsonResponse);
  }


  // Download handlers.

  Future<shelf.Response> _download(Uri uri, String package, String version) {
    if (repository.supportsDownloadUrl) {
      return repository.downloadUrl(package, version).then((Uri url) {
        // This is a redirect to [url]
        return new shelf.Response.seeOther(url);
      });
    }
    return repository.download(package, version).then((stream) {
      return new shelf.Response.ok(stream);
    });
  }


  // Upload async handlers.

  Future<shelf.Response> _startUploadAsync(Uri uri) {
    return repository.startAsyncUpload(_finishUploadAsyncUrl(uri))
        .then((AsyncUploadInfo info) {
      return _jsonResponse({
        'url' : '${info.uri}',
        'fields' : info.headers,
      });
    });
  }

  Future<shelf.Response> _finishUploadAsync(Uri uri) {
    return repository.finishAsyncUpload(uri).then((_) {
      return _jsonResponse({
        'success' : {
          'message' : 'Successfully uploaded package.',
        },
      });
    });
  }


  // Upload custom handlers.

  Future<shelf.Response> _startUploadCustom(Uri url) {
    return _jsonResponse({
      'url' : '${_uploadCustomUrl(url)}',
      'fields' : {},
    });
  }

  Future<shelf.Response> _uploadCustom(
      Uri uri, String contentType, Stream<List<int>> stream) {
    if (contentType.startsWith('multipart/form-data')) {
      var match = _boundaryRegExp.matchAsPrefix(contentType);
      if (match != null) {
        var boundary = match.group(1);
        return stream
            .transform(new MimeMultipartTransformer(boundary))
            .first.then((MimeMultipart part) {
          // TODO: Ensure that `part.headers['content-disposition']` is
          // `form-data; name="file"; filename="package.tar.gz`
          return repository.upload(part).then((_) {
            return new shelf.Response.found(_finishUploadCustomUrl(uri));
          });
        });
      }
    }
    return
        _badRequest('Upload must contain a multipart/form-data content type.');
  }

  Future<shelf.Response> _finishUploadCustom(Uri uri) {
    return _jsonResponse({
      'success' : {
        'message' : 'Successfully uploaded package.',
      },
    });
  }


  // Helper functions.

  Future<shelf.Response> _badRequest(String message) {
    return new Future.value(new shelf.Response(
        400,
        body: JSON.encode({ 'error' : message }),
        headers: {'content-type': 'application/json'}));
  }

  Future<shelf.Response> _jsonResponse(Map json) {
    return new Future.value(new shelf.Response.ok(
        JSON.encode(json),
        headers: {'content-type': 'application/json'}));
  }


  // Metadata urls.

  Uri _packageUrl(Uri url, String package) {
    var encode = Uri.encodeComponent;
    return url.resolve('/api/packages/${encode(package)}');
  }


  // Download urls.

  Uri _downloadUrl(Uri url, String package, String version) {
    var encode = Uri.encodeComponent;
    return url.resolve(
        '/packages/${encode(package)}/versions/${encode(version)}.tar.gz');
  }


  // Upload async urls.

  Uri _startUploadAsyncUrl(Uri url) {
    var encode = Uri.encodeComponent;
    return url.resolve('/api/packages/versions/new');
  }

  Uri _finishUploadAsyncUrl(Uri url) {
    var encode = Uri.encodeComponent;
    return url.resolve('/api/packages/versions/newUploadFinish');
  }


  // Upload custom urls.

  Uri _uploadCustomUrl(Uri url) {
    var encode = Uri.encodeComponent;
    return url.resolve('/api/packages/versions/newUpload');
  }

  Uri _finishUploadCustomUrl(Uri url) {
    var encode = Uri.encodeComponent;
    return url.resolve('/api/packages/versions/newUploadFinish');
  }
}
