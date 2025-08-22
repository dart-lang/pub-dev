// Copyright (c) 2025, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// The library provides support for parsing `CHANGELOG.md` files formatted
/// with Markdown. It converts the file's content into a structured [Changelog]
/// object, which encapsulates individual [Release] entries.

/// The [ChangelogParser] accommodates various formatting styles. It can
/// effectively parse changelogs with inconsistent header levels or those
/// that include additional information beyond just the version number in
/// the release header.
///
/// The parser is designed to support the widely adopted "Keep a Changelog"
/// format (see https://keepachangelog.com/en/1.1.0/ for details).
/// Additionally, it has been tested with a diverse set of changelog files
/// available as part of the packages on https://pub.dev/.
library;

import 'package:collection/collection.dart';
import 'package:html/dom.dart' as html;
import 'package:html/dom_parsing.dart' as dom_parsing;
import 'package:html/parser.dart' as html_parser;
import 'package:markdown/markdown.dart' as m;
import 'package:pub_semver/pub_semver.dart';

/// Represents the entire changelog, containing a list of releases.
class Changelog {
  /// The main title of the changelog (e.g., 'Changelog').
  final String? title;

  /// An optional introductory description for the changelog.
  final Content? description;

  /// A list of releases, typically in reverse chronological order.
  final List<Release> releases;

  Changelog({
    this.title,
    this.description,
    required this.releases,
  });
}

/// Represents a single version entry in the changelog,
/// such as '[1.2.0] - 2025-07-10' or the 'Unreleased' section.
class Release {
  /// The version string or section title (e.g., '1.2.0', 'Unreleased').
  final String version;

  /// The HTML anchor value (`id` attribute).
  final String? anchor;

  /// The text of the header after the version.
  final String? label;

  /// The release date for this version.
  /// `null` if it's the 'Unreleased' section or is missing
  final DateTime? date;

  /// The additional text of the label, without the [date] part (if present).
  final String? note;

  /// The content of the release.
  final Content content;

  Release({
    required this.version,
    this.anchor,
    this.label,
    this.date,
    this.note,
    required this.content,
  });
}

/// Describes an arbitrary piece of content (e.g. the description of a single version).
///
/// If the content is specified as parsed HTML nodes, the class will store it as-is,
/// and serialize them only when needed.
class Content {
  String? _asText;
  html.Node? _asNode;

  Content.fromHtmlText(String text) : _asText = text;
  Content.fromParsedHtml(List<html.Node> nodes) {
    _asNode = html.DocumentFragment();
    for (final node in nodes) {
      _asNode!.append(node);
    }
  }

  late final asHtmlText = () {
    if (_asText != null) return _asText!;
    final root = _asNode is html.DocumentFragment
        ? _asNode as html.DocumentFragment
        : html.DocumentFragment()
      ..append(_asNode!);
    return root.outerHtml;
  }();

  late final asHtmlNode = () {
    if (_asNode != null) return _asNode!;
    return html_parser.parseFragment(_asText!);
  }();

  late final asMarkdownText = () {
    final visitor = _MarkdownVisitor()..visit(asHtmlNode);
    return visitor.toString();
  }();
}

class _MarkdownVisitor extends dom_parsing.TreeVisitor {
  final _result = StringBuffer();
  int _listDepth = 0;

  void _write(String text) {
    _result.write(text);
  }

  void _writeln([String? text]) {
    if (text != null) {
      _write(text);
    }
    _write('\n');
  }

  void _visitChildrenInline(html.Element node) {
    for (var i = 0; i < node.nodes.length; i++) {
      final child = node.nodes[i];
      if (i > 0 && (node.nodes[i - 1].text?.endsWithWhitespace() ?? false)) {
        _result.write(' ');
      }
      visit(child);
    }
  }

  @override
  void visitElement(html.Element node) {
    final localName = node.localName!;

    switch (localName) {
      case 'h1':
        _write('# ');
        _visitChildrenInline(node);
        _writeln();
        _writeln();
        break;
      case 'h2':
        _write('## ');
        _visitChildrenInline(node);
        _writeln();
        _writeln();
        break;
      case 'h3':
        _write('### ');
        _visitChildrenInline(node);
        _writeln();
        _writeln();
        break;
      case 'h4':
        _write('#### ');
        _visitChildrenInline(node);
        _writeln();
        _writeln();
        break;
      case 'h5':
        _write('##### ');
        _visitChildrenInline(node);
        _writeln();
        _writeln();
        break;
      case 'h6':
        _write('###### ');
        _visitChildrenInline(node);
        _writeln();
        _writeln();
        break;
      case 'p':
        _visitChildrenInline(node);
        _writeln();
        _writeln();
        break;
      case 'br':
        _writeln();
        break;
      case 'strong':
      case 'b':
        _write('**');
        _visitChildrenInline(node);
        _write('**');
        break;
      case 'em':
      case 'i':
        _write('*');
        _visitChildrenInline(node);
        _write('*');
        break;
      case 'code':
        _write('`');
        _visitChildrenInline(node);
        _write('`');
        break;
      case 'pre':
        _writeln('```');
        visitChildren(node);
        _writeln('```');
        break;
      case 'blockquote':
        _write('>');
        _visitChildrenInline(node);
        _writeln();
        break;
      case 'a':
        final href = node.attributes['href'];
        if (href != null) {
          _write('[');
          _visitChildrenInline(node);
          _write(']($href)');
        } else {
          visitChildren(node);
        }
        break;
      case 'ul':
        _listDepth++;
        visitChildren(node);
        _listDepth--;
        if (_listDepth == 0) _writeln();
        break;
      case 'ol':
        _listDepth++;
        visitChildren(node);
        _listDepth--;
        if (_listDepth == 0) _writeln();
        break;
      case 'li':
        final parent = node.parent?.localName;
        final indent = '  ' * (_listDepth - 1);
        _write(indent);
        if (parent == 'ol') {
          _write('1. ');
        } else {
          _write('- ');
        }
        _visitChildrenInline(node);
        _writeln();
        break;
      case 'hr':
        _writeln('---');
        break;
      default:
        visitChildren(node);
        break;
    }
  }

  @override
  void visitText(html.Text node) {
    _result.write(node.text.normalizeAndTrim());
  }

  @override
  String toString() => _result.toString().trim();
}

extension on String {
  String normalizeAndTrim() {
    return replaceAll(RegExp(r'\s+'), ' ').trim();
  }

  bool endsWithWhitespace() {
    if (isEmpty) return false;
    final last = this[length - 1];
    return last == ' ' || last == '\n';
  }
}

/// Parses the changelog with pre-configured options.
class ChangelogParser {
  final _acceptedHeaderTags = ['h1', 'h2', 'h3', 'h4'];
  final bool _strictLevels;
  final int _partOfLevelThreshold;

  ChangelogParser({
    bool strictLevels = false,
    int partOfLevelThreshold = 2,
  })  : _strictLevels = strictLevels,
        _partOfLevelThreshold = partOfLevelThreshold;

  /// Parses markdown text into a [Changelog] structure.
  Changelog parseMarkdownText(String input) {
    final nodes =
        m.Document(extensionSet: m.ExtensionSet.gitHubWeb).parse(input);
    final rawHtml = m.renderToHtml(nodes);
    final root = html_parser.parseFragment(rawHtml);
    return parseHtmlNodes(root.nodes);
  }

  /// Parses HTML nodes into a [Changelog] structure.
  Changelog parseHtmlNodes(List<html.Node> input) {
    String? title;
    Content? description;
    final releases = <Release>[];

    String? firstReleaseLocalName;
    _ParsedHeader? current;

    var nodes = <html.Node>[];
    void finalizeNodes() {
      if (current == null) {
        description = Content.fromParsedHtml(nodes);
        if (description!.asHtmlText.trim().isEmpty) {
          description = null;
        }
      } else {
        releases.add(Release(
          version: current.version,
          anchor: current.anchor,
          label: current.label,
          date: current.date,
          note: current.note,
          content: Content.fromParsedHtml(nodes),
        ));
      }
      nodes = <html.Node>[];
    }

    for (final node in [...input]) {
      if (node is html.Element &&
          _acceptedHeaderTags.contains(node.localName)) {
        if (_strictLevels &&
            firstReleaseLocalName != null &&
            node.localName != firstReleaseLocalName) {
          continue;
        }
        final headerText = node.text.trim();

        // Check if this looks like a version header first
        final parsed = _tryParseAsHeader(node, headerText);

        final isNewVersion = parsed != null &&
            releases.every((r) => r.version != parsed.version) &&
            current?.version != parsed.version;
        final isPartOfCurrent = current != null &&
            parsed != null &&
            current.level + _partOfLevelThreshold <= parsed.level;
        if (isNewVersion && !isPartOfCurrent) {
          firstReleaseLocalName ??= node.localName!;
          finalizeNodes();
          current = parsed;
          continue;
        }

        // only consider as title if it's h1 and we haven't found any versions yet
        if (node.localName == 'h1' && title == null && current == null) {
          title = headerText;
          continue;
        }
      }

      // collect nodes for description (before any version) or current release
      nodes.add(node);
    }

    // complete last section
    finalizeNodes();

    return Changelog(
      title: title,
      description: description,
      releases: releases,
    );
  }

  /// Parses the release header line or return `null` when no version part was recognized.
  ///
  /// Handles some of the common formats:
  /// - `1.2.0`
  /// - `v1.2.0`
  /// - `[1.2.0] - 2025-07-14`
  /// - `unreleased`
  /// - `next release (...)`
  _ParsedHeader? _tryParseAsHeader(html.Element elem, String input) {
    final level = _acceptedHeaderTags.indexOf(elem.localName!);

    final anchor = elem.attributes['id'];
    // special case: unreleased
    final inputLowerCase = input.toLowerCase().trim();
    final unreleasedTexts = ['unreleased', 'next release'];
    for (final unreleasedText in unreleasedTexts) {
      if (inputLowerCase == unreleasedText) {
        return _ParsedHeader(level, 'Unreleased', null, null, anchor, null);
      }
      if (inputLowerCase.startsWith('$unreleasedText ')) {
        String? label = input.substring(unreleasedText.length + 1).trim();
        if (label.isEmpty) {
          label = null;
        }
        return _ParsedHeader(level, 'Unreleased', label, null, anchor, null);
      }
    }

    // extract version
    final versionPart = input.split(' ').firstWhereOrNull((e) => e.isNotEmpty);
    if (versionPart == null) {
      return null;
    }
    final version = _parseVersionPart(versionPart.trim());
    if (version == null) {
      return null;
    }

    // rest of the release header
    String? label =
        input.substring(input.indexOf(versionPart) + versionPart.length).trim();
    if (label.startsWith('- ')) {
      label = label.substring(2).trim();
    }
    if (label.isEmpty) {
      label = null;
    }

    DateTime? date;
    String? note;

    if (label != null) {
      final parts = label.split(' ');
      date = _parseDatePart(parts[0].trim());
      if (date != null) {
        parts.removeAt(0);
      }

      if (parts.isNotEmpty) {
        note = parts.join(' ');
      }
    }

    return _ParsedHeader(level, version, label, date,
        anchor ?? version.replaceAll('.', ''), note);
  }

  /// Parses the version part of a release title.
  ///
  /// Returns the extracted version string, or null if no version was recognized.
  String? _parseVersionPart(String input) {
    // remove brackets or 'v' if present
    if (input.startsWith('[') && input.endsWith(']')) {
      input = input.substring(1, input.length - 1).trim();
    }
    if (input.startsWith('v')) {
      input = input.substring(1).trim();
    }

    // sanity check if it's a valid semantic version
    try {
      final version = Version.parse(input);
      if (!version.isEmpty && !version.isAny) {
        return input;
      }
    } on FormatException catch (_) {}

    return null;
  }

  final _yyyymmddDateFormats = <RegExp>[
    RegExp(r'^(\d{4})-(\d{2})-(\d{2})$'), // 2025-07-10
    RegExp(r'^(\d{4})/(\d{2})/(\d{2})$'), // 2025/07/10
  ];

  /// Parses the date part of a release title.
  ///
  /// Returns the parsed date or null if no date was recognized.
  ///
  /// Note: currently only date formats that start with a year are recognized.
  DateTime? _parseDatePart(String input) {
    if (input.startsWith('(') && input.endsWith(')')) {
      input = input.substring(1, input.length - 1);
    }
    for (final format in _yyyymmddDateFormats) {
      final match = format.matchAsPrefix(input);
      if (match == null) continue;
      final year = int.parse(match.group(1)!);
      final month = int.parse(match.group(2)!);
      final day = int.parse(match.group(3)!);
      final date = DateTime(year, month, day);
      // sanity check for overflow dates
      if (date.year != year || date.month != month || date.day != day) {
        continue;
      }
      return date;
    }

    return null;
  }
}

class _ParsedHeader {
  final int level;
  final String version;
  final String? label;
  final DateTime? date;
  final String? anchor;
  final String? note;

  _ParsedHeader(
      this.level, this.version, this.label, this.date, this.anchor, this.note);
}
