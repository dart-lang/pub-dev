import 'dart:io' as io;

import 'package:markdown/markdown.dart';
import 'package:pub_dev/frontend/static_files.dart';
import 'package:pub_dev/frontend/templates/views/shared/layout.dart';
import 'package:simple_mustache/simple_mustache.dart';
import 'package:pub_dev/frontend/dom/dom.dart' as dom;

const _structuralHeaderTags = ['h1', 'h2', 'h3', 'h4', 'h5', 'h6'];
final currentUri = Uri();
const rootDir = './toc_experiment';

String generateFragment(String text) => BlockSyntax.generateAnchorHash(
  Element.text('h1', text),
);

/// A section of the Table of Contents
class TocSection {
  int level;
  Node titleNode;
  List<TocSection> children;
  TocSection? parent;
  String tag;

  TocSection({required this.level, required this.tag, required this.titleNode, this.parent}) :
    children = [];

  String get title => titleNode.textContent;

  Uri get href => currentUri.replace(fragment: id);

  String get id => generateFragment(title);

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

List<TocSection> parse(List<Node> nodes) {
  final result = <TocSection>[];
  TocSection? currentSection;

  for (final node in nodes) {
    if (node is! Element) continue;

    final currentLevel = _structuralHeaderTags.indexOf(node.tag);
    final isHeading = currentLevel != -1;
    if (!isHeading) continue;

    final section = TocSection(titleNode: node, tag: node.tag, level: currentLevel);
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

dom.Node renderToc(List<TocSection> toc) {
  final children = <dom.Node>[];
  for (final heading in toc) {
    children.add(heading.toHtml());
  }
  return dom.ul(children: children);
}

void main(List<String> args) {
  final file = io.File('$rootDir/readme.md');
  final markdown = file.readAsStringSync();
  final nodes = getNodes(markdown);
  final toc = parse(nodes);
  renderMarkdownWithToc(markdown, toc);
}

void renderMarkdownWithToc(String markdown, List<TocSection> sections) {
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
