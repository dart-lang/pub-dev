// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// Utility methods used by more than one library in the package.
library package_config.util;

import "package:charcode/ascii.dart";

// All ASCII characters that are valid in a package name, with space
// for all the invalid ones (including space).
const String _validPackageNameCharacters =
    r"                                 !  $ &'()*+,-. 0123456789 ; =  "
    r"@ABCDEFGHIJKLMNOPQRSTUVWXYZ    _ abcdefghijklmnopqrstuvwxyz   ~ ";

/// Tests whether something is a valid Dart package name.
bool isValidPackageName(String string) {
  return _findInvalidCharacter(string) < 0;
}

/// Check if a string is a valid package name.
///
/// Valid package names contain only characters in [_validPackageNameCharacters]
/// and must contain at least one non-'.' character.
///
/// Returns `-1` if the string is valid.
/// Otherwise returns the index of the first invalid character,
/// or `string.length` if the string contains no non-'.' character.
int _findInvalidCharacter(String string) {
  // Becomes non-zero if any non-'.' character is encountered.
  int nonDot = 0;
  for (int i = 0; i < string.length; i++) {
    var c = string.codeUnitAt(i);
    if (c > 0x7f || _validPackageNameCharacters.codeUnitAt(c) <= $space) {
      return i;
    }
    nonDot += c ^ $dot;
  }
  if (nonDot == 0) return string.length;
  return -1;
}

/// Validate that a Uri is a valid package:URI.
String checkValidPackageUri(Uri packageUri) {
  if (packageUri.scheme != "package") {
    throw new ArgumentError.value(
        packageUri, "packageUri", "Not a package: URI");
  }
  if (packageUri.hasAuthority) {
    throw new ArgumentError.value(
        packageUri, "packageUri", "Package URIs must not have a host part");
  }
  if (packageUri.hasQuery) {
    // A query makes no sense if resolved to a file: URI.
    throw new ArgumentError.value(
        packageUri, "packageUri", "Package URIs must not have a query part");
  }
  if (packageUri.hasFragment) {
    // We could leave the fragment after the URL when resolving,
    // but it would be odd if "package:foo/foo.dart#1" and
    // "package:foo/foo.dart#2" were considered different libraries.
    // Keep the syntax open in case we ever get multiple libraries in one file.
    throw new ArgumentError.value(
        packageUri, "packageUri", "Package URIs must not have a fragment part");
  }
  if (packageUri.path.startsWith('/')) {
    throw new ArgumentError.value(
        packageUri, "packageUri", "Package URIs must not start with a '/'");
  }
  int firstSlash = packageUri.path.indexOf('/');
  if (firstSlash == -1) {
    throw new ArgumentError.value(packageUri, "packageUri",
        "Package URIs must start with the package name followed by a '/'");
  }
  String packageName = packageUri.path.substring(0, firstSlash);
  int badIndex = _findInvalidCharacter(packageName);
  if (badIndex >= 0) {
    if (packageName.isEmpty) {
      throw new ArgumentError.value(
          packageUri, "packageUri", "Package names mus be non-empty");
    }
    if (badIndex == packageName.length) {
      throw new ArgumentError.value(packageUri, "packageUri",
          "Package names must contain at least one non-'.' character");
    }
    assert(badIndex < packageName.length);
    int badCharCode = packageName.codeUnitAt(badIndex);
    var badChar = "U+" + badCharCode.toRadixString(16).padLeft(4, '0');
    if (badCharCode >= 0x20 && badCharCode <= 0x7e) {
      // Printable character.
      badChar = "'${packageName[badIndex]}' ($badChar)";
    }
    throw new ArgumentError.value(
        packageUri, "packageUri", "Package names must not contain $badChar");
  }
  return packageName;
}
