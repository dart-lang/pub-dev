import 'dart:io' as io;

import 'package:markdown/markdown.dart';
import 'package:pub_dev/frontend/dom/dom.dart' as dom;
import 'package:simple_mustache/simple_mustache.dart';

const _structuralHeaderTags = ['h1', 'h2', 'h3', 'h4', 'h5', 'h6'];
final currentUri = Uri();
const rootDir = './toc_experiment';

String generateFragment(String text) => BlockSyntax.generateAnchorHash(
  Element.text('h1', text),
);

/// A section of the Table of Contents
class TocNode {
  /// What level heading this node is.
  ///
  /// This is not defined by what tag it is using, or how many `#` it has, but rather
  /// how many levels of nesting have occurred in the document so far. That is to say,
  ///
  /// ```md
  /// # Level 1
  /// ### Level 2
  /// ##### Level 3
  /// ```
  int level;

  /// The HTML node that represents the title of this node.
  Node titleNode;

  /// The list of [TocNode] that are nested under this heading.
  List<TocNode> children;

  /// The parent heading for this node.
  TocNode? parent;

  TocNode({required this.level,required this.titleNode, this.parent}) :
    children = [];

  /// The title of the node, as a string.
  String get title => titleNode.textContent;

  /// Where this heading should point to on the page.
  Uri get href => currentUri.replace(fragment: generateFragment(title));

  /// Generates a nested list of this heading and all its children.
  dom.Node toHtml() => dom.li(
    children: [
      dom.a(text: title, href: href.toString()),
      dom.ul(
        children: [
          for (final child in children)
            child.toHtml(),
        ],
      ),
    ],
  );
}

List<TocNode> parse(List<Node> nodes) {
  final result = <TocNode>[];
  TocNode? currentSection;

  for (final node in nodes) {
    if (node is! Element) continue;

    final currentLevel = _structuralHeaderTags.indexOf(node.tag);
    final isHeading = currentLevel != -1;
    if (!isHeading) continue;

    final section = TocNode(titleNode: node, level: currentLevel);
    if (currentSection == null) {
      currentSection = section;
      result.add(section);
      continue;
    }

    var previousLevel = currentSection.level;

    if (currentLevel > previousLevel) {
      currentSection.children.add(section);
      section.parent = currentSection;
      currentSection = section;
      continue;
    } else if (currentLevel < previousLevel) {
      while (currentLevel < previousLevel) {
        currentSection = currentSection?.parent;
        previousLevel = currentSection!.level;
      }
      if (currentSection?.parent != null) {
        currentSection = currentSection!.parent;
        section.parent = currentSection;
        currentSection!.children.add(section);
        currentSection = section;
      } else {
        result.add(section);
        currentSection = section;
      }
    } else {
      if (currentSection.parent != null) {
        currentSection = currentSection.parent;
        section.parent = currentSection;
        currentSection!.children.add(section);
        currentSection = section;
      } else {
        result.add(section);
        currentSection = section;
      }
    }
  }
  return result;
}

dom.Node renderToc(List<TocNode> toc) => dom.ul(
  children: [
    for (final heading in toc)
      heading.toHtml(),
  ]
);

void main(List<String> args) {
  final file = io.File('$rootDir/readme.md');
  final markdown = file.readAsStringSync();
  final nodes = getNodes(markdown);
  final toc = parse(nodes);
  renderMarkdownWithToc(markdown, toc);
}

void renderMarkdownWithToc(String markdown, List<TocNode> sections) {
  final templateFile = io.File('$rootDir/md_toc.template');
  final template = templateFile.readAsStringSync();
  final readme = dom.markdown(markdown);
  final toc = renderToc(sections);
  final map = {'toc': toc.toString(), 'main': readme.toString()};
  final html = Mustache(map: map).convert(template);
  final outputFile = io.File('$rootDir/index.html');
  outputFile.writeAsStringSync(html.toString());
}

List<Node> getNodes(String markdown) {
  final document = Document();
  final lines = markdown.replaceAll('\r\n', '\n').split('\n');
  return document.parseLines(lines);
}
