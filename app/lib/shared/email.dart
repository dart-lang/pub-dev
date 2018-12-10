// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:meta/meta.dart';

final _nameEmailRegExp = new RegExp(r'^(.*)<(.+@.+)>$');
final _defaultFrom = new EmailAddress('Pub Site Admin', 'pub@dartlang.org');

/// Represents a parsed e-mail address.
class EmailAddress {
  final String name;
  final String email;

  EmailAddress(this.name, this.email);

  factory EmailAddress.parse(String value) {
    value = value.trim();
    String name = value;
    String email;

    final match = _nameEmailRegExp.matchAsPrefix(value);
    if (match != null) {
      name = match.group(1).trim();
      email = match.group(2).trim();
    } else if (value.contains('@')) {
      final List<String> parts = value.split(' ');
      for (int i = 0; i < parts.length; i++) {
        if (parts[i].contains('@') &&
            parts[i].contains('.') &&
            parts[i].length > 4) {
          email = parts[i];
          parts.removeAt(i);
          name = parts.join(' ');
          break;
        }
      }
    }
    if (name != null && name.isEmpty) {
      name = null;
    }
    if (email != null && email.isEmpty) {
      email = null;
    }
    return new EmailAddress(name, email);
  }

  bool get isEmpty => name == null && email == null;

  @override
  String toString() {
    if (isEmpty) return null;
    if (email == null) return name;
    if (name == null) return email;
    return '$name <$email>';
  }
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
  @required String packageName,
  @required String packageVersion,
  @required String uploaderEmail,
  @required List<EmailAddress> authorizedUploaders,
}) {
  final subject = 'Package upload on pub: $packageName $packageVersion';
  final bodyText = '''Dear package maintainer,

$uploaderEmail uploaded a new version of package $packageName: $packageVersion

If you think this is a mistake or fraud, file an issue on GitHub:
https://github.com/dart-lang/pub-dartlang-dart/issues

Pub Site Admin
''';

  return new EmailMessage(_defaultFrom, authorizedUploaders, subject, bodyText);
}

/// Creates the [EmailMessage] that will be sent to the new uploader for confirmation.
EmailMessage createUploaderConfirmationEmail({
  @required String packageName,
  @required String activeAccountEmail,
  @required String addedUploaderEmail,
  @required String confirmationUrl,
}) {
  final subject = 'Pub invitation to collaborate: $packageName';
  final bodyText = '''Dear package maintainer,

$activeAccountEmail invited you to collaborate on $packageName and added you as uploader. You can see the package on the following URL:
https://pub.dartlang.org/packages/$packageName

If you want to accept the invitation, click on the following URL:
$confirmationUrl

If you think this is a mistake or fraud, file an issue on GitHub:
https://github.com/dart-lang/pub-dartlang-dart/issues

Pub Site Admin
''';

  return new EmailMessage(_defaultFrom,
      [new EmailAddress(null, addedUploaderEmail)], subject, bodyText);
}
