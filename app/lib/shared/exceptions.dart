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
import 'package:pub_server/repository.dart'
    show GenericProcessingException, UnauthorizedAccessException;

/// Base class for all exceptions that are intercepted by HTTP handler wrappers.
abstract class ResponseException extends ApiResponseException {
  ResponseException._(int status, String code, String message)
      : super(status: status, code: code, message: message);

  @override
  String toString() => '$code($status): $message'; // implemented for debugging
}

/// Thrown when resource does not exist.
class NotFoundException extends ResponseException
    implements GenericProcessingException {
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

  /// Thrown when the parsing and/or validating of the continuation token failed.
  InvalidInputException.continuationParseError()
      : this._('Parsing the continuation token failed.');

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

  /// Throw [InvalidInputException] if [value] is not `null`.
  static void checkNull(dynamic value, String name) {
    assert(name != null, '"name" must be `null`');
    _check(value == null, () => '"$name" must be `null`');
  }

  /// Throw [InvalidInputException] if [value] is `null`.
  static void checkNotNull(dynamic value, String name) {
    assert(name != null, '"name" must not be `null`');
    _check(value != null, () => '"$name" cannot be `null`');
  }

  /// Throw [InvalidInputException] if [value] doesn't match [pattern].
  static void checkMatchPattern(String value, String name, RegExp pattern) {
    assert(name != null, '"name" must not be `null`');
    assert(pattern != null, '"pattern" must not be `null`');
    _check(pattern.hasMatch(value), () => '"$name" must match $pattern');
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
  ///
  /// This also throws if [value] is `null`.
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

  static final _ulidPattern = RegExp(r'^[a-zA-Z0-9]*$');

  static void checkUlid(String value, String name) {
    assert(name != null, '"name" must not beq `null`');
    _check(_ulidPattern.hasMatch(value), () => '"$name" is not a valid ulid.');
  }
}

/// Throws when a package upload is rejected for a reason.
class PackageRejectedException extends ResponseException
    implements GenericProcessingException {
  /// The package archive tar.gz file is above [limit] bytes.
  PackageRejectedException.archiveTooLarge(int limit)
      : super._(
            400, 'PackageRejected', 'Package archive exceeded $limit bytes.');
}

/// Thrown when the operation is rejected because of the internal state of a resource.
class OperationForbiddenException extends ResponseException
    implements GenericProcessingException {
  /// The operation tried to update the list of uploaders, but it can't be done
  /// while the package is owned by a publisher.
  OperationForbiddenException.publisherOwnedPackageNoUploader(
      String packageName, String publisherId)
      : super._(
            403,
            'OperationForbidden',
            'Package "$packageName" is owned by publisher "$publisherId". '
                'Updating the uploaders is not permitted.');
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
///  * Creating a publisher without domain validation.
class AuthorizationException extends ResponseException
    implements UnauthorizedAccessException {
  AuthorizationException._(String message)
      : super._(403, 'InsufficientPermissions', message);

  /// Signaling that the user is not an administrator for the pub site,
  /// and, thus, unable to execute administrative actions.
  factory AuthorizationException.userIsNotAdminForPubSite() =>
      AuthorizationException._(
        'Insufficient permissions to perform administrative actions on the pub site.',
      );

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

  /// Signaling that the user is not a verified owner of the [domain] for which
  /// the user is trying to create a publisher.
  factory AuthorizationException.userIsNotDomainOwner(String domain) =>
      AuthorizationException._([
        'Verification unsuccessful. To create the verified publisher $domain, ',
        'you must verify ownership of the domain $domain in the ',
        '[Google Search Console](https://search.google.com/search-console/welcome).',
        '',
        'You must verify the domain property with a **DNS record**',
        ' — verifying a _URL prefix property_ or being a collaborator on a ',
        'property that someone else has verified is not sufficient. ',
        '',
        '<b><a href="https://search.google.com/search-console/welcome" ' +
            'target="_blank">Open Google Search Console.</a></b>',
        '',
        'Once you have completed the verification step in ',
        'Google Search Console, close this dialog and re-initiate the ',
        'publisher creation step by clicking **create publisher** again.',
      ].join('\n'));

  /// Signaling that the user did not grant read-only access to the
  /// search console, making it impossible for the server to verify the users
  /// domain ownership.
  factory AuthorizationException.missingSearchConsoleReadAccess() =>
      AuthorizationException._([
        'Read-only access to Search Console data was not granted, preventing',
        '`pub.dev` from verifying that you own the domain.',
      ].join('\n'));

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

  /// The active user can't change the resource because it affects itself.
  factory ConflictException.cantUpdateSelf() =>
      ConflictException._('Can\'t update self.');

  /// The active user can't update their own role.
  factory ConflictException.cantUpdateOwnRole() =>
      ConflictException._('User can\'t update their own role.');

  /// The user is trying to create a publisher that already exists.
  factory ConflictException.publisherAlreadyExists(String domain) =>
      ConflictException._(
          'A publisher with the domain `$domain` already exists');
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

/// Thrown when API endpoint is not implemented.
class NotImplementedException extends ResponseException {
  NotImplementedException([String message])
      : super._(
            501, 'NotImplemented', message ?? 'API endpoint not implemented.');
}
