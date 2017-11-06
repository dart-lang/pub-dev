// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// Regex that matches a version number at the beginning of a string.
final START_VERSION = new RegExp(
    r'^'                                        // Start at beginning.
    r'(\d+).(\d+).(\d+)'                        // Version number.
    r'(-([0-9A-Za-z-]+(\.[0-9A-Za-z-]+)*))?'    // Pre-release.
    r'(\+([0-9A-Za-z-]+(\.[0-9A-Za-z-]+)*))?'); // Build.

/// Like [START_VERSION] but matches the entire string.
final COMPLETE_VERSION = new RegExp(START_VERSION.pattern + r'$');

/// Parses a comparison operator ("<", ">", "<=", or ">=") at the beginning of
/// a string.
final START_COMPARISON = new RegExp(r"^[<>]=?");

/// The "compatible with" operator.
const COMPATIBLE_WITH = "^";
