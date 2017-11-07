// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
class ConcurrentBuildException implements Exception {
  const ConcurrentBuildException();

  @override
  String toString() =>
      'ConcurrentBuildException: Only one build may be running at a time.';
}

abstract class FatalBuildException implements Exception {
  const FatalBuildException();
}

class UnexpectedExistingOutputsException extends FatalBuildException {
  const UnexpectedExistingOutputsException();

  @override
  String toString() => 'UnexpectedExistingOutputsException: Either you opted '
      'not to delete existing files, or you are not running in interactive '
      'mode and did not specify `deleteFilesByDefault` as `true`.';
}

class InvalidBuildActionException extends FatalBuildException {
  final String _reason;

  const InvalidBuildActionException.nonRootPackage()
      : _reason =
            'A build action is attempting to operate on a package which is not '
            'the root.';

  @override
  String toString() => 'InvalidBuildActionException: $_reason';
}
