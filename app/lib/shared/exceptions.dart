// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// This library defines all exceptions that can be handled gracefully when
/// thrown in HTTP handlers in this application.
///
/// As a rule of thumb, all exception message templates should be embedded in
/// constructors located in this file, they should be documented and
/// constructors accepting a generic message should not be exposed.
///
/// All messages may contain markdown, and should be sensible for human
/// consumption.
library exceptions;

import 'package:api_builder/api_builder.dart' show ApiResponseException;
import 'package:pub_server/repository.dart' show UnauthorizedAccessException;

/// Base class for all exceptions that are intercepted by HTTP handler wrappers.
abstract class ResponseException extends ApiResponseException {
  ResponseException._(int status, String code, String message)
      : super(status: status, code: code, message: message);

  @override
  String toString() => '$code($status): $message'; // implemented for debugging
}

/// Thrown when resource does not exist.
class NotFoundException extends ResponseException {
  NotFoundException(String message) : super._(404, 'NotFound', message);
  NotFoundException.resource(String resource)
      : super._(404, 'NotFound', 'Could not find `$resource`.');
}

/// Thrown when request input is invalid, bad payload, wrong querystring, etc.
class InvalidInputException extends ResponseException {
  InvalidInputException._(String message)
      : super._(
          400,
          'InvalidInput', // also duplicated in api_builder.dart
          message,
        );

  /// Check [condition] and throw [InvalidInputException] with [message] if
  /// [condition] is `false`.
  static void check(bool condition, String message) {
    assert(message != null, '"message" must not be `null`');
    if (!condition) {
      throw InvalidInputException._(message);
    }
  }

  /// A variant of [check] with lazy message construction.
  static void _check(bool condition, String Function() message) {
    assert(message != null, '"message" creator must not be `null`');
    assert(message() != null, '"message()" creator must not return `null`');
    if (!condition) {
      throw InvalidInputException._(message());
    }
  }

  /// Throw [InvalidInputException] if [value] is `null`.
  static void checkNotNull(dynamic value, String name) {
    assert(name != null, '"name" must not be `null`');
    _check(value != null, () => '"$name" cannot be `null`');
  }

  /// Throw [InvalidInputException] if [value] doesn't match [pattern].
  static void checkMatchPattern(String value, String name, Pattern pattern) {
    assert(name != null, '"name" must not be `null`');
    assert(pattern != null, '"pattern" must not be `null`');
    _check(pattern.allMatches(value).isNotEmpty,
        () => '"$name" must match $pattern');
  }

  /// Throw [InvalidInputException] if [value] is not one of [values].
  static void checkAnyOf<T>(T value, String name, Iterable<T> values) {
    assert(name != null, '"name" must not be `null`');
    assert(values != null, '"values" must not be `null`');
    _check(values.contains(value),
        () => '"$name" must be any of ${values.join(', ')}');
  }

  /// Throw [InvalidInputException] if [value] is less than [minimum] or greater
  /// than [maximum].
  static void checkRange<T extends num>(
    T value,
    String name, {
    T minimum,
    T maximum,
  }) {
    _check(value != null, () => '"$name" cannot be `null`');
    assert(name != null, '"name" must not be `null`');
    _check((minimum == null || value >= minimum),
        () => '"$name" must be greater than $minimum');
    _check((maximum == null || value <= maximum),
        () => '"$name" must be greater than $maximum');
  }

  /// Throw [InvalidInputException] if [value] is shorter than [minimum] or
  /// longer than [maximum].
  static void checkStringLength(
    String value,
    String name, {
    int minimum,
    int maximum,
  }) {
    _check(value != null, () => '"$name" cannot be `null`');
    assert(name != null, '"name" must not be `null`');
    assert(name != null, '"name" must not be `null`');
    _check((minimum == null || value.length >= minimum),
        () => '"$name" must be longer than $minimum charaters');
    _check((maximum == null || value.length <= maximum),
        () => '"$name" must be less than $maximum charaters');
  }

  /// Throw [InvalidInputException] if [value] is shorter than [minimum] or
  /// longer than [maximum].
  static void checkLength<T>(
    Iterable<T> value,
    String name, {
    int minimum,
    int maximum,
  }) {
    _check(value != null, () => '"$name" cannot be `null`');
    assert(name != null, '"name" must not be `null`');
    assert(name != null, '"name" must not be `null`');
    final length = value.length;
    _check((minimum == null || length >= minimum),
        () => '"$name" must be longer than $minimum');
    _check((maximum == null || length <= maximum),
        () => '"$name" must be less than $maximum');
  }
}

/// Thrown when authentication failed, credentials is missing or invalid.
class AuthenticationException extends ResponseException
    implements UnauthorizedAccessException {
  AuthenticationException._(String message)
      : super._(401, 'MissingAuthentication', message);

  /// Signaling that `authorization` header was missing.
  factory AuthenticationException.authenticationRequired() =>
      AuthenticationException._(
        'authenication is required, please add `authorization` header.',
      );

  @override
  String toString() => '$code: $message'; // used by package:pub_server
}

/// Thrown when authentication was successful, but access to resource/action
/// was forbidding because the user didn't have permission.
///
/// If encountered on the client-side this kind of errors should be surfaced
/// to the user.
///
/// Example:
///  * Modifying a package for which the user doesn't have permissions,
///  * Creating a package without domain validation.
class AuthorizationException extends ResponseException
    implements UnauthorizedAccessException {
  AuthorizationException._(String message)
      : super._(403, 'InsufficientPermissions', message);

  /// Signaling that the user is not an administrator for the given [package]
  /// and, thus, unable to execute administrative actions.
  factory AuthorizationException.userIsNotAdminForPackage(String package) =>
      AuthorizationException._(
        'Insufficient permissions to perform administrative actions on '
        'package `$package`.',
      );

  /// Signaling that the user does not have permissions to upload a new version
  /// of [package].
  factory AuthorizationException.userCannotUploadNewVersion(String package) =>
      AuthorizationException._(
        'Insufficient permissions to upload new versions of package `$package`.',
      );

  /// Signaling that the user does not have permissions to change uploaders for
  /// given [package].
  factory AuthorizationException.userCannotChangeUploaders(String package) =>
      AuthorizationException._(
        'Unsufficient permissions to change uploaders for `$package`.',
      );

  /// Signaling that the user is not an administrator for the given [publisher]
  /// and, thus, unable to execute administrative actions.
  factory AuthorizationException.userIsNotAdminForPublisher(String publisher) =>
      AuthorizationException._(
        'Insufficient permissions to perform administrative actions on '
        'package `$publisher`.',
      );

  @override
  String toString() => '$code: $message'; // used by package:pub_server
}

/// Thrown when action is conflicting with current state of a resource.
///
/// Example:
///  * Attempting to overwrite an existing resource,
///  * Conflict when running datastore transaction to change a property,
///
/// See: https://tools.ietf.org/html/rfc2616#section-10.4.10
class ConflictException extends ResponseException {
  /// Create a [ConflictException] with a [message] explaining what the conflict
  /// is and how to resolve it.
  ConflictException._(String message)
      : super._(409, 'RequestConflict', message);
}

/// Thrown when the analysis for a package is not done yet.
class MissingAnalysisException extends NotFoundException {
  MissingAnalysisException()
      : super('Analysis is not ready for the given package.');
}

/// Thrown when package or versions is missing or has flags indicating that it
/// should be removed from the search index.
class RemovedPackageException extends NotFoundException {
  RemovedPackageException() : super('Package has been removed.');
}
