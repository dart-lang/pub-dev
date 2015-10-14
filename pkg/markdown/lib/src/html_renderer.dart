// Copyright (c) 2012, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library markdown.src.html_renderer;

import 'ast.dart';
import 'document.dart';
import 'inline_parser.dart';

/// Converts the given string of markdown to HTML.
String markdownToHtml(String markdown,
    {List<InlineSyntax> inlineSyntaxes,
    Resolver linkResolver,
    Resolver imageLinkResolver,
    bool inlineOnly: false}) {
  var document = new Document(
      inlineSyntaxes: inlineSyntaxes,
      imageLinkResolver: imageLinkResolver,
      linkResolver: linkResolver);

  if (inlineOnly) return renderToHtml(document.parseInline(markdown));

  // Replace windows line endings with unix line endings, and split.
  var lines = markdown.replaceAll('\r\n', '\n').split('\n');
  document.parseRefLinks(lines);

  return renderToHtml(document.parseLines(lines)) + '\n';
}

String renderToHtml(List<Node> nodes) => new HtmlRenderer().render(nodes);

/// Translates a parsed AST to HTML.
class HtmlRenderer implements NodeVisitor {
  static final BLOCK_TAGS = new RegExp('blockquote|h1|h2|h3|h4|h5|h6|hr|p|pre');

  StringBuffer buffer;

  HtmlRenderer();

  String render(List<Node> nodes) {
    buffer = new StringBuffer();

    for (final node in nodes) node.accept(this);

    return buffer.toString();
  }

  void visitText(Text text) {
    buffer.write(text.text);
  }

  bool visitElementBefore(Element element) {
    // Hackish. Separate block-level elements with newlines.
    if (!buffer.isEmpty && BLOCK_TAGS.firstMatch(element.tag) != null) {
      buffer.write('\n');
    }

    buffer.write('<${element.tag}');

    // Sort the keys so that we generate stable output.
    var attributeNames = element.attributes.keys.toList();
    attributeNames.sort((a, b) => a.compareTo(b));

    for (var name in attributeNames) {
      buffer.write(' $name="${element.attributes[name]}"');
    }

    if (element.isEmpty) {
      // Empty element like <hr/>.
      buffer.write(' />');
      return false;
    } else {
      buffer.write('>');
      return true;
    }
  }

  void visitElementAfter(Element element) {
    buffer.write('</${element.tag}>');
  }
}
