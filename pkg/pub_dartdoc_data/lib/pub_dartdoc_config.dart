// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:io';

import 'package:json_annotation/json_annotation.dart';
import 'package:path/path.dart' as p;

part 'pub_dartdoc_config.g.dart';

final _customizerConfigFileName = '.pub-customizer-config.json';

@JsonSerializable()
class DartdocCustomizerConfig {
  final String packageName;
  final String packageVersion;
  final bool isLatestStable;
  final String docRootUrl;
  final String latestStableDocumentationUrl;
  final String pubPackagePageUrl;
  final String dartLogoSvgUrl;
  final String githubMarkdownCssUrl;
  final String gtmJsUrl;
  final List<String> trustedTargetHosts;
  final List<String> trustedUrlSchemes;

  DartdocCustomizerConfig({
    required this.packageName,
    required this.packageVersion,
    required this.isLatestStable,
    required this.docRootUrl,
    required this.latestStableDocumentationUrl,
    required this.pubPackagePageUrl,
    required this.dartLogoSvgUrl,
    required this.githubMarkdownCssUrl,
    required this.gtmJsUrl,
    required this.trustedTargetHosts,
    required this.trustedUrlSchemes,
  });

  DartdocCustomizerConfig.test({
    required this.packageName,
    required this.packageVersion,
    required this.isLatestStable,
    this.dartLogoSvgUrl = '/static/img/dart-logo.svg',
    this.githubMarkdownCssUrl = '/static/css/github-markdown.css',
    this.gtmJsUrl = '/static/js/gtm.js',
    this.trustedTargetHosts = const ['api.dart.dev', 'api.flutter.dev'],
    this.trustedUrlSchemes = const ['http', 'https', 'mailto'],
  })  : docRootUrl = '/documentations/$packageName/$packageVersion',
        latestStableDocumentationUrl = '/documentations/$packageName/latest',
        pubPackagePageUrl = '/packages/$packageName';

  factory DartdocCustomizerConfig.fromJson(Map<String, dynamic> json) =>
      _$DartdocCustomizerConfigFromJson(json);

  /// Try to read the config from from the input directory.
  /// Returns `null` if the config file does not exists.
  static DartdocCustomizerConfig? tryReadFromDirectorySync(String directory) {
    final file = File(p.join(directory, _customizerConfigFileName));
    if (file.existsSync()) {
      final content = file.readAsStringSync();
      return DartdocCustomizerConfig.fromJson(
          json.decode(content) as Map<String, dynamic>);
    }
    return null;
  }

  Map<String, dynamic> toJson() => _$DartdocCustomizerConfigToJson(this);

  void writeToDirectorySync(String directory) {
    final file = File(p.join(directory, _customizerConfigFileName));
    final content = json.encode(toJson());
    file.writeAsStringSync(content);
  }

  void deleteFromDirectorySync(String directory) {
    final file = File(p.join(directory, _customizerConfigFileName));
    if (file.existsSync()) {
      file.deleteSync();
    }
  }
}
