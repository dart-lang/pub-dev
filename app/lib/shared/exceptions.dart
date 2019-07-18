// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

export 'package:pub_server/repository.dart' show UnauthorizedAccessException;

/// Generic exception indicating that one of the inputs references to an entity
/// that doesn't exists anymore.
class NotFoundException implements Exception {
  final String message;
  NotFoundException([this.message]);

  @override
  String toString() => '$runtimeType: $message';
}

/// Exception when a package does not have its analysis yet.
class MissingAnalysisException extends NotFoundException {}

/// Exception when a package or a version is missing, or has other flags that
/// indicate it should be removed from the search index.
class RemovedPackageException extends NotFoundException {}
