// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// TODO(nweiz): Avoid importing dart:io directly when cross-platform libraries
// exist.
import 'dart:io';
import 'dart:isolate';
import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:package_config/packages_file.dart' as packages_file;

/// Loads the configuration map from [uri].
///
/// This supports `http`, `file`, `data`, and `package` URIs. If [client] is
/// passed and an HTTP request is needed, it's used to make that request;
/// otherwise, a default client is used.
Future<Map<String, Uri>> loadConfigMap(Uri uri, {http.Client client}) async {
  var resolved = Uri.base.resolveUri(uri);

  var text;
  if (resolved.scheme == 'http') {
    text = await (client == null
        ? http.read(resolved)
        : client.read(resolved));
  } else if (resolved.scheme == 'file') {
    var path = resolved.toFilePath(windows: Platform.isWindows);
    text = await new File(path).readAsString();
  } else if (resolved.scheme == 'data') {
    text = resolved.data.contentAsString();
  } else if (resolved.scheme == 'package') {
    return loadConfigMap(await Isolate.resolvePackageUri(uri),
        client: client);
  } else {
    throw new UnsupportedError(
        'PackageInfo.loadConfig doesn\'t support URI scheme "${uri.scheme}:".');
  }

  return packages_file.parse(UTF8.encode(text), resolved);
}

/// Converts [uri] to a [Uri] and verifies that it's a valid `package:` URI.
///
/// Throws an [ArgumentError] if [uri] isn't a [String] or a [Uri]. [name] is
/// used as the argument name in that error.
///
/// Throws a [FormatException] if [uri] isn't a `package:` URI or doesn't have
/// at least one path segment.
Uri asPackageUri(uri, String name) {
  uri = asUri(uri, name);

  if (uri.scheme != 'package') {
    throw new FormatException("Can only resolve a package: URI.",
        uri.toString(), 0);
  } else if (uri.pathSegments.isEmpty) {
    throw new FormatException("Expected package name.",
        uri.toString(), "package:".length);
  }

  return uri;
}

/// Converts [uri] to a [Uri].
///
/// Throws an [ArgumentError] if [uri] isn't a [String] or a [Uri]. [name] is
/// used as the argument name in that error.
Uri asUri(uri, String name) {
  if (uri is Uri) return uri;
  if (uri is String) return Uri.parse(uri);

  throw new ArgumentError.value(uri, name, "Must be a String or a Uri.");
}

/// Returns a copy of [uri] with a trailing slash.
///
/// If [uri] already ends in a slash, returns it as-is.
Uri ensureTrailingSlash(Uri uri) {
  if (uri.pathSegments.isEmpty) return uri.replace(path: "/");
  if (uri.pathSegments.last.isEmpty) return uri;
  return uri.replace(pathSegments: uri.pathSegments.toList()..add(""));
}
