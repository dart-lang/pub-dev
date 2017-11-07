// Copyright 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io' as io;

/// Whether formatted ANSI output is enabled for [wrapWith] and [AnsiCode.wrap].
///
/// By default, returns `true` if both `stdout.supportsAnsiEscapes` and
/// `stderr.supportsAnsiEscapes` from `dart:io` are `true`.
///
/// The default can be overridden by setting the [Zone] variable [AnsiCode] to
/// either `true` or `false`.
///
/// [overrideAnsiOutput] is provided to make this easy.
bool get ansiOutputEnabled =>
    Zone.current[AnsiCode] as bool ??
    (io.stdout.supportsAnsiEscapes && io.stderr.supportsAnsiEscapes);

/// Allows overriding [ansiOutputEnabled] to [enableAnsiOutput] for the code run
/// within [body].
T overrideAnsiOutput<T>(bool enableAnsiOutput, T body()) =>
    runZoned(body, zoneValues: <Object, Object>{AnsiCode: enableAnsiOutput});

/// The type of code represented by [AnsiCode].
class AnsiCodeType {
  final String _name;

  /// A foreground color.
  static const AnsiCodeType foreground = const AnsiCodeType._('foreground');

  /// A style.
  static const AnsiCodeType style = const AnsiCodeType._('style');

  /// A background color.
  static const AnsiCodeType background = const AnsiCodeType._('background');

  /// A reset value.
  static const AnsiCodeType reset = const AnsiCodeType._('reset');

  const AnsiCodeType._(this._name);

  @override
  String toString() => 'AnsiType.$_name';
}

/// Standard ANSI escape code for customizing terminal text output.
///
/// [Source](https://en.wikipedia.org/wiki/ANSI_escape_code#Colors)
class AnsiCode {
  /// The numeric value associated with this code.
  final int code;

  /// The [AnsiCode] that resets this value, if one exists.
  ///
  /// Otherwise, `null`.
  final AnsiCode reset;

  /// A description of this code.
  final String name;

  /// The type of code that is represented.
  final AnsiCodeType type;

  const AnsiCode._(this.name, this.type, this.code, this.reset);

  /// Represents the value escaped for use in terminal output.
  String get escape => "\x1B[${code}m";

  /// Wraps [value] with the [escape] value for this code, followed by
  /// [resetAll].
  ///
  /// Returns `value` unchanged if
  ///   * [value] is `null` or empty
  ///   * [ansiOutputEnabled] is `false`
  ///   * [type] is [AnsiCodeType.reset]
  String wrap(String value) => (ansiOutputEnabled &&
          type != AnsiCodeType.reset &&
          value != null &&
          value.isNotEmpty)
      ? "$escape$value${reset.escape}"
      : value;

  @override
  String toString() => "$name ${type._name} ($code)";
}

/// Returns a [String] formatted with [codes].
///
/// Returns `value` unchanged if
///   * [value] is `null` or empty.
///   * [ansiOutputEnabled] is `false`.
///   * [codes] is empty.
///
/// Throws an [ArgumentError] if
///   * [codes] contains more than one value of type [AnsiCodeType.foreground].
///   * [codes] contains more than one value of type [AnsiCodeType.background].
///   * [codes] contains any value of type [AnsiCodeType.reset].
String wrapWith(String value, Iterable<AnsiCode> codes) {
  // Eliminate duplicates
  final myCodes = codes.toSet();

  if (myCodes.isEmpty || !ansiOutputEnabled || value == null || value.isEmpty) {
    return value;
  }

  var foreground = 0, background = 0;
  for (var code in myCodes) {
    switch (code.type) {
      case AnsiCodeType.foreground:
        foreground++;
        if (foreground > 1) {
          throw new ArgumentError.value(codes, 'codes',
              "Cannot contain more than one foreground color code.");
        }
        break;
      case AnsiCodeType.background:
        background++;
        if (background > 1) {
          throw new ArgumentError.value(codes, 'codes',
              "Cannot contain more than one foreground color code.");
        }
        break;
      case AnsiCodeType.reset:
        throw new ArgumentError.value(
            codes, 'codes', "Cannot contain reset codes.");
        break;
    }
  }

  final sortedCodes = myCodes.map((ac) => ac.code).toList()..sort();

  return "\x1B[${sortedCodes.join(';')}m$value${resetAll.escape}";
}

//
// Style values
//

const styleBold = const AnsiCode._('bold', AnsiCodeType.style, 1, resetBold);
const styleDim = const AnsiCode._('dim', AnsiCodeType.style, 2, resetDim);
const styleItalic =
    const AnsiCode._('italic', AnsiCodeType.style, 3, resetItalic);
const styleUnderlined =
    const AnsiCode._('underlined', AnsiCodeType.style, 4, resetUnderlined);
const styleBlink = const AnsiCode._('blink', AnsiCodeType.style, 5, resetBlink);
const styleReverse =
    const AnsiCode._('reverse', AnsiCodeType.style, 7, resetReverse);

/// Not widely supported.
const styleHidden =
    const AnsiCode._('hidden', AnsiCodeType.style, 8, resetHidden);

/// Not widely supported.
const styleCrossedOut =
    const AnsiCode._('crossed out', AnsiCodeType.style, 9, resetCrossedOut);

//
// Reset values
//

const resetAll = const AnsiCode._('all', AnsiCodeType.reset, 0, null);

// NOTE: bold is weird. The reset code seems to be 22 sometimes – not 21
// See https://gitlab.com/gnachman/iterm2/issues/3208
const resetBold = const AnsiCode._('bold', AnsiCodeType.reset, 22, null);
const resetDim = const AnsiCode._('dim', AnsiCodeType.reset, 22, null);
const resetItalic = const AnsiCode._('italic', AnsiCodeType.reset, 23, null);
const resetUnderlined =
    const AnsiCode._('underlined', AnsiCodeType.reset, 24, null);
const resetBlink = const AnsiCode._('blink', AnsiCodeType.reset, 25, null);
const resetReverse = const AnsiCode._('reverse', AnsiCodeType.reset, 27, null);
const resetHidden = const AnsiCode._('hidden', AnsiCodeType.reset, 28, null);
const resetCrossedOut =
    const AnsiCode._('crossed out', AnsiCodeType.reset, 29, null);

//
// Foreground values
//

const black = const AnsiCode._('black', AnsiCodeType.foreground, 30, resetAll);
const red = const AnsiCode._('red', AnsiCodeType.foreground, 31, resetAll);
const green = const AnsiCode._('green', AnsiCodeType.foreground, 32, resetAll);
const yellow =
    const AnsiCode._('yellow', AnsiCodeType.foreground, 33, resetAll);
const blue = const AnsiCode._('blue', AnsiCodeType.foreground, 34, resetAll);
const magenta =
    const AnsiCode._('magenta', AnsiCodeType.foreground, 35, resetAll);
const cyan = const AnsiCode._('cyan', AnsiCodeType.foreground, 36, resetAll);
const lightGray =
    const AnsiCode._('light gray', AnsiCodeType.foreground, 37, resetAll);
const defaultForeground =
    const AnsiCode._('default', AnsiCodeType.foreground, 39, resetAll);
const darkGray =
    const AnsiCode._('dark gray', AnsiCodeType.foreground, 90, resetAll);
const lightRed =
    const AnsiCode._('light red', AnsiCodeType.foreground, 91, resetAll);
const lightGreen =
    const AnsiCode._('light green', AnsiCodeType.foreground, 92, resetAll);
const lightYellow =
    const AnsiCode._('light yellow', AnsiCodeType.foreground, 93, resetAll);
const lightBlue =
    const AnsiCode._('light blue', AnsiCodeType.foreground, 94, resetAll);
const lightMagenta =
    const AnsiCode._('light magenta', AnsiCodeType.foreground, 95, resetAll);
const lightCyan =
    const AnsiCode._('light cyan', AnsiCodeType.foreground, 96, resetAll);
const white = const AnsiCode._('white', AnsiCodeType.foreground, 97, resetAll);

//
// Background values
//

const backgroundBlack =
    const AnsiCode._('black', AnsiCodeType.background, 40, resetAll);
const backgroundRed =
    const AnsiCode._('red', AnsiCodeType.background, 41, resetAll);
const backgroundGreen =
    const AnsiCode._('green', AnsiCodeType.background, 42, resetAll);
const backgroundYellow =
    const AnsiCode._('yellow', AnsiCodeType.background, 43, resetAll);
const backgroundBlue =
    const AnsiCode._('blue', AnsiCodeType.background, 44, resetAll);
const backgroundMagenta =
    const AnsiCode._('magenta', AnsiCodeType.background, 45, resetAll);
const backgroundCyan =
    const AnsiCode._('cyan', AnsiCodeType.background, 46, resetAll);
const backgroundLightGray =
    const AnsiCode._('light gray', AnsiCodeType.background, 47, resetAll);
const backgroundDefault =
    const AnsiCode._('default', AnsiCodeType.background, 49, resetAll);
const backgroundDarkGray =
    const AnsiCode._('dark gray', AnsiCodeType.background, 100, resetAll);
const backgroundLightRed =
    const AnsiCode._('light red', AnsiCodeType.background, 101, resetAll);
const backgroundLightGreen =
    const AnsiCode._('light green', AnsiCodeType.background, 102, resetAll);
const backgroundLightYellow =
    const AnsiCode._('light yellow', AnsiCodeType.background, 103, resetAll);
const backgroundLightBlue =
    const AnsiCode._('light blue', AnsiCodeType.background, 104, resetAll);
const backgroundLightMagenta =
    const AnsiCode._('light magenta', AnsiCodeType.background, 105, resetAll);
const backgroundLightCyan =
    const AnsiCode._('light cyan', AnsiCodeType.background, 106, resetAll);
const backgroundWhite =
    const AnsiCode._('white', AnsiCodeType.background, 107, resetAll);

/// All of the [AnsiCode] values that represent [AnsiCodeType.style].
const List<AnsiCode> styles = const [
  styleBold,
  styleDim,
  styleItalic,
  styleUnderlined,
  styleBlink,
  styleReverse,
  styleHidden,
  styleCrossedOut
];

/// All of the [AnsiCode] values that represent [AnsiCodeType.foreground].
const List<AnsiCode> foregroundColors = const [
  black,
  red,
  green,
  yellow,
  blue,
  magenta,
  cyan,
  lightGray,
  defaultForeground,
  darkGray,
  lightRed,
  lightGreen,
  lightYellow,
  lightBlue,
  lightMagenta,
  lightCyan,
  white
];

/// All of the [AnsiCode] values that represent [AnsiCodeType.background].
const List<AnsiCode> backgroundColors = const [
  backgroundBlack,
  backgroundRed,
  backgroundGreen,
  backgroundYellow,
  backgroundBlue,
  backgroundMagenta,
  backgroundCyan,
  backgroundLightGray,
  backgroundDefault,
  backgroundDarkGray,
  backgroundLightRed,
  backgroundLightGreen,
  backgroundLightYellow,
  backgroundLightBlue,
  backgroundLightMagenta,
  backgroundLightCyan,
  backgroundWhite
];
