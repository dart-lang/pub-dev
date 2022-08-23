// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:math' as math;

import 'package:_pub_shared/search/search_form.dart';
import 'package:_pub_shared/search/tags.dart';
import 'package:clock/clock.dart';
import 'package:http/http.dart';
import 'package:pub_dev/search/search_service.dart';

final _client = Client();
final _random = math.Random.secure();

final _forms = <SearchForm>[
  SearchForm(query: PackageTags.isFlutterFavorite),
  SearchForm(query: 'json'),
  SearchForm(query: SdkTag.sdkDart, currentPage: 2),
  SearchForm(query: SdkTag.sdkFlutter, currentPage: 5),
  SearchForm(order: SearchOrder.created),
  SearchForm(order: SearchOrder.updated, currentPage: 3),
];

Future<void> main(List<String> args) async {
  if (args.contains('--help')) {
    print('''
Checks the current state of search drift between independent search instances,
using only public API with GET requests to infer the level. Runs the sampling
every 10-20 seconds, continuously printing the stats.
''');
    return;
  }

  final items = _forms.map((f) => _FormWithSummary(f)).toList();

  for (int cycle = 0; cycle < 10000; cycle++) {
    for (final item in items) {
      final sample = await _sample(form: item.form);
      item._diffs.add(sample.diff);
      print(item);

      await Future.delayed(Duration(seconds: 10 + _random.nextInt(10)));
    }
    print('');
  }

  _client.close();
}

Future<_Sample> _sample({
  SearchForm? form,
  int maxAttempts = 20,
  int maxItems = 3,
}) async {
  form ??= SearchForm();
  var attempt = 0;
  final items = <_Item>[];

  while (attempt < maxAttempts && items.length < maxItems) {
    attempt++;
    final item = await _singleItem(form);

    if (items.any((e) => e.instanceHash == item.instanceHash)) {
      continue;
    }
    items.add(item);
  }

  return _Sample(items: items);
}

Future<_Item> _singleItem(SearchForm form) async {
  final params = form.toServiceQuery().toUriQueryParameters();
  final rs = await _client.get(
    Uri.parse('https://search-dot-dartlang-pub.appspot.com/search').replace(
      queryParameters: {
        ...params,
        'debug-drift': '1',
      },
    ),
  );
  if (rs.statusCode == 200) {
    final body = json.decode(rs.body) as Map<String, dynamic>;
    final gae = body['gae'] as Map<String, dynamic>;
    final version = gae['version'] as String?;
    final instanceHash = gae['instanceHash'] as String?;
    final index = body['index'] as Map<String, dynamic>;
    final updatedPackages = (index['updatedPackages'] as List).cast<String>();
    final lastUpdated = DateTime.parse(index['lastUpdated'] as String);

    final packagesList =
        (body['packages'] as List).cast<Map<String, dynamic>>();
    final packages = <String?>[];
    final scores = <String?, double?>{};

    for (final map in packagesList) {
      final package = map['package'] as String?;
      packages.add(package);
      scores[package] = map['score'] as double?;
    }

    return _Item(
      form: form,
      version: version,
      instanceHash: instanceHash,
      updatedPackages: updatedPackages,
      packages: packages,
      indexUpdated: clock.now().difference(lastUpdated),
      scores: scores,
    );
  } else {
    throw StateError('Unexpected status: ${rs.statusCode}');
  }
}

class _Sample {
  final List<_Item>? items;
  _Diff? _diff;

  _Sample({
    this.items,
  });

  int get length => items!.length;
  _Item get first => items!.first;
  _Item get last => items!.last;

  _Diff get diff => _diff ??= _Diff.fromItems(items!);
}

class _Item {
  final SearchForm? form;

  final String? version;
  final String? instanceHash;
  final List<String>? updatedPackages;
  final Duration? indexUpdated;

  final List<String?>? packages;
  final Map<String?, double?>? scores;

  _Item({
    this.form,
    this.version,
    this.instanceHash,
    this.updatedPackages,
    this.indexUpdated,
    this.packages,
    this.scores,
  });

  double get scoreSum => scores!.values.fold(0.0, (sum, e) => sum + (e ?? 0.0));
}

double _scoreDiffPct(double a, double b) {
  final m = math.max(a, b);
  if (m <= 0) return 0.0;
  final diff = (a - b).abs();
  final pct = diff / m;
  return (pct * 10000.0).round() / 100.0;
}

class _Diff {
  final bool? hasObservableDifference;
  final double? packagesCount;
  final double? scoreDiffPct;
  final double? updatedCount;
  final Duration? updatedDuration;

  _Diff({
    this.hasObservableDifference,
    this.packagesCount,
    this.scoreDiffPct,
    this.updatedCount,
    this.updatedDuration,
  });

  factory _Diff.fromItems(List<_Item> items) {
    final packagesJoined = items.map((i) => i.packages!.join(',')).toSet();

    final updatedCounts = <int>[];
    final packagesCounts = <int>[];
    final scoreDiffPcts = <double>[];
    final updatedDiffs = <Duration>[];

    for (var i = 0; i < items.length; i++) {
      for (var j = i + 1; j < items.length; j++) {
        final item = items[i];
        final other = items[j];
        final updatedShared = item.updatedPackages!
            .toSet()
            .intersection(other.updatedPackages!.toSet());
        final allUpdated = <String>{
          ...item.updatedPackages!,
          ...other.updatedPackages!
        };
        updatedCounts.add(allUpdated.length - updatedShared.length);

        final pkgShared =
            item.packages!.toSet().intersection(other.packages!.toSet());
        final allPackages = <String?>{...item.packages!, ...other.packages!};
        packagesCounts.add(allPackages.length - pkgShared.length);

        final scoreDiffPct = _scoreDiffPct(item.scoreSum, other.scoreSum);
        scoreDiffPcts.add(scoreDiffPct);

        final updatedDiff = (item.indexUpdated! - other.indexUpdated!).abs();
        updatedDiffs.add(updatedDiff);
      }
    }

    return _Diff(
      hasObservableDifference: packagesJoined.length > 1,
      packagesCount:
          packagesCounts.fold<int>(0, (sum, v) => sum + v) / items.length,
      scoreDiffPct: scoreDiffPcts.fold<double>(0.0, (mv, d) => mv > d ? mv : d),
      updatedCount:
          updatedCounts.fold<int>(0, (sum, v) => sum + v) / items.length,
      updatedDuration: updatedDiffs.fold<Duration>(
          Duration.zero, (mv, d) => mv > d ? mv : d),
    );
  }

  bool get hasDrift =>
      hasObservableDifference! || packagesCount! > 0.0 || scoreDiffPct! > 0.0;

  Map<String, dynamic> toJson() => {
        'observable': hasObservableDifference,
        'pkg': packagesCount,
        'maxScore': scoreDiffPct,
        'updated': updatedCount,
        'maxDelta': updatedDuration,
      };
}

class _FormWithSummary {
  final SearchForm form;
  final _diffs = <_Diff>[];

  _FormWithSummary(this.form);

  int get length => _diffs.length;
  int get drifted => _diffs.where((d) => d.hasDrift).length;
  double get driftedPct =>
      (10000 * drifted / math.max(1, length)).round() / 100.0;

  double get sumPkgCount =>
      _diffs.map((d) => d.packagesCount).fold<double>(0.0, (a, b) => a + b!);
  double get sumScoreDiffPct =>
      _diffs.map((d) => d.scoreDiffPct).fold<double>(0.0, (a, b) => a + b!);
  double get sumUpdatedCount =>
      _diffs.map((d) => d.updatedCount).fold<double>(0.0, (a, b) => a + b!);
  double get avgUpdatedCount => sumUpdatedCount / math.max(1, length);
  Duration get sumUpdatedDuration => _diffs
      .map((d) => d.updatedDuration)
      .fold<Duration>(Duration.zero, (a, b) => a + b!);
  Duration get avgUpdatedDuration => sumUpdatedDuration ~/ math.max(1, length);

  @override
  String toString() =>
      '${form.toSearchLink()}: $drifted / $length ($driftedPct %) '
      'sPC: $sumPkgCount '
      'sSDP: $sumScoreDiffPct '
      'aUC: $avgUpdatedCount '
      'aUD: $avgUpdatedDuration';
}
