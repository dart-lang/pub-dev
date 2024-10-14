// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';

import 'package:clock/clock.dart';
import 'package:crypto/crypto.dart';
import 'package:shelf/shelf.dart' as shelf;

import '../../package/backend.dart';
import '../../package/models.dart';
import '../../shared/configuration.dart';
import '../../shared/redis_cache.dart';
import '../../shared/urls.dart' as urls;
import '../../shared/utils.dart';
import '../dom/dom.dart' as d;

/// Handles requests for /feed.atom
Future<shelf.Response> atomFeedHandler(shelf.Request request) async {
  final feedContent = await cache.atomFeedXml().get(() async {
    final versions = await packageBackend.latestPackageVersions(limit: 100);
    final feed = _feedFromPackageVersions(request.requestedUri, versions);
    return feed.toXmlDocument();
  });
  return shelf.Response.ok(
    feedContent,
    headers: {
      'content-type': 'application/atom+xml; charset="utf-8"',
      'x-content-type-options': 'nosniff',
    },
  );
}

class FeedEntry {
  final String id;
  final String title;
  final DateTime updated;
  final String? publisherId;
  final String? content;
  final String alternateUrl;
  final String? alternateTitle;

  FeedEntry(this.id, this.title, this.updated, this.publisherId, this.content,
      this.alternateUrl, this.alternateTitle);

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
  final String subTitle;
  final DateTime updated;
  final String author;
  final String alternateUrl;
  final String selfUrl;
  final String generator;
  final String generatorVersion;

  final List<FeedEntry> entries;

  Feed(
      this.id,
      this.title,
      this.subTitle,
      this.updated,
      this.author,
      this.alternateUrl,
      this.selfUrl,
      this.generator,
      this.generatorVersion,
      this.entries);

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
        d.element('subtitle', text: subTitle),
        ...entries.map((e) => e.toNode()),
      ],
    );
  }
}

Feed _feedFromPackageVersions(
  Uri requestedUri,
  List<PackageVersion> versions,
) {
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
    entries.add(FeedEntry(id, title, version.created!, version.publisherId,
        content, alternateUrl, alternateTitle));
  }

  final id =
      activeConfiguration.primarySiteUri.resolve('/feed.atom').toString();
  final selfUrl = id;

  final title = 'Pub Packages for Dart';
  final subTitle = 'Last Updated Packages';
  final alternateUrl =
      activeConfiguration.primarySiteUri.resolve('/').toString();
  final author = 'Dart Team';
  final updated = clock.now().toUtc();

  return Feed(id, title, subTitle, updated, author, alternateUrl, selfUrl,
      'Pub Feed Generator', '0.1.0', entries);
}
