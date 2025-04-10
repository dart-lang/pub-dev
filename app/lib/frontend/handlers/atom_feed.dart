// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';

import 'package:clock/clock.dart';
import 'package:crypto/crypto.dart';
import 'package:shelf/shelf.dart' as shelf;

import '../../admin/actions/actions.dart';
import '../../package/backend.dart';
import '../../package/models.dart';
import '../../package/overrides.dart';
import '../../shared/configuration.dart';
import '../../shared/redis_cache.dart';
import '../../shared/urls.dart' as urls;
import '../../shared/utils.dart';
import '../dom/dom.dart' as d;

/// Handles requests for `/feed.atom`
Future<shelf.Response> allPackagesAtomFeedhandler(shelf.Request request) async {
  final feedContent =
      await cache.allPackagesAtomFeedXml().get(buildAllPackagesAtomFeedContent);
  return shelf.Response.ok(
    feedContent,
    headers: {
      'content-type': 'application/atom+xml; charset="utf-8"',
      'x-content-type-options': 'nosniff',
    },
  );
}

/// Handles requests for `/packages/<package>/feed.atom`
Future<shelf.Response> packageAtomFeedhandler(
  shelf.Request request,
  String package,
) async {
  checkPackageVersionParams(package);
  final feedContent = await cache
      .packageAtomFeedXml(package)
      .get(() => buildPackageAtomFeedContent(package));
  return shelf.Response.ok(
    feedContent,
    headers: {
      'content-type': 'application/atom+xml; charset="utf-8"',
      'x-content-type-options': 'nosniff',
    },
  );
}

/// Builds the content of the /feed.atom endpoint.
Future<String> buildAllPackagesAtomFeedContent() async {
  final versions = await packageBackend.latestPackageVersions(limit: 100);
  versions.removeWhere((pv) => pv.isModerated || pv.isRetracted);
  final feed = _allPackagesFeed(versions);
  return feed.toXmlDocument();
}

/// Builds the content of the `/packages/<package>/feed.atom` endpoint.
Future<String> buildPackageAtomFeedContent(String package) async {
  if (isSoftRemoved(package) ||
      !await packageBackend.isPackageVisible(package)) {
    throw NotFoundException.resource(package);
  }
  final versions = await packageBackend
      .streamVersionsOfPackage(
        package,
        order: '-created',
        limit: 10,
      )
      .toList();
  versions.removeWhere((pv) => pv.isModerated || pv.isRetracted);
  final feed = _packageFeed(package, versions);
  return feed.toXmlDocument();
}

class FeedEntry {
  final String id;
  final String title;
  final DateTime updated;
  final String? publisherId;
  final String? content;
  final String alternateUrl;
  final String? alternateTitle;

  FeedEntry({
    required this.id,
    required this.title,
    required this.updated,
    this.publisherId,
    required this.content,
    required this.alternateUrl,
    required this.alternateTitle,
  });

  d.Node toNode() {
    return d.element(
      'entry',
      children: [
        d.element('id', text: 'urn:uuid:$id'),
        d.element('title', text: title),
        d.element('updated', text: updated.toIso8601String()),
        if (publisherId != null)
          d.element('author', child: d.element('name', text: publisherId)),
        d.element('content', text: content),
        d.element(
          'link',
          attributes: {
            'href': alternateUrl,
            'rel': 'alternate',
            'title': alternateTitle ?? '',
          },
        ),
      ],
    );
  }
}

class Feed {
  final String id;
  final String title;
  final String? subTitle;
  final DateTime updated;
  final String? author;
  final String alternateUrl;
  final String selfUrl;
  final String generator;
  final String generatorVersion;

  final List<FeedEntry> entries;

  Feed({
    required this.title,
    this.subTitle,
    this.author,
    required this.alternateUrl,
    required this.selfUrl,
    this.generator = 'Pub Feed Generator',
    this.generatorVersion = '0.1.0',
    required this.entries,
  })  : id = selfUrl,
        // Set the updated timestamp to the latest version timestamp. This prevents
        // unnecessary updates in the exported API bucket and makes tests consistent.
        updated = entries.isNotEmpty
            ? entries
                .map((v) => v.updated)
                .reduce((a, b) => a.isAfter(b) ? a : b)
            : clock.now().toUtc();

  String toXmlDocument() {
    final buffer = StringBuffer();
    buffer.writeln('<?xml version="1.0" encoding="UTF-8"?>');
    buffer.writeln(toNode().toString());
    return buffer.toString();
  }

  d.Node toNode() {
    return d.element(
      'feed',
      attributes: {'xmlns': 'http://www.w3.org/2005/Atom'},
      children: [
        d.element('id', text: id),
        d.element('title', text: title),
        d.element('updated', text: updated.toIso8601String()),
        if (author != null)
          d.element('author', child: d.element('name', text: author)),
        d.element(
          'link',
          attributes: {'href': alternateUrl, 'rel': 'alternate'},
        ),
        d.element('link', attributes: {'href': selfUrl, 'rel': 'self'}),
        d.element(
          'generator',
          attributes: {'version': generatorVersion},
          text: generator,
        ),
        if (subTitle != null) d.element('subtitle', text: subTitle),
        ...entries.map((e) => e.toNode()),
      ],
    );
  }
}

Feed _allPackagesFeed(List<PackageVersion> versions) {
  final entries = <FeedEntry>[];
  for (var i = 0; i < versions.length; i++) {
    final version = versions[i];

    final pkgPage = urls.pkgPageUrl(version.package);
    final alternateUrl =
        activeConfiguration.primarySiteUri.replace(path: pkgPage).toString();
    final alternateTitle = version.package;

    final hash =
        sha512.convert(utf8.encode('${version.package}/${version.version}'));
    final id = createUuid(hash.bytes.sublist(0, 16));
    final title = 'v${version.version} of ${version.package}';
    final content = version.ellipsizedDescription ?? '[no description]';
    entries.add(FeedEntry(
      id: id,
      title: title,
      updated: version.created!,
      publisherId: version.publisherId,
      content: content,
      alternateUrl: alternateUrl,
      alternateTitle: alternateTitle,
    ));
  }

  return Feed(
    title: 'Pub Packages for Dart',
    subTitle: 'Last Updated Packages',
    author: 'Dart Team',
    alternateUrl: activeConfiguration.primarySiteUri.resolve('/').toString(),
    selfUrl:
        activeConfiguration.primarySiteUri.resolve('/feed.atom').toString(),
    entries: entries,
  );
}

Feed _packageFeed(String package, List<PackageVersion> versions) {
  return Feed(
    title: 'Most recently published versions for package $package',
    alternateUrl: activeConfiguration.primarySiteUri
        .resolve(urls.pkgPageUrl(package))
        .toString(),
    subTitle: versions.firstOrNull?.ellipsizedDescription,
    selfUrl: activeConfiguration.primarySiteUri
        .resolve(urls.pkgFeedUrl(package))
        .toString(),
    author: versions.firstOrNull?.publisherId,
    entries: versions.map((v) {
      final hash =
          sha512.convert(utf8.encode('package-feed/$package/${v.version}'));
      final id = createUuid(hash.bytes.sublist(0, 16));
      final alternateUrl = activeConfiguration.primarySiteUri
          .replace(
              path: urls.pkgPageUrl(
            package,
            version: v.version,
          ))
          .toString();
      return FeedEntry(
        id: id,
        title: 'v${v.version} of $package',
        alternateUrl: alternateUrl,
        alternateTitle: v.version,
        content:
            '${v.version} was published on ${shortDateFormat.format(v.created!)}.',
        updated: v.created!,
      );
    }).toList(),
  );
}
