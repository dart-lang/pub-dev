// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:collection';

import 'package:boolean_selector/boolean_selector.dart';
import 'package:collection/collection.dart';

import '../frontend/skip.dart';
import '../frontend/timeout.dart';
import '../utils.dart';
import 'operating_system.dart';
import 'platform_selector.dart';
import 'test_platform.dart';

/// Metadata for a test or test suite.
///
/// This metadata comes from declarations on the test itself; it doesn't include
/// configuration from the user.
class Metadata {
  /// Empty metadata with only default values.
  ///
  /// Using this is slightly more efficient than manually constructing a new
  /// metadata with no arguments.
  static final empty = new Metadata._();

  /// The selector indicating which platforms the suite supports.
  final PlatformSelector testOn;

  /// The modification to the timeout for the test or suite.
  final Timeout timeout;

  /// Whether the test or suite should be skipped.
  bool get skip => _skip ?? false;
  final bool _skip;

  /// The reason the test or suite should be skipped, if given.
  final String skipReason;

  /// Whether to use verbose stack traces.
  bool get verboseTrace => _verboseTrace ?? false;
  final bool _verboseTrace;

  /// Whether to chain stack traces.
  bool get chainStackTraces => _chainStackTraces ?? true;
  final bool _chainStackTraces;

  /// The user-defined tags attached to the test or suite.
  final Set<String> tags;

  /// The number of times to re-run a test before being marked as a failure.
  int get retry => _retry ?? 0;
  final int _retry;

  /// Platform-specific metadata.
  ///
  /// Each key identifies a platform, and its value identifies the specific
  /// metadata for that platform. These can be applied by calling [forPlatform].
  final Map<PlatformSelector, Metadata> onPlatform;

  /// Metadata that applies only when specific tags are applied.
  ///
  /// Tag-specific metadata is applied when merging this with other metadata.
  /// Note that unlike [onPlatform], the base metadata takes precedence over any
  /// tag-specific metadata.
  ///
  /// This is guaranteed not to have any keys that match [tags]; those are
  /// resolved when the metadata is constructed.
  final Map<BooleanSelector, Metadata> forTag;

  /// Parses a user-provided map into the value for [onPlatform].
  static Map<PlatformSelector, Metadata> _parseOnPlatform(
      Map<String, dynamic> onPlatform) {
    if (onPlatform == null) return {};

    var result = <PlatformSelector, Metadata>{};
    onPlatform.forEach((platform, metadata) {
      if (metadata is Timeout || metadata is Skip) {
        metadata = [metadata];
      } else if (metadata is! List) {
        throw new ArgumentError('Metadata for platform "$platform" must be a '
            'Timeout, Skip, or List of those; was "$metadata".');
      }

      var selector = new PlatformSelector.parse(platform);

      var timeout;
      var skip;
      for (var metadatum in metadata) {
        if (metadatum is Timeout) {
          if (timeout != null) {
            throw new ArgumentError('Only a single Timeout may be declared for '
                '"$platform".');
          }

          timeout = metadatum;
        } else if (metadatum is Skip) {
          if (skip != null) {
            throw new ArgumentError('Only a single Skip may be declared for '
                '"$platform".');
          }

          skip = metadatum.reason == null ? true : metadatum.reason;
        } else {
          throw new ArgumentError('Metadata for platform "$platform" must be a '
              'Timeout, Skip, or List of those; was "$metadata".');
        }
      }

      result[selector] = new Metadata.parse(timeout: timeout, skip: skip);
    });
    return result;
  }

  /// Parses a user-provided [String] or [Iterable] into the value for [tags].
  ///
  /// Throws an [ArgumentError] if [tags] is not a [String] or an [Iterable].
  static Set<String> _parseTags(tags) {
    if (tags == null) return new Set();
    if (tags is String) return new Set.from([tags]);
    if (tags is! Iterable) {
      throw new ArgumentError.value(
          tags, "tags", "must be either a String or an Iterable.");
    }

    if (tags.any((tag) => tag is! String)) {
      throw new ArgumentError.value(tags, "tags", "must contain only Strings.");
    }

    return new Set.from(tags);
  }

  /// Creates new Metadata.
  ///
  /// [testOn] defaults to [PlatformSelector.all].
  ///
  /// If [forTag] contains metadata that applies to [tags], that metadata is
  /// included inline in the returned value. The values directly passed to the
  /// constructor take precedence over tag-specific metadata.
  factory Metadata(
      {PlatformSelector testOn,
      Timeout timeout,
      bool skip,
      bool verboseTrace,
      bool chainStackTraces,
      int retry,
      String skipReason,
      Iterable<String> tags,
      Map<PlatformSelector, Metadata> onPlatform,
      Map<BooleanSelector, Metadata> forTag}) {
    // Returns metadata without forTag resolved at all.
    _unresolved() => new Metadata._(
        testOn: testOn,
        timeout: timeout,
        skip: skip,
        verboseTrace: verboseTrace,
        chainStackTraces: chainStackTraces,
        retry: retry,
        skipReason: skipReason,
        tags: tags,
        onPlatform: onPlatform,
        forTag: forTag);

    // If there's no tag-specific metadata, or if none of it applies, just
    // return the metadata as-is.
    if (forTag == null || tags == null) return _unresolved();
    tags = new Set.from(tags);
    forTag = new Map.from(forTag);

    // Otherwise, resolve the tag-specific components. Doing this eagerly means
    // we only have to resolve suite- or group-level tags once, rather than
    // doing it for every test individually.
    var empty = new Metadata._();
    var merged = forTag.keys.toList().fold(empty, (merged, selector) {
      if (!selector.evaluate(tags)) return merged;
      return merged.merge(forTag.remove(selector));
    });

    if (merged == empty) return _unresolved();
    return merged.merge(_unresolved());
  }

  /// Creates new Metadata.
  ///
  /// Unlike [new Metadata], this assumes [forTag] is already resolved.
  Metadata._(
      {PlatformSelector testOn,
      Timeout timeout,
      bool skip,
      this.skipReason,
      bool verboseTrace,
      bool chainStackTraces,
      int retry,
      Iterable<String> tags,
      Map<PlatformSelector, Metadata> onPlatform,
      Map<BooleanSelector, Metadata> forTag})
      : testOn = testOn == null ? PlatformSelector.all : testOn,
        timeout = timeout == null ? const Timeout.factor(1) : timeout,
        _skip = skip,
        _verboseTrace = verboseTrace,
        _chainStackTraces = chainStackTraces,
        _retry = retry,
        tags = new UnmodifiableSetView(tags == null ? new Set() : tags.toSet()),
        onPlatform =
            onPlatform == null ? const {} : new UnmodifiableMapView(onPlatform),
        forTag = forTag == null ? const {} : new UnmodifiableMapView(forTag) {
    if (retry != null) RangeError.checkNotNegative(retry, "retry");
    _validateTags();
  }

  /// Creates a new Metadata, but with fields parsed from caller-friendly values
  /// where applicable.
  ///
  /// Throws a [FormatException] if any field is invalid.
  Metadata.parse(
      {String testOn,
      Timeout timeout,
      skip,
      bool verboseTrace,
      bool chainStackTraces,
      int retry,
      Map<String, dynamic> onPlatform,
      tags})
      : testOn = testOn == null
            ? PlatformSelector.all
            : new PlatformSelector.parse(testOn),
        timeout = timeout == null ? const Timeout.factor(1) : timeout,
        _skip = skip == null ? null : skip != false,
        _verboseTrace = verboseTrace,
        _chainStackTraces = chainStackTraces,
        _retry = retry,
        skipReason = skip is String ? skip : null,
        onPlatform = _parseOnPlatform(onPlatform),
        tags = _parseTags(tags),
        forTag = const {} {
    if (skip != null && skip is! String && skip is! bool) {
      throw new ArgumentError(
          '"skip" must be a String or a bool, was "$skip".');
    }

    if (retry != null) RangeError.checkNotNegative(retry, "retry");

    _validateTags();
  }

  /// Deserializes the result of [Metadata.serialize] into a new [Metadata].
  Metadata.deserialize(serialized)
      : testOn = serialized['testOn'] == null
            ? PlatformSelector.all
            : new PlatformSelector.parse(serialized['testOn']),
        timeout = _deserializeTimeout(serialized['timeout']),
        _skip = serialized['skip'],
        skipReason = serialized['skipReason'],
        _verboseTrace = serialized['verboseTrace'],
        _chainStackTraces = serialized['chainStackTraces'],
        _retry = serialized['retry'],
        tags = new Set.from(serialized['tags']),
        onPlatform = new Map.fromIterable(serialized['onPlatform'],
            key: (pair) => new PlatformSelector.parse(pair.first),
            value: (pair) => new Metadata.deserialize(pair.last)),
        forTag = mapMap(serialized['forTag'],
            key: (key, _) => new BooleanSelector.parse(key),
            value: (_, nested) => new Metadata.deserialize(nested));

  /// Deserializes timeout from the format returned by [_serializeTimeout].
  static _deserializeTimeout(serialized) {
    if (serialized == 'none') return Timeout.none;
    var scaleFactor = serialized['scaleFactor'];
    if (scaleFactor != null) return new Timeout.factor(scaleFactor);
    return new Timeout(new Duration(microseconds: serialized['duration']));
  }

  /// Throws an [ArgumentError] if any tags in [tags] aren't hyphenated
  /// identifiers.
  void _validateTags() {
    var invalidTags = tags
        .where((tag) => !tag.contains(anchoredHyphenatedIdentifier))
        .map((tag) => '"$tag"')
        .toList();

    if (invalidTags.isEmpty) return;

    throw new ArgumentError("Invalid ${pluralize('tag', invalidTags.length)} "
        "${toSentence(invalidTags)}. Tags must be (optionally hyphenated) "
        "Dart identifiers.");
  }

  /// Throws a [FormatException] if any [PlatformSelector]s use any variables
  /// that don't appear either in [validVariables] or in the set of variables
  /// that are known to be valid for all selectors.
  void validatePlatformSelectors(Set<String> validVariables) {
    testOn.validate(validVariables);
    onPlatform.forEach((selector, metadata) {
      selector.validate(validVariables);
      metadata.validatePlatformSelectors(validVariables);
    });
  }

  /// Return a new [Metadata] that merges [this] with [other].
  ///
  /// If the two [Metadata]s have conflicting properties, [other] wins. If
  /// either has a [forTag] metadata for one of the other's tags, that metadata
  /// is merged as well.
  Metadata merge(Metadata other) => new Metadata(
      testOn: testOn.intersection(other.testOn),
      timeout: timeout.merge(other.timeout),
      skip: other._skip ?? _skip,
      skipReason: other.skipReason ?? skipReason,
      verboseTrace: other._verboseTrace ?? _verboseTrace,
      chainStackTraces: other._chainStackTraces ?? _chainStackTraces,
      retry: other._retry ?? _retry,
      tags: tags.union(other.tags),
      onPlatform: mergeMaps(onPlatform, other.onPlatform,
          value: (metadata1, metadata2) => metadata1.merge(metadata2)),
      forTag: mergeMaps(forTag, other.forTag,
          value: (metadata1, metadata2) => metadata1.merge(metadata2)));

  /// Returns a copy of [this] with the given fields changed.
  Metadata change(
      {PlatformSelector testOn,
      Timeout timeout,
      bool skip,
      bool verboseTrace,
      bool chainStackTraces,
      int retry,
      String skipReason,
      Map<PlatformSelector, Metadata> onPlatform,
      Set<String> tags,
      Map<BooleanSelector, Metadata> forTag}) {
    testOn ??= this.testOn;
    timeout ??= this.timeout;
    skip ??= this._skip;
    verboseTrace ??= this._verboseTrace;
    chainStackTraces ??= this._chainStackTraces;
    retry ??= this._retry;
    skipReason ??= this.skipReason;
    onPlatform ??= this.onPlatform;
    tags ??= this.tags;
    forTag ??= this.forTag;
    return new Metadata(
        testOn: testOn,
        timeout: timeout,
        skip: skip,
        verboseTrace: verboseTrace,
        chainStackTraces: chainStackTraces,
        skipReason: skipReason,
        onPlatform: onPlatform,
        tags: tags,
        forTag: forTag,
        retry: retry);
  }

  /// Returns a copy of [this] with all platform-specific metadata from
  /// [onPlatform] resolved.
  Metadata forPlatform(TestPlatform platform, {OperatingSystem os}) {
    if (onPlatform.isEmpty) return this;

    var metadata = this;
    onPlatform.forEach((platformSelector, platformMetadata) {
      if (!platformSelector.evaluate(platform, os: os)) return;
      metadata = metadata.merge(platformMetadata);
    });
    return metadata.change(onPlatform: {});
  }

  /// Serializes [this] into a JSON-safe object that can be deserialized using
  /// [new Metadata.deserialize].
  serialize() {
    // Make this a list to guarantee that the order is preserved.
    var serializedOnPlatform = [];
    onPlatform.forEach((key, value) {
      serializedOnPlatform.add([key.toString(), value.serialize()]);
    });

    return {
      'testOn': testOn == PlatformSelector.all ? null : testOn.toString(),
      'timeout': _serializeTimeout(timeout),
      'skip': _skip,
      'skipReason': skipReason,
      'verboseTrace': _verboseTrace,
      'chainStackTraces': _chainStackTraces,
      'retry': _retry,
      'tags': tags.toList(),
      'onPlatform': serializedOnPlatform,
      'forTag': mapMap(forTag,
          key: (selector, _) => selector.toString(),
          value: (_, metadata) => metadata.serialize())
    };
  }

  /// Serializes timeout into a JSON-safe object.
  _serializeTimeout(Timeout timeout) {
    if (timeout == Timeout.none) return 'none';
    return {
      'duration':
          timeout.duration == null ? null : timeout.duration.inMicroseconds,
      'scaleFactor': timeout.scaleFactor
    };
  }
}
