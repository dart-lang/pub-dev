// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library pub_dartlang_org.colored_markdown;

import 'dart:convert';

import 'package:analyzer/analyzer.dart';
import 'package:analyzer/dart/ast/token.dart';
import 'package:analyzer/src/dart/scanner/reader.dart';
import 'package:analyzer/src/dart/scanner/scanner.dart';
import 'package:analyzer/src/string_source.dart';
import 'package:html/parser.dart' as html;
import 'package:markdown/markdown.dart';

String markdownToHtml(String text) {
  var lines = text.replaceAll('\r\n', '\n').split('\n');

  var blockSyntaxes = new List.from(ExtensionSet.gitHub.blockSyntaxes);
  var inlineSyntaxes = new List.from(
      ExtensionSet.gitHub.inlineSyntaxes.where((s) => s is! InlineHtmlSyntax));
  var document = new Document(blockSyntaxes: blockSyntaxes,
                              inlineSyntaxes: inlineSyntaxes,
                              extensionSet: ExtensionSet.none);

  var blocks = document.parseLines(lines);

  var colorizer = new ColorizeDartCode();
  blocks.forEach((Node node) => node.accept(colorizer));

  return new HtmlRenderer().render(blocks);
}

Scanner _scanner(String contents, {String name}) {
  if (name == null) name = '<unknown source>';
  var source = new StringSource(contents, name);
  var reader = new CharSequenceReader(contents);
  var scanner =
      new Scanner(source, reader, AnalysisErrorListener.NULL_LISTENER);
  return scanner;
}

String unEscape(String msg) => html.parse(msg).body.text;
String escapeAngleBrackets(String msg)
    => const HtmlEscape(HtmlEscapeMode.ELEMENT).convert(msg);

void _writePrettifiedSource(String source, StringBuffer buffer) {
  Scanner scanner = _scanner(source);
  Token token = scanner.tokenize();

  int lineOfOffset(int offset) {
    int line = 0;
    // NOTE: We could use binary search, or even more efficiently
    // keep track of line/offset inside the `handleToken` method.
    while (line < (scanner.lineStarts.length - 1) &&
           scanner.lineStarts[line + 1] <= offset) {
      line++;
    }
    return line;
  }
  int offsetOfOffset(int offset) {
    return offset - scanner.lineStarts[lineOfOffset(offset)];
  }

  int line = 0;
  int lineOffset = 0;

  handleToken(Token token) {
    String klass = 'n';

    int newLine = lineOfOffset(token.offset);
    int newLineOffset = offsetOfOffset(token.offset);
    if (newLine > line) {
      buffer.write('\n' * (newLine - line));
      lineOffset = 0;
    }

    buffer.write(' ' * (newLineOffset - lineOffset));

    switch (token.type) {
      case TokenType.IDENTIFIER:
        var char = token.lexeme.substring(0, 1);
        if (char == char.toUpperCase()) {
          // We highlight X in "class X" and "new X".
          var previous = token.previous;
          if (token.precedingComments != null) {
            previous = previous.precedingComments;
          }
          if (previous != null && previous.type == TokenType.KEYWORD) {
            klass = 'nc';
          }
        }
        break;
      case TokenType.DOUBLE:
        klass = 'm';
        break;
      case TokenType.HEXADECIMAL:
        klass = 'm';
        break;
      case TokenType.INT:
        klass = 'm';
        break;
      case TokenType.KEYWORD:
        klass = 'k';
        break;
      case TokenType.MULTI_LINE_COMMENT:
        klass = 'c1';
        break;
      case TokenType.SCRIPT_TAG: break;
      case TokenType.SINGLE_LINE_COMMENT:
        klass = 'c1';
        break;
      case TokenType.STRING:
        klass = 's1';
        break;
      case TokenType.AMPERSAND: break;
      case TokenType.AMPERSAND_AMPERSAND: break;
      case TokenType.AMPERSAND_EQ: break;
      case TokenType.AT: break;
      case TokenType.BANG: break;
      case TokenType.BANG_EQ: break;
      case TokenType.BAR: break;
      case TokenType.BAR_BAR: break;
      case TokenType.BAR_EQ: break;
      case TokenType.COLON: break;
      case TokenType.COMMA: break;
      case TokenType.CARET: break;
      case TokenType.CARET_EQ: break;
      case TokenType.CLOSE_CURLY_BRACKET: break;
      case TokenType.CLOSE_PAREN: break;
      case TokenType.CLOSE_SQUARE_BRACKET: break;
      case TokenType.EQ: break;
      case TokenType.EQ_EQ: break;
      case TokenType.FUNCTION: break;
      case TokenType.GT: break;
      case TokenType.GT_EQ: break;
      case TokenType.GT_GT: break;
      case TokenType.GT_GT_EQ: break;
      case TokenType.HASH: break;
      case TokenType.INDEX: break;
      case TokenType.INDEX_EQ: break;
      case TokenType.IS: break;
      case TokenType.LT: break;
      case TokenType.LT_EQ: break;
      case TokenType.LT_LT: break;
      case TokenType.LT_LT_EQ: break;
      case TokenType.MINUS: break;
      case TokenType.MINUS_EQ: break;
      case TokenType.MINUS_MINUS: break;
      case TokenType.OPEN_CURLY_BRACKET: break;
      case TokenType.OPEN_PAREN: break;
      case TokenType.OPEN_SQUARE_BRACKET: break;
      case TokenType.PERCENT: break;
      case TokenType.PERCENT_EQ: break;
      case TokenType.PERIOD: break;
      case TokenType.PERIOD_PERIOD: break;
      case TokenType.PLUS: break;
      case TokenType.PLUS_EQ: break;
      case TokenType.PLUS_PLUS: break;
      case TokenType.QUESTION: break;
      case TokenType.SEMICOLON: break;
      case TokenType.SLASH: break;
      case TokenType.SLASH_EQ: break;
      case TokenType.STAR: break;
      case TokenType.STAR_EQ: break;
      case TokenType.STRING_INTERPOLATION_EXPRESSION: break;
      case TokenType.STRING_INTERPOLATION_IDENTIFIER: break;
      case TokenType.TILDE: break;
      case TokenType.TILDE_SLASH: break;
      case TokenType.TILDE_SLASH_EQ: break;
      case TokenType.BACKPING: break;
      case TokenType.BACKSLASH: break;
      case TokenType.PERIOD_PERIOD_PERIOD: break;
    }

    buffer.write(
        '<span class="$klass">${escapeAngleBrackets(token.lexeme)}</span>');

    line = lineOfOffset(token.end - 1);
    lineOffset = offsetOfOffset(token.end);
  }

  while (token != null) {
    var comment = token.precedingComments;
    if (comment != null) {
      while (comment != null) {
        handleToken(comment);
        comment = comment.next;
      }
    }
    handleToken(token);

    if (token == token.next) break;
    token = token.next;
  }
}

class ColorizeDartCode extends NodeVisitor {
  void visitText(Text text) {}

  bool visitElementBefore(Element element) {
    if (_isDartCodeElement(element)) {
      Text text = _getSourceFromElement(element);
      var buffer = new StringBuffer();
      _writePrettifiedSource(unEscape(text.text).trim(), buffer);

      element.attributes['class'] = 'highlight';
      element.children.clear();
      element.children.add(new Text('$buffer'));

      return false;
    }
    return true;
  }

  void visitElementAfter(Element element) {}

  bool _isDartCodeElement(Element element)
      => element.tag == 'pre' &&
         element.children.length == 1 && _isCodeElement(element.children.first);

  bool _isCodeElement(Element element)
      => element.tag == 'code' &&
         element.attributes['class'] == 'language-dart' &&
         element.children.length == 1 &&
         element.children[0] is Text;

  Text _getSourceFromElement(Element element)
      => (element.children.first as Element).children.first as Text;
}
