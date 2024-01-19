import 'dart:convert';
import 'dart:io' show gzip;

import 'package:pub_dev/dartdoc/dartdoc_page.dart';
import 'package:pub_dev/dartdoc/models.dart';
import 'package:pub_dev/package/backend.dart';
import 'package:pub_dev/shared/exceptions.dart';
import 'package:pub_dev/shared/handlers.dart';
import 'package:pub_dev/shared/redis_cache.dart';
import 'package:pub_dev/shared/urls.dart';
import 'package:pub_dev/task/backend.dart';
import 'package:shelf/shelf.dart' as shelf;

const _safeMimeTypes = {
  // Binary image files are generally safe to serve
  'avif': 'image/avif',
  'avi': 'video/x-msvideo',
  'bmp': 'image/bmp',
  'gif': 'image/gif',
  'ico': 'image/vnd.microsoft.icon',
  'jpeg': 'image/jpeg',
  'jpg': 'image/jpeg',
  'mp4': 'video/mp4',
  'mpeg': 'video/mpeg',
  'ogv': 'video/ogg',
  'png': 'image/png',
  'webm': 'video/webm',
  'webp': 'image/webp',
  // JSON files are generally safe to serve
  'json': 'application/json',
  // .tar.gz archive of dartdoc contents
  'gz': 'application/octet-stream',

  // Following mimetypes can contain scripts and contents should be sanitized
  // before we serve contents of such files.
  //   'html: 'text/html',
  //   'svg': 'image/svg+xml',
  // We should always be careful about adding new mimetypes here.
  // If it's not safe to proxy the mimetype from an untrusted source, then we
  // should not add it here.
};

Future<shelf.Response> handleDartDoc(
  shelf.Request request,
  String package,
  ResolvedDocUrlVersion resolvedDocUrlVersion,
  String path,
) async {
  InvalidInputException.checkPackageName(package);
  final version =
      InvalidInputException.checkSemanticVersion(resolvedDocUrlVersion.version);

  final isSearch = path == 'search.html';
  String? searchQueryParameter;
  if (isSearch) {
    // Redirect to documentation root when there is no query parameter, or when there
    // are further parameters than `q`.
    final paramKeys = request.requestedUri.queryParameters.keys.toList();
    if (paramKeys.isEmpty || paramKeys.length > 1 || paramKeys.single != 'q') {
      return redirectResponse(pkgDocUrl(
        package,
        version: resolvedDocUrlVersion.urlSegment,
      ));
    }

    // Redirect to documentation root when the query parameter is empty.
    searchQueryParameter = request.requestedUri.queryParameters['q']!.trim();
    if (searchQueryParameter.isEmpty) {
      return redirectResponse(pkgDocUrl(
        package,
        version: resolvedDocUrlVersion.urlSegment,
      ));
    }
  }

  final ext = path.split('.').last;

  // Handle HTML requests
  final isHtml = ext == 'html';
  if (isHtml) {
    final htmlBytes = await cache
        .dartdocHtmlBytes(package, resolvedDocUrlVersion.urlSegment, path)
        .get(() async {
      try {
        final dataGz = await taskBackend.dartdocFile(package, version, path);
        if (dataGz == null) {
          return const <int>[]; // store empty string for missing data
        }
        final dataJson = gzippedUtf8JsonCodec.decode(dataGz);
        if (path.endsWith('-sidebar.html')) {
          final sidebar =
              DartDocSidebar.fromJson(dataJson as Map<String, dynamic>);
          return utf8.encode(sidebar.content);
        }
        final latestVersion = await packageBackend.getLatestVersion(package);
        final page = DartDocPage.fromJson(dataJson as Map<String, dynamic>);
        final html = page.render(DartDocPageOptions(
          package: package,
          version: version,
          urlSegment: resolvedDocUrlVersion.urlSegment,
          isLatestStable: version == latestVersion,
          path: path,
          searchQueryParameter: searchQueryParameter,
        ));
        return utf8.encode(html.toString());
      } on FormatException {
        // store empty string for invalid data, we treat it as a bug in
        // the documentation generation.
        return const <int>[];
      }
    });
    // We use empty string to indicate missing file or bug in the file
    if (htmlBytes == null || htmlBytes.isEmpty) {
      return notFoundHandler(request);
    }
    return htmlBytesResponse(htmlBytes);
  }

  // Handle any non-HTML request
  final mime = _safeMimeTypes[ext];
  if (mime == null) {
    // TODO: Communicate that this file type is not allowed!
    // Probably we should just do this in pub_worker and write something in the log
    return notFoundHandler(request);
  }

  final dataGz = await taskBackend.dartdocFile(package, version, path);
  if (dataGz == null) {
    return notFoundHandler(request);
  }

  if (request.method.toUpperCase() == 'HEAD') {
    return htmlResponse('');
  }

  final acceptsGzip = request.acceptsGzipEncoding();
  return shelf.Response.ok(
    acceptsGzip ? dataGz : gzip.decode(dataGz),
    headers: {
      'Content-Type': mime,
      if (acceptsGzip) 'Content-Encoding': 'gzip',
    },
  );
}

/// Handles GET `/packages/<package>/versions/<version>/gen-res/<path|[^]*>`
Future<shelf.Response> handleTaskResource(
  shelf.Request request,
  String package,
  String version,
  String path,
) async {
  InvalidInputException.checkPackageName(package);
  version = InvalidInputException.checkSemanticVersion(version);

  final ext = path.split('.').last;

  // Handle any non-HTML request
  final mime = _safeMimeTypes[ext];
  if (mime == null) {
    // TODO: Communicate that this file type is not allowed!
    // Probably we should just do this in pub_worker and write something in the log
    return notFoundHandler(request);
  }

  final dataGz = await taskBackend.gzippedTaskResult(
    package,
    version,
    'resources/$path',
  );
  if (dataGz == null) {
    return notFoundHandler(request);
  }

  if (request.method.toUpperCase() == 'HEAD') {
    return htmlResponse('');
  }

  final acceptsGzip = request.acceptsGzipEncoding();
  return shelf.Response.ok(
    acceptsGzip ? dataGz : gzip.decode(dataGz),
    headers: {
      'Content-Type': mime,
      if (acceptsGzip) 'Content-Encoding': 'gzip',
    },
  );
}
