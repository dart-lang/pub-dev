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
import 'package:pub_semver/pub_semver.dart';

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

  /// Thrown when the parsing and/or validating of the continuation token failed.
  InvalidInputException.continuationParseError()
      : this._('Parsing the continuation token failed.');

  /// Thrown when the canonicalization of the [version] failed.
  InvalidInputException.canonicalizeVersionError(String version)
      : this._('Unable to canonicalize the version: $version');

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

  /// Throw [InvalidInputException] if [value] doesn't match [regExp].
  static void checkMatchPattern(String value, String name, RegExp regExp) {
    assert(name != null, '"name" must not be `null`');
    assert(regExp != null, '"pattern" must not be `null`');
    _check(regExp.hasMatch(value), () => '"$name" must match $regExp');
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
        () => '"$name" must be less than $maximum');
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

  static void checkSemanticVersion(String version) {
    checkNotNull(version, 'version');
    try {
      Version.parse(version);
    } on FormatException catch (_) {
      throw InvalidInputException._(
          'Version string "$version" is not a valid semantic version.');
    }
  }
}

/// Throws when a package upload is rejected for a reason.
class PackageRejectedException extends ResponseException {
  PackageRejectedException(String message)
      : super._(400, 'PackageRejected', message);

  /// The package archive tar.gz file is above [limit] bytes.
  PackageRejectedException.archiveTooLarge(int limit)
      : super._(
            400, 'PackageRejected', 'Package archive exceeded $limit bytes.');

  /// The package archive tar.gz file is empty, possibly an error happened
  /// during the upload or the system was unable to create an archive.
  PackageRejectedException.archiveEmpty()
      : super._(400, 'PackageRejected', 'Package archive is empty (size = 0).');

  /// The [package] name is reserved.
  PackageRejectedException.nameReserved(String package)
      : super._(400, 'PackageRejected', 'Package name $package is reserved.');

  /// The [package] has an existing [version].
  PackageRejectedException.versionExists(String package, String version)
      : super._(400, 'PackageRejected',
            'Version $version of package $package already exists.');

  /// Check [condition] and throw [PackageRejectedException] with [message] if
  /// [condition] is `false`.
  static void check(bool condition, String message) {
    if (!condition) throw PackageRejectedException(message);
  }
}

/// Thrown when the operation is rejected because of the internal state of a resource.
class OperationForbiddenException extends ResponseException {
  /// The operation tried to update the list of uploaders, but it can't be done
  /// while the package is owned by a publisher.
  OperationForbiddenException.publisherOwnedPackageNoUploader(
      String packageName, String publisherId)
      : super._(
            403,
            'OperationForbidden',
            'Package "$packageName" is owned by publisher "$publisherId". '
                'Updating the uploaders is not permitted.');

  /// The operation tried to send an invite to a user, but it can't be done
  /// immediately, as we don't want to spam the users.
  OperationForbiddenException.inviteActive(DateTime nextNotification)
      : super._(
            403,
            'OperationForbidden',
            'Previous invite is still active, next notification can be sent '
                'on ${nextNotification.toIso8601String()}.');

  /// The uploader has been invited, but the operation can't complete until they
  /// accept it.
  OperationForbiddenException.uploaderInviteSent(String email)
      : super._(403, 'OperationForbidden',
            'We have sent an invitation to $email, they will be added as uploader after they confirm it.');

  /// The user tried to remove themselves from the list of uploaders and we
  /// don't allow that.
  OperationForbiddenException.selfRemovalNotAllowed()
      : super._(403, 'OperationForbidden',
            'Self-removal is not allowed. Use another account to remove this email address.');

  /// The user tried to remove the last uploader of the package, and we don't
  /// allow that.
  OperationForbiddenException.lastUploaderRemoveError()
      : super._(403, 'OperationForbidden',
            'Cannot remove last uploader of a package.');
}

/// Thrown when authentication failed, credentials is missing or invalid.
class AuthenticationException extends ResponseException {
  AuthenticationException._(String message)
      : super._(401, 'MissingAuthentication', message);

  /// Signaling that `authorization` header was missing.
  factory AuthenticationException.authenticationRequired() =>
      AuthenticationException._(
          'Authenication is required, please add `authorization` header.');

  /// Signaling that `accessToken` payload was missing or could not be authenticated.
  factory AuthenticationException.accessTokenInvalid() =>
      AuthenticationException._('Invalid `accessToken`.');

  /// Signaling that `accessToken` resolved to a different OAuth `userId`.
  factory AuthenticationException.accessTokenMissmatch() =>
      AuthenticationException._(
          '`accessToken` does not match current active user.');

  /// Signaling that User lookup (via e-mail) failed.
  factory AuthenticationException.userNotFound() =>
      AuthenticationException._('User not found.');

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
class AuthorizationException extends ResponseException {
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
        '<b><a href="https://search.google.com/search-console/welcome" '
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
