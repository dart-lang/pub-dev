// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'urls.dart';

const pubDartlangOrgEmail = 'noreply@pub.dev';
final _lenientEmailRegExp = RegExp(r'^\S+@\S+\.\S+$');

/// Strict regular expression used in <input type="email" />
/// https://html.spec.whatwg.org/multipage/input.html#valid-e-mail-address
final _strictEmailRegExp = RegExp(
    r'''[a-zA-Z0-9.!#$%&'*+\/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$''');

final _defaultFrom = EmailAddress(
  'Dart package site admin',
  pubDartlangOrgEmail,
);

String _footer(String action) {
  return '''If you have any concerns about this $action, contact support@pub.dev

Thanks for your contributions to the Dart community!

With appreciation, the Dart package site admin''';
}

/// Represents a parsed email address.
class EmailAddress {
  final String? name;
  final String? email;

  EmailAddress(this.name, this.email);

  bool get isEmpty => name == null && email == null;

  @override
  String toString() {
    if (isEmpty) return '';
    if (email == null) return name ?? '';
    if (name == null) return email ?? '';
    return '$name <$email>';
  }
}

/// Checks the minimal accepted format for an email.
///
/// This function only disallows the most obvious non-email strings.
/// It still allows strings that aren't legal email  addresses.
///
/// Known use cases:
/// - Parsing e-mail field in `pubspec.yaml`.
/// - Checking that the response from the OAuth provider is not garbage.
/// - Internal integrity check for the most obvious failures.
bool looksLikeEmail(String? email) {
  if (email == null) return false;
  if (email.length < 5) return false;
  if (email.contains('..')) return false;
  final lc = email.toLowerCase();
  if (lc.startsWith('mailto:') ||
      lc.startsWith('http:') ||
      lc.startsWith('https:')) {
    return false;
  }
  return _lenientEmailRegExp.hasMatch(email);
}

/// Checks the email with strict match patterns.
///
/// Known use cases:
/// - Inviting new uploader (before sending out e-mail).
/// - Inviting a new member for the publisher (before sending out e-mail).
/// - Updating the publisher's contact e-mail (before sending out e-mail).
bool isValidEmail(String email) {
  // quick surface check
  if (!looksLikeEmail(email)) return false;

  // strict pattern check
  if (!_strictEmailRegExp.hasMatch(email)) return false;

  // checking for IPv4 or IPv6 addresses
  var isInternetAddress = false;
  try {
    InternetAddress(email.split('@').last);
    isInternetAddress = true;
  } catch (_) {
    // ignore
  }
  return !isInternetAddress;
}

/// Represents an email message the site will send.
class EmailMessage {
  final EmailAddress from;
  final List<EmailAddress> recipients;
  final String subject;
  final String bodyText;

  EmailMessage(this.from, this.recipients, this.subject, String bodyText)
      : bodyText = reflowBodyText(bodyText);
}

/// Parses the body text and splits the [input] paragraphs to [lineLength]
/// character long lines.
String reflowBodyText(String input, {int lineLength = 72}) {
  Iterable<String> reflowLine(String line) sync* {
    if (line.isEmpty) {
      yield line;
      return;
    }
    while (line.length > lineLength) {
      int firstSpace = line.lastIndexOf(' ', lineLength);
      if (firstSpace < 20) {
        firstSpace = line.indexOf(' ', lineLength);
      }
      if (firstSpace != -1) {
        yield line.substring(0, firstSpace);
        line = line.substring(firstSpace).trim();
      } else {
        yield line;
        return;
      }
    }
    if (line.isNotEmpty) {
      yield line;
    }
  }

  return input.split('\n').expand(reflowLine).join('\n');
}

/// Creates the [EmailMessage] that we be sent on new package upload.
EmailMessage createPackageUploadedEmail({
  required String packageName,
  required String packageVersion,
  required String agentEmailOrLabel,
  required List<EmailAddress> authorizedUploaders,
}) {
  final url =
      pkgPageUrl(packageName, version: packageVersion, includeHost: true);
  final subject = 'Package uploaded: $packageName $packageVersion';
  final bodyText = '''Dear package maintainer,  

$agentEmailOrLabel has published a new version ($packageVersion) of the $packageName package to the Dart package site ($primaryHost).

For details, go to $url

${_footer('package')}
''';

  return EmailMessage(_defaultFrom, authorizedUploaders, subject, bodyText);
}

/// Creates the [EmailMessage] that will be sent to users about new invitations
/// they need to confirm.
EmailMessage createInviteEmail({
  required String invitedEmail,
  required String subject,
  required String inviteText,
  required String consentUrl,
}) {
  final bodyText = '''Dear Dart developer,

$inviteText

To accept this invitation, visit the following URL:
$consentUrl

If you don’t want to accept it, simply ignore this email.

${_footer('invitation')}
''';
  return EmailMessage(
      _defaultFrom, [EmailAddress(null, invitedEmail)], subject, bodyText);
}

/// Creates the [EmailMessage] that we be sent on package transfer to a new publisher.
EmailMessage createPackageTransferEmail({
  required String packageName,
  required String activeUserEmail,
  required String? oldPublisherId,
  required String newPublisherId,
  required List<EmailAddress> authorizedAdmins,
}) {
  final url = pkgPageUrl(packageName, includeHost: true);
  final subject = 'Package transferred: $packageName to $newPublisherId';
  final actionLine = [
    activeUserEmail,
    'has transferred the $packageName package',
    if (oldPublisherId != null) 'from the publisher $oldPublisherId',
    'to the publisher $newPublisherId.',
  ].join(' ');
  final bodyText = '''Dear package maintainer,  

$actionLine

For details, go to $url

${_footer('transfer')}
''';

  return EmailMessage(_defaultFrom, authorizedAdmins, subject, bodyText);
}
