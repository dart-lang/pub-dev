// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:logging/logging.dart';
import 'package:markdown/markdown.dart' as m;
import 'package:path/path.dart' as p;

final Logger _logger = new Logger('pub.markdown');

final List<m.BlockSyntax> _blockSyntaxes =
    m.ExtensionSet.gitHub.blockSyntaxes.toList();

final List<m.InlineSyntax> _inlineSyntaxes = m
    .ExtensionSet.gitHub.inlineSyntaxes
    .where((s) => s is! m.InlineHtmlSyntax)
    .toList();

String markdownToHtml(String text, String baseUrl) {
  return m.markdownToHtml(
    text,
    extensionSet: _createCustomExtension(baseUrl),
    blockSyntaxes: _blockSyntaxes,
    inlineSyntaxes: _inlineSyntaxes,
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

m.ExtensionSet _createCustomExtension(String baseUrl) {
  final m.InlineSyntax relativeLink = _RelativeLinkSyntax.parse(baseUrl);
  if (relativeLink == null) return m.ExtensionSet.none;
  return new _ExtensionSet(inlineSyntaxes: [relativeLink]);
}

class _ExtensionSet implements m.ExtensionSet {
  @override
  final List<m.BlockSyntax> blockSyntaxes;

  @override
  final List<m.InlineSyntax> inlineSyntaxes;

  _ExtensionSet({this.blockSyntaxes: const [], this.inlineSyntaxes: const []});
}
