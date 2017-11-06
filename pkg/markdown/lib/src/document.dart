library markdown.src.document;

import 'ast.dart';
import 'block_parser.dart';
import 'extension_set.dart';
import 'inline_parser.dart';

/// Maintains the context needed to parse a Markdown document.
class Document {
  final Map<String, Link> refLinks = {};
  Iterable<BlockSyntax> blockSyntaxes;
  Iterable<InlineSyntax> inlineSyntaxes;
  ExtensionSet extensionSet;
  Resolver linkResolver;
  Resolver imageLinkResolver;

  Document(
      {Iterable<BlockSyntax> blockSyntaxes,
      Iterable<InlineSyntax> inlineSyntaxes,
      ExtensionSet extensionSet,
      this.linkResolver,
      this.imageLinkResolver}) {
    this.extensionSet = extensionSet ?? ExtensionSet.commonMark;
    this.blockSyntaxes = new Set()
      ..addAll(blockSyntaxes ?? [])
      ..addAll(this.extensionSet.blockSyntaxes);
    this.inlineSyntaxes = new Set()
      ..addAll(inlineSyntaxes ?? [])
      ..addAll(this.extensionSet.inlineSyntaxes);
  }

  /// Parses the given [lines] of Markdown to a series of AST nodes.
  List<Node> parseLines(List<String> lines) {
    List<Node> nodes = new BlockParser(lines, this).parseLines();
    _parseInlineContent(nodes);
    return nodes;
  }

  /// Parses the given inline Markdown [text] to a series of AST nodes.
  List<Node> parseInline(String text) => new InlineParser(text, this).parse();

  void _parseInlineContent(List<Node> nodes) {
    for (int i = 0; i < nodes.length; i++) {
      var node = nodes[i];
      if (node is UnparsedContent) {
        List<Node> inlineNodes = parseInline(node.textContent);
        nodes.removeAt(i);
        nodes.insertAll(i, inlineNodes);
        i += inlineNodes.length - 1;
      } else if (node is Element && node.children != null) {
        _parseInlineContent(node.children);
      }
    }
  }
}

class Link {
  final String id;
  final String url;
  final String title;
  Link(this.id, this.url, this.title);
}
