library pana.platform;

import 'package:json_annotation/json_annotation.dart';

import 'pubspec.dart';

part 'platform.g.dart';

abstract class PlatformNames {
  /// Package works everywhere.
  static const String everywhere = 'everywhere';

  /// Package uses or depends on Flutter.
  static const String flutter = 'flutter';

  /// Package is available in server applications.
  static const String server = 'server';

  /// Package is available in web applications.
  static const String web = 'web';

  /// Package's platform is unspecified.
  static const String undefined = 'undefined';

  /// Package uses or depends on a native extensions via `dart-ext:`
  static const String dartExtension = 'dart-ext';
}

@JsonSerializable()
class DartPlatform extends Object with _$DartPlatformSerializerMixin {
  final bool worksEverywhere;

  @JsonKey(includeIfNull: false)
  final List<String> restrictedTo;

  @JsonKey(includeIfNull: false)
  final String reason;

  DartPlatform(this.worksEverywhere, this.restrictedTo, this.reason);

  factory DartPlatform.conflict(String reason) =>
      new DartPlatform(false, null, reason);

  factory DartPlatform.universal({String reason}) =>
      new DartPlatform(true, null, reason);

  factory DartPlatform.withRestrictions(List<String> restrictedTo,
          {String reason}) =>
      new DartPlatform(false, restrictedTo, reason);

  factory DartPlatform.fromJson(Map<String, dynamic> json) =>
      _$DartPlatformFromJson(json);

  String get description {
    if (worksEverywhere) return PlatformNames.everywhere;
    if (hasConflict || restrictedTo == null || restrictedTo.isEmpty) {
      return PlatformNames.undefined;
    }
    if (restrictedTo.length == 1) return restrictedTo.single;
    return restrictedTo.join(',');
  }

  String get descriptionAndReason => '$description: $reason';

  bool get worksAnywhere =>
      worksEverywhere || worksOnFlutter || worksOnServer || worksOnWeb;
  bool get hasConflict => !worksAnywhere;

  bool get worksOnFlutter => _worksOn(PlatformNames.flutter);
  bool get worksOnServer => _worksOn(PlatformNames.server);
  bool get worksOnWeb => _worksOn(PlatformNames.web);

  bool _worksOn(String name) =>
      worksEverywhere || (restrictedTo != null && restrictedTo.contains(name));
}

class _LibInspector {
  final Set<String> _deps;
  _LibInspector._(this._deps);

  factory _LibInspector(Set<String> dependencies) {
    var deps = new Set<String>();

    deps.addAll(dependencies.where((l) => _dartLibRegexp.hasMatch(l)));
    deps.addAll(dependencies.where((l) => _dartPanaLibRegexp.hasMatch(l)));

    if (dependencies.any((String lib) => lib.startsWith('dart-ext:'))) {
      deps.add(PlatformNames.dartExtension);
    }

    return new _LibInspector._(deps);
  }

  bool get hasConflict =>
      (!worksAnywhere) ||
      (_deps.contains(PlatformNames.flutter) && !worksOnFlutter) ||
      (_deps.contains(PlatformNames.dartExtension) && !worksOnServer);

  bool get worksEverywhere => worksOnWeb && worksOnServer && worksOnFlutter;

  bool get worksAnywhere => worksOnWeb || worksOnServer || worksOnFlutter;

  bool get worksOnWeb =>
      _hasNoUseOf(
          [PlatformNames.flutter, 'dart:ui', PlatformNames.dartExtension]) &&
      (_webPackages.any(_deps.contains) || _hasNoUseOf(['dart:io']));

  bool get worksOnServer =>
      _hasNoUseOf(_webAnd(['dart:ui', PlatformNames.flutter]));

  bool get worksOnFlutter => _hasNoUseOf(_webAnd([
        'dart:mirrors',
        PlatformNames.dartExtension,
      ]));

  bool _hasNoUseOf(Iterable<String> platforms) =>
      !platforms.any((p) => _deps.contains(p));
}

DartPlatform classifyPkgPlatform(
    Pubspec pubspec, Map<String, List<String>> transitiveLibs) {
  if (transitiveLibs == null) {
    return new DartPlatform.conflict('failed to scan transitive libraries');
  }
  final libraries = new Map<String, DartPlatform>.fromIterable(
      transitiveLibs.keys ?? <String>[],
      value: (key) => classifyLibPlatform(transitiveLibs[key]));
  final primaryLibrary =
      _selectPrimaryLibrary(pubspec, transitiveLibs.keys.toSet());

  if (pubspec.isFlutter) {
    final hasConflict = libraries.values.any((pi) => !pi.worksOnFlutter);
    if (hasConflict) {
      return new DartPlatform.conflict(
          'flutter reference with library conflicts');
    } else {
      return new DartPlatform.withRestrictions([PlatformNames.flutter],
          reason: 'pubspec reference with no conflicts');
    }
  }

  if (libraries.isEmpty) {
    // TODO: if there is a `bin/` asset, maybe this is server-only?
    return new DartPlatform.conflict('no libraries!');
  }

  for (var lib in libraries.keys) {
    final libp = libraries[lib];
    if (libp.hasConflict) {
      return new DartPlatform.conflict('conflict in library - `$lib`');
    }
  }

  if (libraries.values.every((lp) => lp.worksEverywhere)) {
    return new DartPlatform.universal(reason: 'All libraries agree');
  }

  if (primaryLibrary != null && libraries[primaryLibrary].worksEverywhere) {
    return new DartPlatform.universal(
        reason: 'primary library - `$primaryLibrary`');
  }

  final items = libraries.values
      .where((p) => !p.worksEverywhere)
      .expand((p) => p.restrictedTo)
      .toSet();
  if (items.length == 1) {
    return new DartPlatform.withRestrictions([items.single],
        reason: 'All libraries agree');
  }

  if (primaryLibrary != null) {
    var primaryPlatform = libraries[primaryLibrary];
    if (primaryPlatform.restrictedTo?.length == 1) {
      return new DartPlatform.withRestrictions(primaryPlatform.restrictedTo,
          reason: 'primary library - `$primaryLibrary`');
    }
  }

  // If the primary library search fails, go back to the roll-up of all
  // platforms. See if excluding `everywhere` leads us to something more
  // specific.

  var everythingRemoved = false;
  if (items.length > 1) {
    everythingRemoved = items.remove(PlatformNames.everywhere);

    if (items.length == 1) {
      return new DartPlatform.withRestrictions([items.single],
          reason: 'one library with an opinion - $everythingRemoved');
    }
  }

  if (items.isEmpty) {
    return new DartPlatform.conflict(
        'no library opinions? - $everythingRemoved');
  }

  return new DartPlatform.withRestrictions(items.toList()..sort(),
      reason: 'all of the above');
}

String _selectPrimaryLibrary(Pubspec pubspec, Set<String> libraryUris) {
  final pkg = pubspec.name;
  final primaryCandidates = <String>[
    'package:$pkg/$pkg.dart',
    'package:$pkg/main.dart',
  ];
  return primaryCandidates.firstWhere(libraryUris.contains, orElse: () => null);
}

DartPlatform classifyLibPlatform(Iterable<String> dependencies) {
  final inspector = new _LibInspector(dependencies.toSet());
  if (inspector.hasConflict) {
    return new DartPlatform.conflict('Transitive dependencies in conflict.');
  }
  if (inspector.worksEverywhere) {
    return new DartPlatform.universal();
  }
  final restrictedTo = <String>[];
  if (inspector.worksOnFlutter) restrictedTo.add(PlatformNames.flutter);
  if (inspector.worksOnServer) restrictedTo.add(PlatformNames.server);
  if (inspector.worksOnWeb) restrictedTo.add(PlatformNames.web);
  restrictedTo.sort();
  if (restrictedTo.isEmpty) {
    return new DartPlatform.conflict('Transitive dependencies in conflict.');
  }
  return new DartPlatform.withRestrictions(restrictedTo);
}

final _dartLibRegexp = new RegExp(r"^dart:[a-z_]+$");
final _dartPanaLibRegexp = new RegExp(r"^dart-pana:[a-z_]+$");

Iterable<String> _webAnd(Iterable<String> other) =>
    [_webPackages, other].expand((s) => s);

const List<String> _webPackages = const [
  'dart:html',
  'dart:indexed_db',
  'dart:js',
  'dart:js_util',
  'dart:svg',
  'dart:web_audio',
  'dart:web_gl',
  'dart:web_sql',
];
