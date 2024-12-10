// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:meta/meta.dart';

import '../../shared/cookie_utils.dart';

typedef PublicFlag = ({String name, String description});

const _publicFlags = <PublicFlag>{
  (name: 'dark', description: 'Dark mode'),
  (name: 'download-counts', description: 'Download count metrics'),
  (name: 'search-completion', description: 'Completions for the search bar'),
  (name: 'search-topics', description: 'Show matching topics when searching'),
};

final _allFlags = <String>{
  'dark-as-default',
  ..._publicFlags.map((x) => x.name),
};

/// The name of the experimental cookie.
final experimentalCookieName = pubCookieName('experimental');
const experimentalCookieDuration = Duration(days: 7);

/// Holds the enabled experimental flags.
///
/// Experimental flags are encoded in HTTP cookie as a list of strings
/// separated by colon: `<flag-1>:<flag-2>:<flag-3>`
class ExperimentalFlags {
  final Set<String> _enabled;

  @visibleForTesting
  ExperimentalFlags(Set<String> enabled)
      : _enabled = enabled.intersection(_allFlags);

  static final List<PublicFlag> publicFlags = _publicFlags.toList()
    ..sort((a, b) => a.name.compareTo(b.name));
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

  ExperimentalFlags addAll(Iterable<String> flags) {
    return ExperimentalFlags({..._enabled, ...flags});
  }

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

  bool get isSearchCompletionEnabled => isEnabled('search-completion');
  bool get isSearchTopicsEnabled => isEnabled('search-topics');

  bool get isDarkModeEnabled => isEnabled('dark');
  bool get isDarkModeDefault => isEnabled('dark-as-default');

  bool get showDownloadCounts => isEnabled('download-counts');
  bool get showDownloadCountsVersionChart =>
      isEnabled('download-counts-version-chart');

  String encodedAsCookie() => _enabled.join(':');

  @override
  String toString() => isEmpty ? '(none)' : _enabled.join(', ');
}
