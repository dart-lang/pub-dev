// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:boolean_selector/boolean_selector.dart';
import 'package:collection/collection.dart';
import 'package:glob/glob.dart';
import 'package:path/path.dart' as p;
import 'package:source_span/source_span.dart';
import 'package:yaml/yaml.dart';

import '../../backend/operating_system.dart';
import '../../backend/platform_selector.dart';
import '../../frontend/timeout.dart';
import '../../util/io.dart';
import '../../utils.dart';
import '../configuration.dart';
import '../configuration/suite.dart';
import 'custom_platform.dart';
import 'platform_selection.dart';
import 'platform_settings.dart';
import 'reporters.dart';

/// A regular expression matching a Dart identifier.
///
/// This also matches a package name, since they must be Dart identifiers.
final identifierRegExp = new RegExp(r"[a-zA-Z_]\w*");

/// A regular expression matching allowed package names.
///
/// This allows dot-separated valid Dart identifiers. The dots are there for
/// compatibility with Google's internal Dart packages, but they may not be used
/// when publishing a package to pub.dartlang.org.
final _packageName = new RegExp(
    "^${identifierRegExp.pattern}(\\.${identifierRegExp.pattern})*\$");

/// Loads configuration information from a YAML file at [path].
///
/// If [global] is `true`, this restricts the configuration file to only rules
/// that are supported globally.
///
/// Throws a [FormatException] if the configuration is invalid, and a
/// [FileSystemException] if it can't be read.
Configuration load(String path, {bool global: false}) {
  var source = new File(path).readAsStringSync();
  var document = loadYamlNode(source, sourceUrl: p.toUri(path));

  if (document.value == null) return Configuration.empty;

  if (document is! Map) {
    throw new SourceSpanFormatException(
        "The configuration must be a YAML map.", document.span, source);
  }

  var loader = new _ConfigurationLoader(document, source, global: global);
  return loader.load();
}

/// A helper for [load] that tracks the YAML document.
class _ConfigurationLoader {
  /// The parsed configuration document.
  final YamlMap _document;

  /// The source string for [_document].
  ///
  /// Used for error reporting.
  final String _source;

  /// Whether this is parsing the global configuration file.
  final bool _global;

  /// Whether runner configuration is allowed at this level.
  final bool _runnerConfig;

  _ConfigurationLoader(this._document, this._source,
      {bool global: false, bool runnerConfig: true})
      : _global = global,
        _runnerConfig = runnerConfig;

  /// Loads the configuration in [_document].
  Configuration load() => _loadGlobalTestConfig()
      .merge(_loadLocalTestConfig())
      .merge(_loadGlobalRunnerConfig())
      .merge(_loadLocalRunnerConfig());

  /// Loads test configuration that's allowed in the global configuration file.
  Configuration _loadGlobalTestConfig() {
    var verboseTrace = _getBool("verbose_trace");
    var chainStackTraces = _getBool("chain_stack_traces");
    var foldStackFrames = _loadFoldedStackFrames();
    var jsTrace = _getBool("js_trace");

    var timeout = _parseValue("timeout", (value) => new Timeout.parse(value));

    var onPlatform = _getMap("on_platform",
        key: (keyNode) => _parseNode(keyNode, "on_platform key",
            (value) => new PlatformSelector.parse(value, keyNode.span)),
        value: (valueNode) =>
            _nestedConfig(valueNode, "on_platform value", runnerConfig: false));

    var onOS = _getMap("on_os",
        key: (keyNode) {
          _validate(keyNode, "on_os key must be a string.",
              (value) => value is String);

          var os = OperatingSystem.find(keyNode.value);
          if (os != null) return os;

          throw new SourceSpanFormatException(
              'Invalid on_os key: No such operating system.',
              keyNode.span,
              _source);
        },
        value: (valueNode) => _nestedConfig(valueNode, "on_os value"));

    var presets = _getMap("presets",
        key: (keyNode) => _parseIdentifierLike(keyNode, "presets key"),
        value: (valueNode) => _nestedConfig(valueNode, "presets value"));

    var config = new Configuration(
            verboseTrace: verboseTrace,
            jsTrace: jsTrace,
            timeout: timeout,
            presets: presets,
            chainStackTraces: chainStackTraces,
            foldTraceExcept: foldStackFrames["except"],
            foldTraceOnly: foldStackFrames["only"])
        .merge(_extractPresets<PlatformSelector>(
            onPlatform, (map) => new Configuration(onPlatform: map)));

    var osConfig = onOS[currentOS];
    return osConfig == null ? config : config.merge(osConfig);
  }

  /// Loads test configuration that's not allowed in the global configuration
  /// file.
  ///
  /// If [_global] is `true`, this will error if there are any local test-level
  /// configuration fields.
  Configuration _loadLocalTestConfig() {
    if (_global) {
      _disallow("skip");
      _disallow("retry");
      _disallow("test_on");
      _disallow("add_tags");
      _disallow("tags");
      return Configuration.empty;
    }

    var skip = _getValue("skip", "boolean or string",
        (value) => value is bool || value is String);
    var skipReason;
    if (skip is String) {
      skipReason = skip;
      skip = true;
    }

    var testOn = _parsePlatformSelector("test_on");

    var addTags = _getList(
        "add_tags", (tagNode) => _parseIdentifierLike(tagNode, "Tag name"));

    var tags = _getMap("tags",
        key: (keyNode) => _parseNode(
            keyNode, "tags key", (value) => new BooleanSelector.parse(value)),
        value: (valueNode) =>
            _nestedConfig(valueNode, "tag value", runnerConfig: false));

    var retry = _getNonNegativeInt("retry");

    return new Configuration(
            skip: skip,
            retry: retry,
            skipReason: skipReason,
            testOn: testOn,
            addTags: addTags)
        .merge(_extractPresets<BooleanSelector>(
            tags, (map) => new Configuration(tags: map)));
  }

  /// Loads runner configuration that's allowed in the global configuration
  /// file.
  ///
  /// If [_runnerConfig] is `false`, this will error if there are any
  /// runner-level configuration fields.
  Configuration _loadGlobalRunnerConfig() {
    if (!_runnerConfig) {
      _disallow("pause_after_load");
      _disallow("reporter");
      _disallow("concurrency");
      _disallow("names");
      _disallow("plain_names");
      _disallow("platforms");
      _disallow("add_presets");
      _disallow("override_platforms");
      return Configuration.empty;
    }

    var pauseAfterLoad = _getBool("pause_after_load");
    var runSkipped = _getBool("run_skipped");

    var reporter = _getString("reporter");
    if (reporter != null && !allReporters.keys.contains(reporter)) {
      _error('Unknown reporter "$reporter".', "reporter");
    }

    var concurrency = _getInt("concurrency");

    var platforms = _getList(
        "platforms",
        (platformNode) => new PlatformSelection(
            _parseIdentifierLike(platformNode, "Platform name"),
            platformNode.span));

    var chosenPresets = _getList("add_presets",
        (presetNode) => _parseIdentifierLike(presetNode, "Preset name"));

    var overridePlatforms = _loadOverridePlatforms();

    return new Configuration(
        pauseAfterLoad: pauseAfterLoad,
        runSkipped: runSkipped,
        reporter: reporter,
        concurrency: concurrency,
        platforms: platforms,
        chosenPresets: chosenPresets,
        overridePlatforms: overridePlatforms);
  }

  /// Loads the `override_platforms` field.
  Map<String, PlatformSettings> _loadOverridePlatforms() {
    var platformsNode =
        _getNode("override_platforms", "map", (value) => value is Map)
            as YamlMap;
    if (platformsNode == null) return const {};

    var platforms = <String, PlatformSettings>{};
    platformsNode.nodes.forEach((identifierNode, valueNode) {
      var identifier =
          _parseIdentifierLike(identifierNode, "Platform identifier");

      _validate(valueNode, "Platform definition must be a map.",
          (value) => value is Map);
      var map = valueNode as YamlMap;

      var settings = _expect(map, "settings");
      _validate(settings, "Must be a map.", (value) => value is Map);

      platforms[identifier] = new PlatformSettings(
          identifier, identifierNode.span, [settings as YamlMap]);
    });
    return platforms;
  }

  /// Loads runner configuration that's not allowed in the global configuration
  /// file.
  ///
  /// If [_runnerConfig] is `false` or if [_global] is `true`, this will error
  /// if there are any local test-level configuration fields.
  Configuration _loadLocalRunnerConfig() {
    if (!_runnerConfig || _global) {
      _disallow("pub_serve");
      _disallow("names");
      _disallow("plain_names");
      _disallow("paths");
      _disallow("filename");
      _disallow("include_tags");
      _disallow("exclude_tags");
      _disallow("define_platforms");
      return Configuration.empty;
    }

    var pubServePort = _getInt("pub_serve");

    var patterns = _getList("names", (nameNode) {
      _validate(nameNode, "Names must be strings.", (value) => value is String);
      return _parseNode(nameNode, "name", (value) => new RegExp(value));
    })
      ..addAll(_getList("plain_names", (nameNode) {
        _validate(
            nameNode, "Names must be strings.", (value) => value is String);
        return nameNode.value;
      }));

    var paths = _getList("paths", (pathNode) {
      _validate(pathNode, "Paths must be strings.", (value) => value is String);
      _validate(pathNode, "Paths must be relative.", p.url.isRelative);

      return _parseNode(pathNode, "path", p.fromUri);
    });

    var filename = _parseValue("filename", (value) => new Glob(value));

    var includeTags = _parseBooleanSelector("include_tags");
    var excludeTags = _parseBooleanSelector("exclude_tags");

    var definePlatforms = _loadDefinePlatforms();

    return new Configuration(
        pubServePort: pubServePort,
        patterns: patterns,
        paths: paths,
        filename: filename,
        includeTags: includeTags,
        excludeTags: excludeTags,
        definePlatforms: definePlatforms);
  }

  /// Returns a map representation of the `fold_stack_frames` configuration.
  ///
  /// The key `except` will correspond to the list of packages to fold.
  /// The key `only` will correspond to the list of packages to keep in a
  /// test [Chain].
  Map<String, List<String>> _loadFoldedStackFrames() {
    var foldOptionSet = false;
    return _getMap("fold_stack_frames", key: (keyNode) {
      _validate(keyNode, "Must be a string", (value) => value is String);
      _validate(keyNode, 'Must be "only" or "except".',
          (value) => value == "only" || value == "except");

      if (foldOptionSet) {
        throw new SourceSpanFormatException(
            'Can only contain one of "only" or "except".',
            keyNode.span,
            _source);
      }
      foldOptionSet = true;
      return keyNode.value;
    }, value: (valueNode) {
      _validate(
          valueNode,
          "Folded packages must be strings.",
          (valueList) =>
              valueList is YamlList &&
              valueList.every((value) => value is String));

      _validate(
          valueNode,
          "Invalid package name.",
          (valueList) =>
              valueList.every((value) => _packageName.hasMatch(value)));

      return valueNode.value;
    });
  }

  /// Loads the `define_platforms` field.
  Map<String, CustomPlatform> _loadDefinePlatforms() {
    var platformsNode =
        _getNode("define_platforms", "map", (value) => value is Map) as YamlMap;
    if (platformsNode == null) return const {};

    var platforms = <String, CustomPlatform>{};
    platformsNode.nodes.forEach((identifierNode, valueNode) {
      var identifier =
          _parseIdentifierLike(identifierNode, "Platform identifier");

      _validate(valueNode, "Platform definition must be a map.",
          (value) => value is Map);
      var map = valueNode as YamlMap;

      var nameNode = _expect(map, "name");
      _validate(nameNode, "Must be a string.", (value) => value is String);
      var name = nameNode.value as String;

      var parentNode = _expect(map, "extends");
      var parent = _parseIdentifierLike(parentNode, "Platform parent");

      var settings = _expect(map, "settings");
      _validate(settings, "Must be a map.", (value) => value is Map);

      platforms[identifier] = new CustomPlatform(
          name,
          nameNode.span,
          identifier,
          identifierNode.span,
          parent,
          parentNode.span,
          settings as YamlMap);
    });
    return platforms;
  }

  /// Throws an exception with [message] if [test] returns `false` when passed
  /// [node]'s value.
  void _validate(YamlNode node, String message, bool test(value)) {
    if (test(node.value)) return;
    throw new SourceSpanFormatException(message, node.span, _source);
  }

  /// Returns the value of the node at [field].
  ///
  /// If [typeTest] returns `false` for that value, instead throws an error
  /// complaining that the field is not a [typeName].
  _getValue(String field, String typeName, bool typeTest(value)) {
    var value = _document[field];
    if (value == null || typeTest(value)) return value;
    _error("$field must be ${a(typeName)}.", field);
  }

  /// Returns the YAML node at [field].
  ///
  /// If [typeTest] returns `false` for that node's value, instead throws an
  /// error complaining that the field is not a [typeName].
  YamlNode _getNode(String field, String typeName, bool typeTest(value)) {
    var node = _document.nodes[field];
    if (node == null) return null;
    _validate(node, "$field must be ${a(typeName)}.", typeTest);
    return node;
  }

  /// Asserts that [field] is an int and returns its value.
  int _getInt(String field) => _getValue(field, "int", (value) => value is int);

  /// Asserts that [field] is a non-negative int and returns its value.
  int _getNonNegativeInt(String field) => _getValue(
      field, "non-negative int", (value) => value is int && value >= 0);

  /// Asserts that [field] is a boolean and returns its value.
  bool _getBool(String field) =>
      _getValue(field, "boolean", (value) => value is bool);

  /// Asserts that [field] is a string and returns its value.
  String _getString(String field) =>
      _getValue(field, "string", (value) => value is String);

  /// Asserts that [field] is a list and runs [forElement] for each element it
  /// contains.
  ///
  /// Returns a list of values returned by [forElement].
  List<T> _getList<T>(String field, T forElement(YamlNode elementNode)) {
    var node = _getNode(field, "list", (value) => value is List) as YamlList;
    if (node == null) return [];
    return node.nodes.map(forElement).toList();
  }

  /// Asserts that [field] is a map and runs [key] and [value] for each pair.
  ///
  /// Returns a map with the keys and values returned by [key] and [value]. Each
  /// of these defaults to asserting that the value is a string.
  Map<K, V> _getMap<K, V>(String field,
      {K key(YamlNode keyNode), V value(YamlNode valueNode)}) {
    var node = _getNode(field, "map", (value) => value is Map) as YamlMap;
    if (node == null) return {};

    key ??= (keyNode) {
      _validate(
          keyNode, "$field keys must be strings.", (value) => value is String);

      return keyNode.value as K;
    };

    value ??= (valueNode) {
      _validate(valueNode, "$field values must be strings.",
          (value) => value is String);

      return valueNode.value as V;
    };

    return mapMap(node.nodes,
        key: (keyNode, _) => key(keyNode),
        value: (_, valueNode) => value(valueNode));
  }

  /// Verifies that [node]'s value is an optionally hyphenated Dart identifier,
  /// and returns it
  String _parseIdentifierLike(YamlNode node, String name) {
    _validate(node, "$name must be a string.", (value) => value is String);
    _validate(node, "$name must be an (optionally hyphenated) Dart identifier.",
        (value) => value.contains(anchoredHyphenatedIdentifier));
    return node.value;
  }

  /// Parses [node]'s value as a boolean selector.
  BooleanSelector _parseBooleanSelector(String name) =>
      _parseValue(name, (value) => new BooleanSelector.parse(value));

  /// Parses [node]'s value as a platform selector.
  PlatformSelector _parsePlatformSelector(String field) {
    var node = _document.nodes[field];
    if (node == null) return null;
    return _parseNode(
        node, field, (value) => new PlatformSelector.parse(value, node.span));
  }

  /// Asserts that [node] is a string, passes its value to [parse], and returns
  /// the result.
  ///
  /// If [parse] throws a [FormatException], it's wrapped to include [node]'s
  /// span.
  T _parseNode<T>(YamlNode node, String name, T parse(String value)) {
    _validate(node, "$name must be a string.", (value) => value is String);

    try {
      return parse(node.value);
    } on FormatException catch (error) {
      throw new SourceSpanFormatException(
          'Invalid $name: ${error.message}', node.span, _source);
    }
  }

  /// Asserts that [field] is a string, passes it to [parse], and returns the
  /// result.
  ///
  /// If [parse] throws a [FormatException], it's wrapped to include [field]'s
  /// span.
  T _parseValue<T>(String field, T parse(String value)) {
    var node = _document.nodes[field];
    if (node == null) return null;
    return _parseNode(node, field, parse);
  }

  /// Parses a nested configuration document.
  ///
  /// [name] is the name of the field, which is used for error-handling.
  /// [runnerConfig] controls whether runner configuration is allowed in the
  /// nested configuration. It defaults to [_runnerConfig].
  Configuration _nestedConfig(YamlNode node, String name, {bool runnerConfig}) {
    if (node == null || node.value == null) return Configuration.empty;

    _validate(node, "$name must be a map.", (value) => value is Map);
    var loader = new _ConfigurationLoader(node, _source,
        global: _global, runnerConfig: runnerConfig ?? _runnerConfig);
    return loader.load();
  }

  /// Takes a map that contains [Configuration]s and extracts any
  /// preset-specific configuration into a parent [Configuration].
  ///
  /// This is needed because parameters to [new Configuration] such as
  /// `onPlatform` take maps to [SuiteConfiguration]s. [SuiteConfiguration]
  /// doesn't support preset-specific configuration, so this extracts the preset
  /// logic into a parent [Configuration], leaving only maps to
  /// [SuiteConfiguration]s. The [create] function is used to construct
  /// [Configuration]s from the resolved maps.
  Configuration _extractPresets<T>(Map<T, Configuration> map,
      Configuration create(Map<T, SuiteConfiguration> map)) {
    if (map.isEmpty) return Configuration.empty;

    var base = <T, SuiteConfiguration>{};
    var presets = <String, Map<T, SuiteConfiguration>>{};
    map.forEach((key, config) {
      base[key] = config.suiteDefaults;
      config.presets.forEach((preset, presetConfig) {
        presets.putIfAbsent(preset, () => {})[key] = presetConfig.suiteDefaults;
      });
    });

    if (presets.isEmpty) {
      return base.isEmpty ? Configuration.empty : create(base);
    } else {
      var newPresets =
          mapMap<String, Map<T, SuiteConfiguration>, String, Configuration>(
              presets,
              value: (_, map) => create(map));
      return create(base).change(presets: newPresets);
    }
  }

  /// Asserts that [map] has a field named [field] and returns it.
  YamlNode _expect(YamlMap map, String field) {
    var node = map.nodes[field];
    if (node != null) return node;

    throw new SourceSpanFormatException(
        'Missing required field "$field".', map.span, _source);
  }

  /// Throws an error if a field named [field] exists at this level.
  void _disallow(String field) {
    if (!_document.containsKey(field)) return;

    throw new SourceSpanFormatException(
        "$field isn't supported here.",
        // We need the key as a [YamlNode] to get its span.
        _document.nodes.keys.firstWhere((key) => key.value == field).span,
        _source);
  }

  /// Throws a [SourceSpanFormatException] with [message] about [field].
  void _error(String message, String field) {
    throw new SourceSpanFormatException(
        message, _document.nodes[field].span, _source);
  }
}
