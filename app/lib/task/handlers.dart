import 'dart:io' show gzip;

import 'package:mime/mime.dart';
import 'package:pub_dev/shared/exceptions.dart';
import 'package:pub_dev/shared/handlers.dart';
import 'package:pub_dev/task/backend.dart';
import 'package:shelf/shelf.dart' as shelf;

Future<shelf.Response> handleDartDoc(
  shelf.Request request,
  String package,
  String version,
  String path,
) async {
  InvalidInputException.checkPackageName(package);
  InvalidInputException.checkSemanticVersion(version);

  final bytes = await taskBackend.dartdocPage(package, version, path);
  if (bytes == null) {
    return notFoundHandler(request);
  }

  final mime = lookupMimeType(path, headerBytes: bytes);
  // TODO: Avoid gzip decoding when client accepts gzip.
  return shelf.Response.ok(gzip.decode(bytes), headers: {
    // TODO: Add cache headers
    'Content-Type': mime ?? 'application/octect',
  });
}
