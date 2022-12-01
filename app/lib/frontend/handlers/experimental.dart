// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:meta/meta.dart';

const _publicFlags = <String>{
  'screenshots',
};

const _allFlags = <String>{
  ..._publicFlags,
  'dart3',
  'publishing',
  'signin',
  'sandbox',
};

/// Holds the enabled experimental flags.
///
/// Experimental flags are encoded in HTTP cookie as a list of strings
/// separated by colon: `<flag-1>:<flag-2>:<flag-3>`
class ExperimentalFlags {
  final Set<String> _enabled;

  @visibleForTesting
  ExperimentalFlags(Set<String> enabled)
      : _enabled = enabled.intersection(_allFlags);

  static final List<String> publicFlags = _publicFlags.toList()..sort();
  static final ExperimentalFlags empty = ExperimentalFlags(const {});

  factory ExperimentalFlags.parseFromCookie(String? value) {
    final enabled = <String>{};
    for (final part in (value ?? '').split(':')) {
      final value = part.trim();
      if (value.isEmpty) continue;
      enabled.add(value);
    }
    return ExperimentalFlags(enabled);
  }

  @visibleForTesting
  factory ExperimentalFlags.all() {
    return ExperimentalFlags(_allFlags);
  }

  /// Whether to show the "Dart 3 ready" badge or the search checkbox.
  bool get showDart3ReadyOnUI => _enabled.contains('dart3');

  /// Whether to show the admin UI for automated publishing admin UI.
  bool get showAdminUIForAutomatedPublishing => _enabled.contains('publishing');

  /// Whether to show package screenshots in search listings.
  bool get showScreenshots => true;

  /// Whether to return dartdoc from sandboxing output.
  bool get showSandboxedOutput => _enabled.contains('sandbox');

  /// Whether to use the new Google Identity Services library.
  bool get useGisSignIn => _enabled.contains('signin');

  bool get isEmpty => _enabled.isEmpty;

  bool isEnabled(String flag) {
    return _enabled.contains(flag);
  }

  ExperimentalFlags combineWithQueryParams(Map<String, String> parameters) {
    final newEnabled = <String>{..._enabled};
    for (final p in parameters.entries) {
      final name = p.key.trim();
      final change = p.value.trim();
      if (name.isEmpty || change.isEmpty) {
        continue;
      }
      if (change == '1' || change == 'true' || change == 'enabled') {
        newEnabled.add(name);
      } else {
        newEnabled.remove(name);
      }
    }
    return ExperimentalFlags(newEnabled);
  }

  Map<String, String> urlParametersForToggle() {
    final params = <String, String>{};
    for (final v in _enabled) {
      params[v] = '0';
    }
    return params;
  }

  String encodedAsCookie() => _enabled.join(':');

  @override
  String toString() => isEmpty ? '(none)' : _enabled.join(', ');
}
