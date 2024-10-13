// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:html/dom.dart';
import 'package:html/parser.dart' as parser;

/// Validates the HTML content and throws AssertionError if any of the
/// following issues are present:
/// - Canonical URL has invalid format or value.
/// - Inline JavaScript actions are present (e.g. `onclick`).
/// - Links with `<a target="_blank">` do not have `rel="noopener"`.
/// - `<script> tags have no `src` attribute or have content (except `ld+json`
///   meta content).
void parseAndValidateHtml(String html) {
  if (html.startsWith('<html>')) {
    html = '<!DOCTYPE html>\n$html';
  }
  validateHtml(parser.HtmlParser(html, strict: true).parse());
}

/// Validates the parsed HTML content and throws AssertionError if any of the
/// following issues are present:
/// - Inline JavaScript actions are present (e.g. `onclick`).
/// - Links with `<a target="_blank">` do not have `rel="noopener"`.
/// - Links with `href="/packages?q=*"` do have `rel="nofollow"`.
/// - `<script> tags have no `src` attribute or have content (except `ld+json`
///   meta content).
void validateHtml(Node root) {
  final List<Element> Function(String selector) querySelectorAll;
  if (root is DocumentFragment) {
    querySelectorAll = root.querySelectorAll;
  } else if (root is Document) {
    _validateCanonicalLink(root.querySelector('head')!);
    querySelectorAll = root.querySelectorAll;
  } else {
    throw AssertionError('Unknown html element type: $root');
  }

  for (final elem in querySelectorAll('*')) {
    // No inline JS attribute
    for (final attr in elem.attributes.keys) {
      final name = attr.toString();
      if (name.toLowerCase().startsWith('on')) {
        throw AssertionError(
            'No inline JS attribute is allowed, found: ${elem.outerHtml}.');
      }
    }
    // alt attribute should not contain the element type
    final alt = elem.attributes['alt']?.toLowerCase();
    if (alt != null) {
      if (alt.split(' ').contains('icon')) {
        throw AssertionError(
            '"alt" attribute should not contain the type of the element: ${elem.outerHtml}');
      }
    }
  }

  // All <a target="_blank"> links must have rel="noopener"
  final links = querySelectorAll('a');
  for (Element elem in links) {
    if (elem.attributes['target'] == '_blank') {
      if (!elem.attributes.containsKey('rel')) {
        throw AssertionError(
            '_blank links must have rel=noopener, found: ${elem.outerHtml}.');
      }
      final rel = elem.attributes['rel']!;
      if (!rel.split(' ').contains('noopener')) {
        throw AssertionError(
            '_blank links must have rel=noopener, found: ${elem.outerHtml}.');
      }
    }
  }

  // All <a href=""> links must be valid and have only single slashes.
  for (final elem in links) {
    final href = elem.attributes['href'];
    if (href == null || href.isEmpty) continue;

    final uri = Uri.tryParse(href);
    if (uri == null) {
      throw AssertionError('Unable to parse URL: "$href".');
    }
    if (uri.query.contains('//')) {
      // exempt report page deep links
      if (!uri.query.contains('content_id=')) {
        throw AssertionError('Double-slash URL detected: "$href".');
      }
    }
    if (uri.path == '/packages' && uri.queryParameters.containsKey('q')) {
      final rel = elem.attributes['rel'] ?? '';
      if (!rel.split(' ').contains('nofollow')) {
        throw AssertionError(
            'Package search URL must use nofollow: "${elem.outerHtml}".');
      }
    }
  }

  // Link to report page must have url attribute.
  for (final elem in links) {
    final href = elem.attributes['href'];
    if (href == null || !href.contains('/report?')) continue;
    final uri = Uri.parse(href);

    final subject = uri.queryParameters['subject'];
    if (subject == null || subject.isEmpty) {
      throw AssertionError('Report page URL must have `subject` attribute.');
    }

    final url = uri.queryParameters['url'];
    if (url == null || url.isEmpty) {
      throw AssertionError('Report page URL must have `url` attribute.');
    }
  }

  // No inline script tag.
  final scripts = querySelectorAll('script');
  for (Element elem in scripts) {
    if (elem.attributes['type'] == 'application/ld+json') {
      if (elem.attributes.length != 1) {
        throw AssertionError(
            'Only a single attribute is allowed on ld+json, found: ${elem.outerHtml}');
      }
      if (elem.text.trim().isEmpty) {
        throw AssertionError('ld+json element must not be empty.');
      }
      // trigger parsing of the content
      final map = json.decode(elem.text) as Map;
      final context = map['@context'];
      if (context is String) {
        final isHttpOrHttps =
            context.startsWith('http://') || context.startsWith('https://');
        if (!isHttpOrHttps) {
          throw AssertionError('Invalid @context value: $map');
        }
      }
    } else {
      final src = elem.attributes['src'];
      if (src == null || src.isEmpty) {
        throw AssertionError(
            'script tag must have src attribute, found: ${elem.parent?.outerHtml}');
      }
      if (elem.text.trim().isNotEmpty) {
        throw AssertionError(
            'script tag must text content must be empty, found: ${elem.outerHtml}');
      }
    }
  }

  // Lighthouse flags buttons that don't have text content or an `aria-label`/`title` property.
  final buttons = querySelectorAll('button');
  for (final elem in buttons) {
    final text = elem.attributes['aria-label']?.trim() ??
        elem.attributes['title']?.trim() ??
        elem.text.trim();
    if (text.isEmpty) {
      // Exempt buttons in dartdoc output:
      // TODO: remove after dartdoc content is updated.
      if (elem.outerHtml ==
          '<button id=\"sidenav-left-toggle\" type=\"button\">&nbsp;</button>') {
        continue;
      }
      throw AssertionError(
          'button tag text content or aria-label must not be empty, found: ${elem.outerHtml}');
    }
  }

  // No need for `aria-label` if it has the same content as `title`.
  for (final elem in querySelectorAll('[aria-label]')) {
    final ariaLabel = elem.attributes['aria-label']!.trim();
    final title = elem.attributes['title']?.trim();
    if (title != null && title == ariaLabel) {
      throw AssertionError(
          'Element has the same `title` and `aria-label` attribute, keep the `title`: ${elem.outerHtml}');
    }
  }

  // "role"="<role>" attributes should be on interactive components
  final allowedForRole = {'a', 'form'};
  for (final elem in querySelectorAll('[role]')) {
    final tag = elem.localName!;
    final role = elem.attributes['role'];
    // image elements may have presentation role
    if (tag == 'img' && role == 'presentation') continue;
    // interactive elements
    if (elem.attributes.containsKey('tabindex')) continue;
    if (allowedForRole.contains(tag)) continue;
    // material components
    if (tag == 'th' && role == 'columnheader') continue;
    throw AssertionError(
        '<$tag> tag should not have role attribute, found: ${elem.outerHtml}');
  }
}

/// "Google Search result usually points to the canonical page, unless one of
/// the duplicates is explicitly better suited for a user."
/// https://developers.google.com/search/docs/advanced/crawling/consolidate-duplicate-urls
///
/// To make sure we optimize our ranking, we should have a canonical URL for
/// every content we serve. This helps not only with duplicate pages inside our
/// site, but also handles proxying mirrors, which - accidentally or not - would
/// otherwise compete to rank for the same content.
///
/// If a page doesn't have a canonical URL (because it is non-public, and/or
/// customized to the current user), the page should be marked as `noindex`:
/// "When Googlebot next crawls that page and sees the tag or header, Googlebot
/// will drop that page entirely from Google Search results, regardless of
/// whether other sites link to it."
/// https://developers.google.com/search/docs/advanced/crawling/block-indexing
void _validateCanonicalLink(Element head) {
  final canonicalLinks = head
      .querySelectorAll('link')
      .where((e) => e.attributes['rel'] == 'canonical')
      .toList();
  if (canonicalLinks.length > 1) {
    throw AssertionError('More than one canonical link was specified.');
  }
  if (canonicalLinks.isEmpty) {
    final robotsValues = head
        .querySelectorAll('meta')
        .where((elem) => elem.attributes['name'] == 'robots')
        .map((elem) => elem.attributes['content'])
        .expand((v) => v!.split(' '))
        .toSet();
    if (!robotsValues.contains('noindex')) {
      throw AssertionError(
          'When canonical URL is missing, noindex must be set.');
    }
  }
  if (canonicalLinks.length == 1) {
    final link = canonicalLinks.single;
    final href = link.attributes['href']!;
    if (!href.startsWith('https://pub.dev/')) {
      throw AssertionError(
          'Canonical URL must start with https://pub.dev/, found: $href.');
    }
    final uri = Uri.parse(href);
    if (uri.pathSegments.contains('.') || uri.pathSegments.contains('..')) {
      throw AssertionError(
          'Canonical URL must not contain /./ or /../, found: $href.');
    }
  }
}
