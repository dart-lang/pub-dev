import 'dart:convert';
import 'dart:io' show gzip;

import 'package:logging/logging.dart';
import 'package:path/path.dart' as p;

import 'package:pub_dev/dartdoc/dartdoc_page.dart';
import 'package:pub_dev/dartdoc/models.dart';
import 'package:pub_dev/shared/exceptions.dart';
import 'package:pub_dev/shared/handlers.dart';
import 'package:pub_dev/shared/redis_cache.dart';
import 'package:pub_dev/shared/urls.dart';
import 'package:pub_dev/task/backend.dart';
import 'package:pub_dev/task/models.dart';
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

final _logger = Logger('task.handlers');

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
    // try cached bytes first
    final htmlBytesCacheEntry =
        cache.dartdocHtmlBytes(package, resolvedDocUrlVersion.urlSegment, path);
    final htmlBytes = await htmlBytesCacheEntry.get();
    if (htmlBytes != null) {
      return htmlBytesResponse(htmlBytes);
    }

    // check cached status for redirect or missing pages
    final statusCacheEntry = cache.dartdocPageStatus(
        package, resolvedDocUrlVersion.urlSegment, path);
    final cachedStatus = await statusCacheEntry.get();
    final cachedStatusCode = cachedStatus?.code;

    shelf.Response redirectPathResponse(String redirectPath) {
      final newPath = p.normalize(p.joinAll([
        p.dirname(path),
        redirectPath,
        if (!redirectPath.endsWith('.html')) 'index.html',
      ]));
      return redirectResponse(pkgDocUrl(
        package,
        version: resolvedDocUrlVersion.urlSegment,
        relativePath: newPath,
      ));
    }

    if (cachedStatusCode == DocPageStatusCode.redirect) {
      final redirectPath = cachedStatus!.redirectPath;
      if (redirectPath == null) {
        _logger.shout('DocPageStatus redirect without path.');
        return notFoundHandler(request);
      }
      return redirectPathResponse(redirectPath);
    }

    if (cachedStatusCode == DocPageStatusCode.missing) {
      return notFoundHandler(request,
          body: cachedStatus!.errorMessage ?? 'Documentation page not found.');
    }

    // try loading bytes;
    final (status, bytes) = await () async {
      final dataGz = await taskBackend.dartdocFile(package, version, path);
      if (dataGz == null) {
        return (
          DocPageStatus(
            code: DocPageStatusCode.missing,
            errorMessage: await _missingPageErrorMessage(
              package,
              version,
              isLatestStable: resolvedDocUrlVersion.isLatestStable,
            ),
          ),
          null, // bytes
        );
      }

      try {
        final dataJson = gzippedUtf8JsonCodec.decode(dataGz);
        if (path.endsWith('-sidebar.html')) {
          final sidebar =
              DartDocSidebar.fromJson(dataJson as Map<String, dynamic>);
          return (DocPageStatus.ok(), utf8.encode(sidebar.content));
        }

        final page = DartDocPage.fromJson(dataJson as Map<String, dynamic>);

        // check for redirect page
        final redirectPath = page.redirectPath;
        if (page.isEmpty() &&
            redirectPath != null &&
            p.isRelative(redirectPath)) {
          final newPath = p.normalize(p.joinAll([
            p.dirname(path),
            redirectPath,
            if (!redirectPath.endsWith('.html')) 'index.html',
          ]));
          if (await taskBackend.hasDartdocTaskResult(
              package, version, newPath)) {
            return (DocPageStatus.redirect(redirectPath), null);
          } else {
            return (
              DocPageStatus.missing('Dartdoc redirect is missing.'),
              null, // bytes
            );
          }
        }

        final html = page.render(DartDocPageOptions(
          package: package,
          version: version,
          urlSegment: resolvedDocUrlVersion.urlSegment,
          isLatestStable: resolvedDocUrlVersion.isLatestStable,
          path: path,
          searchQueryParameter: searchQueryParameter,
        ));
        return (DocPageStatus.ok(), utf8.encode(html.toString()));
      } on FormatException catch (e, st) {
        _logger.shout(
            'Unable to parse dartdoc page for $package $version', e, st);
        return (DocPageStatus.missing('Unable to render page.'), null);
      }
    }();
    await statusCacheEntry.set(status);

    switch (status.code) {
      case DocPageStatusCode.ok:
        await htmlBytesCacheEntry.set(bytes!);
        return htmlBytesResponse(bytes);
      case DocPageStatusCode.redirect:
        return redirectPathResponse(status.redirectPath!);
      case DocPageStatusCode.missing:
        return notFoundHandler(request,
            body: status.errorMessage ?? 'Documentation page not found.');
    }
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
      'Vary': 'Accept-Encoding', // body depends on accept-encoding!
      if (acceptsGzip) 'Content-Encoding': 'gzip',
    },
  );
}

Future<String> _missingPageErrorMessage(
  String package,
  String version, {
  required bool isLatestStable,
}) async {
  final status = await taskBackend.packageStatus(package);
  final vs = status.versions[version];
  if (vs == null) {
    return isLatestStable
        ? 'Analysis has not started yet.'
        : 'Version not selected for analysis.';
  }
  String? message;
  switch (vs.status) {
    case PackageVersionStatus.pending:
    case PackageVersionStatus.running:
      message = 'Analysis has not finished yet.';
      break;
    case PackageVersionStatus.failed:
      message = 'Analysis has failed, no `dartdoc` output has been generated.';
      break;
    case PackageVersionStatus.completed:
      message = '`dartdoc` did not generate this page.';
      break;
  }
  return message;
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
      'Vary': 'Accept-Encoding',
    },
  );
}
