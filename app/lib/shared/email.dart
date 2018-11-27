// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

final _nameEmailRegExp = new RegExp(r'^(.*)<(.+@.+)>$');

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
