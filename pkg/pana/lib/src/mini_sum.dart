import 'dart:collection';
import 'dart:convert';

import 'code_problem.dart';
import 'summary.dart';
import 'utils.dart';

class MiniSum {
  static const _importantDirs = const ['bin', 'lib', 'test'];

  final Summary summary;

  String get packageName => summary.packageName;

  bool get pubClean => summary.pkgResolution != null;

  Set<String> get authorDomains => new SplayTreeSet<String>.from(
      summary.pubspec.authors.map(_domainFromAuthor));

  int get unformattedFiles =>
      summary.dartFiles.values.where((f) => !(f?.isFormatted ?? false)).length;

  Iterable<CodeProblem> get analyzerItems => summary.codeProblems;

  MiniSum(this.summary);

  factory MiniSum.fromFileContent(String content) {
    var output = JSON.decode(content) as Map<String, dynamic>;

    if (output['pkgResolution'] == null) {
      throw 'Could not process ${output['packageName']}';
    }

    var summary = new Summary.fromJson(output);

    assert(prettyJson(summary.toJson()) == prettyJson(output));

    return new MiniSum(summary);
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{
      'name': summary.packageName,
      'version': summary.packageVersion.toString(),
    };

    // dependency info
    map.addAll(summary.pkgResolution.getStats(summary.pubspec));

    // analyzer info
    map.addAll(_analyzerThings(summary.codeProblems));

    // analyzer bytes - total bytes of dart files in _analyzeDirs
    map['analyzed_bytes'] = _analyzerDartBytes(summary.dartFiles);

    // file info
    map.addAll(_classifyFiles(summary.dartFiles.keys));

    // format
    map['pctFormatted'] = summary.dartFiles.isEmpty
        ? 1.0
        : 1.0 - unformattedFiles / summary.dartFiles.length;

    map['authorDomains'] = authorDomains.join(', ');

    return map;
  }

  String getSchema() {
    var items = <String>[];

    toJson().forEach((k, v) {
      String type;

      if (v is String) {
        type = 'STRING';
      } else if (v is int) {
        type = 'INTEGER';
      } else if (v is double) {
        type = 'FLOAT';
      } else {
        throw 'Not supported! - $v - ${v.runtimeType}';
      }

      items.add("$k:$type");
    });

    return items.join(',');
  }
}

int _analyzerDartBytes(Map<String, DartFileSummary> data) {
  var bytes = 0;
  data.forEach((path, summary) {
    if (_analyzeDirs.contains(_classifyFile(path))) {
      bytes += summary.size;
    }
  });

  return bytes;
}

const _analyzeDirs = const ['lib', 'bin'];

Map<String, int> _analyzerThings(Iterable<CodeProblem> analyzerThings) {
  var items = <String, int>{
    'analyzer_strong_error': 0,
    'analyzer_error': 0,
    'analyzer_topLevelStrong': 0,
    'analyzer_other': 0
  };

  for (var item in analyzerThings) {
    if (_analyzeDirs.contains(_classifyFile(item.file))) {
      var key = _getAnalyzerOutputClass(
          item.severity, item.errorType, item.errorCode);
      items[key] += 1;
    }
  }

  return items;
}

String _getAnalyzerOutputClass(
    String severity, String errorType, String errorCode) {
  if (severity == 'ERROR') {
    if (errorCode.startsWith("STRONG_MODE_")) {
      return 'analyzer_strong_error';
    }
    return 'analyzer_error';
  }
  if (errorCode.startsWith("STRONG_MODE_TOP_LEVEL_")) {
    //TODO(kevmoo) The story is changing here in Dart 1.25+
    // https://github.com/dart-lang/pana/issues/16
    return 'analyzer_topLevelStrong';
  }

  return 'analyzer_other';
}

Map<String, int> _classifyFiles(Iterable<String> paths) {
  var map = new SplayTreeMap<String, int>.fromIterable(
      (["other"]..addAll(MiniSum._importantDirs)).map((e) => "files_${e}"),
      value: (_) => 0);

  for (var path in paths) {
    var key = 'files_${_classifyFile(path)}';
    map[key] = 1 + map.putIfAbsent(key, () => 0);
  }

  return map;
}

String _classifyFile(String path) {
  var split = path.split('/');

  if (split.length >= 2 && MiniSum._importantDirs.contains(split.first)) {
    return split.first;
  }

  return 'other';
}

const _domainRegep =
    r"(?:[a-zA-Z0-9][a-zA-Z0-9-]{1,61}[a-zA-Z0-9]\.)+[a-zA-Z]{2,}";
final _domainThing = new RegExp("[@/]($_domainRegep)>");

String _domainFromAuthor(String author) {
  var match = _domainThing.firstMatch(author);
  if (match == null) {
    return 'unknown';
  }
  return match.group(1);
}
