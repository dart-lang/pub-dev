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
library;

import 'dart:io';

import 'package:api_builder/api_builder.dart' show ApiResponseException;
import 'package:pub_dev/shared/utils.dart';

/// Base class for all exceptions that are intercepted by HTTP handler wrappers.
abstract class ResponseException extends ApiResponseException {
  ResponseException._(
    int status,
    String code,
    String message, {
    super.body,
    super.headers,
  }) : super(
          status: status,
          code: code,
          message: message,
        );

  @override
  String toString() => '$code($status): $message'; // implemented for debugging
}

/// Thrown when resource does not exist.
class NotFoundException extends ResponseException {
  NotFoundException(String message) : super._(404, 'NotFound', message);
  NotFoundException.resource(String resource)
      : super._(404, 'NotFound', 'Could not find `$resource`.');
}

/// Thrown when request is not acceptable.
class NotAcceptableException extends ResponseException {
  NotAcceptableException(String message)
      : super._(406, 'NotAcceptable', message);
}

/// Thrown when part of the underlying analysis task has been aborted.
class TaskAbortedException extends ResponseException {
  TaskAbortedException(String message) : super._(400, 'TaskAborted', message);
}

/// Thrown when request input is invalid, bad payload, wrong querystring, etc.
class InvalidInputException extends ResponseException {
  InvalidInputException._(String message)
      : super._(
          400,
          'InvalidInput', // also duplicated in api_builder.dart
          message,
        );

  InvalidInputException(String message) : this._(message);

  /// Thrown when the parsing and/or validating of the continuation token failed.
  InvalidInputException.continuationParseError()
      : this._('Parsing the continuation token failed.');

  /// Thrown when the canonicalization of the [version] failed.
  InvalidInputException.canonicalizeVersionError(String version)
      : this._('Unable to canonicalize the version: $version');

  /// Thrown when the [version] is in a non-canonical form.
  InvalidInputException.nonCanonicalVersion(
      String version, String canonicalVersion)
      : this._(
            'Version is not in canonical form: "$version", use "$canonicalVersion" instead.');

  /// Check [condition] and throw [InvalidInputException] with [message] if
  /// [condition] is `false`.
  static void check(bool condition, String message) {
    if (!condition) {
      throw InvalidInputException._(message);
    }
  }

  /// A variant of [check] with lazy message construction.
  static void _check(bool condition, String Function() message) {
    if (!condition) {
      throw InvalidInputException._(message());
    }
  }

  /// Throw [InvalidInputException] if [value] is not `null`.
  static void checkNull(dynamic value, String name) {
    _check(value == null, () => '"$name" must be `null`');
  }

  /// Throw [InvalidInputException] if [value] is `null`.
  static void checkNotNull(dynamic value, String? name) {
    assert(name != null, '"name" must not be `null`');
    _check(value != null, () => '"$name" cannot be `null`');
  }

  /// Throw [InvalidInputException] if [value] doesn't match [regExp].
  static void checkMatchPattern(String value, String? name, RegExp? regExp) {
    assert(name != null, '"name" must not be `null`');
    assert(regExp != null, '"pattern" must not be `null`');
    _check(regExp!.hasMatch(value), () => '"$name" must match $regExp');
  }

  /// Throw [InvalidInputException] if [value] is not one of [values].
  static void checkAnyOf<T>(T value, String? name, Iterable<T>? values) {
    assert(name != null, '"name" must not be `null`');
    assert(values != null, '"values" must not be `null`');
    _check(values!.contains(value),
        () => '"$name" must be any of ${values.join(', ')}');
  }

  /// Throw [InvalidInputException] if [value] is less than [minimum] or greater
  /// than [maximum].
  static void checkRange<T extends num>(
    T? value,
    String? name, {
    T? minimum,
    T? maximum,
  }) {
    _check(value != null, () => '"$name" cannot be `null`');
    assert(name != null, '"name" must not be `null`');
    _check((minimum == null || value! >= minimum),
        () => '"$name" must be greater than $minimum');
    _check((maximum == null || value! <= maximum),
        () => '"$name" must be less than $maximum');
  }

  /// Throw [InvalidInputException] if [value] is shorter than [minimum] or
  /// longer than [maximum].
  ///
  /// This also throws if [value] is `null`.
  static void checkStringLength(
    String? value,
    String? name, {
    int? minimum,
    int? maximum,
  }) {
    _check(value != null, () => '"$name" cannot be `null`');
    assert(name != null, '"name" must not be `null`');
    assert(name != null, '"name" must not be `null`');
    _check((minimum == null || value!.length >= minimum),
        () => '"$name" must be longer than $minimum characters');
    _check((maximum == null || value!.length <= maximum),
        () => '"$name" must be less than $maximum characters');
  }

  /// Throw [InvalidInputException] if [value] is shorter than [minimum] or
  /// longer than [maximum].
  static void checkLength<T>(
    Iterable<T>? value,
    String? name, {
    int? minimum,
    int? maximum,
  }) {
    _check(value != null, () => '"$name" cannot be `null`');
    assert(name != null, '"name" must not be `null`');
    assert(name != null, '"name" must not be `null`');
    final length = value!.length;
    _check((minimum == null || length >= minimum),
        () => '"$name" must be longer than $minimum');
    _check((maximum == null || length <= maximum),
        () => '"$name" must be less than $maximum');
  }

  // note: base32-ulid is 26 characters long, base16-based ulid may be 32 or 36 characters long.
  static final _ulidPattern = RegExp(r'^[a-zA-Z0-9]{26,36}$');

  static void checkUlid(String value, String? name) {
    assert(name != null, '"name" must not be `null`');
    _check(_ulidPattern.hasMatch(value), () => '"$name" is not a valid ulid.');
  }

  /// Pattern for both new and existing package names.
  ///
  /// This allows upper-case characters in package names, because that exist in
  /// some existing packages.
  static final _packageNamePattern = RegExp(r'^[a-zA-Z_][a-zA-Z0-9_]*$');

  /// Throw [InvalidInputException] if [package] is not an allowed package name.
  static void checkPackageName(String? package) {
    // TODO: Reuse logic from validatePackageName in pub_package_reader.dart
    //       This is for new and existing packages! Not only new packages!
    checkNotNull(package, 'package');
    checkStringLength(package!, 'package', minimum: 1, maximum: 64);
    checkMatchPattern(package, 'package', _packageNamePattern);
  }

  /// Throw [InvalidInputException] if [version] is not a valid semantic version
  /// or if canonicalizing the version fails.
  ///
  /// Returns the canonicalized version.
  static String checkSemanticVersion(String? version) {
    checkNotNull(version, 'version');
    final canonicalVersion = canonicalizeVersion(version);
    if (canonicalVersion == null) {
      throw InvalidInputException._(
          'Version string "$version" is not a valid semantic version.');
    }
    return canonicalVersion;
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

  /// The package archive file seems to be an invalid tar.gz
  PackageRejectedException.invalidTarGz()
      : super._(400, 'PackageRejected',
            'Package archive is not a valid `.tar.gz`.');

  /// The package archive file contains a broken symlink (outside of the archive
  /// or file does not exists).
  PackageRejectedException.brokenSymlink(String source, String target)
      : super._(400, 'PackageRejected',
            'Package archive contains a broken symlink: `$source` -> `$target`.');

  /// The [package] name is reserved.
  PackageRejectedException.nameReserved(String package)
      : super._(400, 'PackageRejected', 'Package name $package is reserved.');

  /// The [package] is similar to an active package.
  PackageRejectedException.similarToActive(
      String package, String conflicting, String url)
      : super._(400, 'PackageRejected',
            'Package name `$package` is too similar to another active package: `$conflicting` ($url).');

  /// The [package] is similar to a moderated or withdrawn package.
  PackageRejectedException.similarToModerated(
      String package, String conflicting)
      : super._(400, 'PackageRejected',
            'Package name `$package` is too similar to a moderated package: `$conflicting`.');

  /// The [package] has reached or has more versions than [limit].
  PackageRejectedException.maxVersionCountReached(String package, int limit)
      : super._(
            400,
            'PackageRejected',
            'Package `$package` has reached the maximum version limit of `$limit`. '
                'Please contact "support@pub.dev".');

  /// The [package] has an existing [version].
  PackageRejectedException.versionExists(String package, String version)
      : super._(400, 'PackageRejected',
            'Version $version of package $package already exists.');

  /// The [package] had an existing [version], but was deleted.
  PackageRejectedException.versionDeleted(String package, String version)
      : super._(400, 'PackageRejected',
            'Version $version of package $package was deleted previously, re-upload is not allowed.');

  /// The package has an active `isBlocked` flag, no further version is allowed.
  PackageRejectedException.isBlocked()
      : super._(400, 'PackageRejected', 'Package has been blocked.');

  /// The site has restricted package uploads.
  PackageRejectedException.uploadRestricted()
      : super._(400, 'PackageRejected',
            'Uploads are restricted. Please try again later.');

  /// The upload would create a new package, but the authenticated agent is an automated
  /// account, not a user.
  PackageRejectedException.onlyUsersAreAllowedToUploadNewPackages()
      : super._(400, 'PackageRejected',
            'Only users are allowed to upload new packages.');

  /// The package has a dependency that does not exist (or not visible).
  PackageRejectedException.dependencyDoesNotExists(String name)
      : super._(400, 'PackageRejected', 'Dependency `$name` does not exist.');

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

  /// Thrown on API calls from the `pub` client using `uploaders add` or `uploaders remove`.
  OperationForbiddenException.pubToolUploaderNotSupported({
    required String adminPageUrl,
  }) : super._(
          403,
          'OperationForbidden',
          'pub.dev site no longer supports adding/removing uploaders through the `pub` tool.\n'
              'Use the package admin page to manage uploaders:\n'
              '$adminPageUrl',
        );
}

/// Thrown when the operation is rejected because a rate limit is reached.
class RateLimitException extends ResponseException {
  RateLimitException({
    required String operation,
    required int maxCount,
    required String windowAsText,
    required Duration window,
  }) : super._(
          429,
          'RateLimit',
          'The "$operation" operation is blocked, as its rate limit '
              'has been reached ($maxCount in the $windowAsText). '
              'Please try again later. '
              'Please report the issue on https://github.com/dart-lang/pub-dev/issues/new '
              'if you think the limit should be increased to accommodate your use case.',
          headers: {
            'Retry-After': '${window.inSeconds}',
          },
        );
}

/// Thrown when authentication failed, credentials is missing or invalid.
class AuthenticationException extends ResponseException {
  AuthenticationException._(
    String message, {
    Map<String, Object>? headers,
  }) : super._(
          401,
          'MissingAuthentication',
          message,
          headers: {
            ..._wwwAuthenticateHeaders(message),
            ...?headers,
          },
        );

  /// Signaling that `authorization` header was missing.
  factory AuthenticationException.authenticationRequired() =>
      AuthenticationException._(
          'Authentication is required, please add `authorization` header.');

  /// Signaling that `accessToken` payload was missing or could not be authenticated.
  factory AuthenticationException.accessTokenInvalid() =>
      AuthenticationException._('Invalid `accessToken`.');

  /// Signaling that the JWT token was missing a field or could not be authenticated.
  factory AuthenticationException.tokenInvalid(String message) =>
      AuthenticationException._('Invalid JWT token: $message.');

  /// Signaling that `accessToken` resolved to a different OAuth `userId`.
  factory AuthenticationException.accessTokenMismatch() =>
      AuthenticationException._(
          '`accessToken` does not match current active user.');

  /// Signaling that `authorization` header or the session cookie
  /// has bad value or is expired.
  factory AuthenticationException.failed([String? message]) =>
      AuthenticationException._([
        'Authentication failed.',
        if (message != null) message,
      ].join(' '));

  /// Signaling that User lookup (via e-mail) failed.
  factory AuthenticationException.userNotFound() =>
      AuthenticationException._('User not found.');

  /// Signaling that cookie values provided by the client are invalid.
  factory AuthenticationException.cookieInvalid({
    Map<String, Object>? headers,
  }) =>
      AuthenticationException._(
        'Browser cookie invalid.',
        headers: headers,
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
class AuthorizationException extends ResponseException {
  AuthorizationException._(String message)
      : super._(
          403,
          'InsufficientPermissions',
          message,
          headers: _wwwAuthenticateHeaders(message),
        );

  /// Signaling that the user is blocked.
  factory AuthorizationException.blocked() =>
      AuthorizationException._('User is blocked.');

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
  factory AuthorizationException.userCannotUploadNewVersion(
          String email, String package) =>
      AuthorizationException._(
        '`$email` has insufficient permissions to upload new versions to '
        'existing package `$package`.',
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

  /// Signaling that the GitHub JWT token could not
  /// be authorized with the current configuration.
  factory AuthorizationException.githubActionIssue(String reason) =>
      AuthorizationException._(
          'The calling GitHub Action is not allowed to publish, because: $reason.\nSee https://dart.dev/go/publishing-from-github');

  /// Signaling that the Google Cloud Service account JWT token could not
  /// be authorized with the current configuration.
  factory AuthorizationException.serviceAccountPublishingIssue(String reason) =>
      AuthorizationException._(
          'The calling service account is not allowed to publish, because: $reason.\nSee https://dart.dev/go/publishing-with-service-account');

  @override
  String toString() => '$code: $message'; // used by package:pub_server
}

/// Thrown when an operation requires extra scope.
class ScopeNeededException extends ResponseException {
  ScopeNeededException({
    required String location,
    required String message,
  }) : super._(
          401,
          'ScopeNeeded',
          message,
          body: {
            'go': location,
          },
        );
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

/// Thrown when package or versions is missing or has flags indicating that it
/// should be removed from the search index.
class RemovedPackageException extends NotFoundException {
  RemovedPackageException() : super('Package has been removed.');
}

/// Thrown when package, versions, user or publisher is moderated.
class ModeratedException extends NotFoundException {
  ModeratedException.package(String package)
      : super('Package "$package" has been moderated.');

  ModeratedException.packageVersion(String package, String version)
      : super('PackageVersion "$package" "$version" has been moderated.');

  ModeratedException.publisher(String publisherId)
      : super('Publisher "$publisherId" has been moderated.');
}

/// Thrown when API endpoint is not implemented.
class NotImplementedException extends ResponseException {
  NotImplementedException([String? message])
      : super._(
            501, 'NotImplemented', message ?? 'API endpoint not implemented.');
}

/// Thrown when the email sender encounters a problem.
class EmailSenderException extends ResponseException {
  /// The email was rejected by the server, possibly because of a formatting
  /// issue or other validation.
  EmailSenderException.invalid()
      : super._(400, 'InvalidEmail',
            'Failed to send email, check that the email address is valid.');

  /// The SMTP gateway failed to accept the message, may be a transient
  /// infrastructure issue.
  EmailSenderException.failed()
      : super._(500, 'EmailSenderFailed',
            'Failed to send email, please retry later.');
}

final _whitespaces = RegExp(r'\s+');

Map<String, String> _wwwAuthenticateHeaders(String message) {
  // Escaping HTTP header as follows:
  // - replace double quote with single quote
  // - replace whitespaces with space
  // - only allow printable ASCII, and replace everything with whitespace
  // - at-most 1024 characters
  final escaped = String.fromCharCodes(message
          .replaceAll('"', "'")
          .runes
          .map((r) => 32 <= r && r <= 127 ? r : 32)
          .take(1024))
      .replaceAll(_whitespaces, ' ');

  return {
    HttpHeaders.wwwAuthenticateHeader: 'Bearer realm="pub", message="$escaped"',
  };
}
