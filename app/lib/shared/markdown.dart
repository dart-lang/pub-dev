// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:logging/logging.dart';
import 'package:markdown/markdown.dart' as m;
import 'package:path/path.dart' as p;

final Logger _logger = new Logger('pub.markdown');

final List<m.InlineSyntax> _inlineSyntaxes = m
    .ExtensionSet.gitHubWeb.inlineSyntaxes
    .where((s) => s is! m.InlineHtmlSyntax)
    .toList();

String markdownToHtml(String text, String baseUrl) {
  if (text == null) return null;
  final m.InlineSyntax relativeLink = _RelativeLinkSyntax.parse(baseUrl);
  final inlineSyntaxes = <m.InlineSyntax>[];
  if (relativeLink != null) {
    inlineSyntaxes.insert(0, relativeLink);
  }
  inlineSyntaxes.addAll(_inlineSyntaxes);
  return m.markdownToHtml(
    text,
    extensionSet: m.ExtensionSet.none,
    blockSyntaxes: m.ExtensionSet.gitHubWeb.blockSyntaxes,
    inlineSyntaxes: inlineSyntaxes,
  );
}

class _RelativeLinkSyntax extends m.LinkSyntax {
  final Uri baseUri;
  _RelativeLinkSyntax(this.baseUri);

  static _RelativeLinkSyntax parse(String url) {
    try {
      final Uri uri = Uri.parse(url);
      if (uri.scheme != 'http' && uri.scheme != 'https') return null;
      if (uri.host == null || uri.host.isEmpty || !uri.host.contains('.'))
        return null;
      return new _RelativeLinkSyntax(uri);
    } catch (e) {
      // url is user-provided, may be malicious, ignoring errors.
    }
    return null;
  }

  @override
  m.Link getLink(m.InlineParser parser, Match match, m.TagState state) {
    final m.Link link = super.getLink(parser, match, state);
    if (link != null && _isRelativePathUrl(link.url)) {
      try {
        final List<String> fragmentParts = link.url.split('#');
        final String relativeUrl = fragmentParts.first;
        final String fragment =
            fragmentParts.length == 2 ? fragmentParts[1] : null;
        final Uri newUri = new Uri(
          scheme: baseUri.scheme,
          host: baseUri.host,
          port: baseUri.port,
          path: p.join(baseUri.path, relativeUrl),
          fragment: fragment,
        );
        return new m.Link(link.id, newUri.toString(), link.title);
      } catch (e, st) {
        _logger.warning('Relative link rewrite failed: ${link.url}', e, st);
      }
    }
    return link;
  }

  bool _isRelativePathUrl(String url) =>
      url != null && !url.startsWith('#') && !url.contains(':');
}
