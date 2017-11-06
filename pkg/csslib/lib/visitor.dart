// Copyright (c) 2012, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library csslib.visitor;

import 'package:source_span/source_span.dart';
import 'parser.dart';

part 'src/css_printer.dart';
part 'src/tree.dart';
part 'src/tree_base.dart';
part 'src/tree_printer.dart';

abstract class VisitorBase {
  visitCalcTerm(CalcTerm node);
  visitCssComment(CssComment node);
  visitCommentDefinition(CommentDefinition node);
  visitStyleSheet(StyleSheet node);
  visitNoOp(NoOp node);
  visitTopLevelProduction(TopLevelProduction node);
  visitDirective(Directive node);
  visitDocumentDirective(DocumentDirective node);
  visitSupportsDirective(SupportsDirective node);
  visitSupportsConditionInParens(SupportsConditionInParens node);
  visitSupportsNegation(SupportsNegation node);
  visitSupportsConjunction(SupportsConjunction node);
  visitSupportsDisjunction(SupportsDisjunction node);
  visitViewportDirective(ViewportDirective node);
  visitMediaExpression(MediaExpression node);
  visitMediaQuery(MediaQuery node);
  visitMediaDirective(MediaDirective node);
  visitHostDirective(HostDirective node);
  visitPageDirective(PageDirective node);
  visitCharsetDirective(CharsetDirective node);
  visitImportDirective(ImportDirective node);
  visitKeyFrameDirective(KeyFrameDirective node);
  visitKeyFrameBlock(KeyFrameBlock node);
  visitFontFaceDirective(FontFaceDirective node);
  visitStyletDirective(StyletDirective node);
  visitNamespaceDirective(NamespaceDirective node);
  visitVarDefinitionDirective(VarDefinitionDirective node);
  visitMixinDefinition(MixinDefinition node);
  visitMixinRulesetDirective(MixinRulesetDirective node);
  visitMixinDeclarationDirective(MixinDeclarationDirective node);
  visitIncludeDirective(IncludeDirective node);
  visitContentDirective(ContentDirective node);

  visitRuleSet(RuleSet node);
  visitDeclarationGroup(DeclarationGroup node);
  visitMarginGroup(MarginGroup node);
  visitDeclaration(Declaration node);
  visitVarDefinition(VarDefinition node);
  visitIncludeMixinAtDeclaration(IncludeMixinAtDeclaration node);
  visitExtendDeclaration(ExtendDeclaration node);
  visitSelectorGroup(SelectorGroup node);
  visitSelector(Selector node);
  visitSimpleSelectorSequence(SimpleSelectorSequence node);
  visitSimpleSelector(SimpleSelector node);
  visitElementSelector(ElementSelector node);
  visitNamespaceSelector(NamespaceSelector node);
  visitAttributeSelector(AttributeSelector node);
  visitIdSelector(IdSelector node);
  visitClassSelector(ClassSelector node);
  visitPseudoClassSelector(PseudoClassSelector node);
  visitPseudoElementSelector(PseudoElementSelector node);
  visitPseudoClassFunctionSelector(PseudoClassFunctionSelector node);
  visitPseudoElementFunctionSelector(PseudoElementFunctionSelector node);
  visitNegationSelector(NegationSelector node);
  visitSelectorExpression(SelectorExpression node);

  visitUnicodeRangeTerm(UnicodeRangeTerm node);
  visitLiteralTerm(LiteralTerm node);
  visitHexColorTerm(HexColorTerm node);
  visitNumberTerm(NumberTerm node);
  visitUnitTerm(UnitTerm node);
  visitLengthTerm(LengthTerm node);
  visitPercentageTerm(PercentageTerm node);
  visitEmTerm(EmTerm node);
  visitExTerm(ExTerm node);
  visitAngleTerm(AngleTerm node);
  visitTimeTerm(TimeTerm node);
  visitFreqTerm(FreqTerm node);
  visitFractionTerm(FractionTerm node);
  visitUriTerm(UriTerm node);
  visitResolutionTerm(ResolutionTerm node);
  visitChTerm(ChTerm node);
  visitRemTerm(RemTerm node);
  visitViewportTerm(ViewportTerm node);
  visitFunctionTerm(FunctionTerm node);
  visitGroupTerm(GroupTerm node);
  visitItemTerm(ItemTerm node);
  visitIE8Term(IE8Term node);
  visitOperatorSlash(OperatorSlash node);
  visitOperatorComma(OperatorComma node);
  visitOperatorPlus(OperatorPlus node);
  visitOperatorMinus(OperatorMinus node);
  visitVarUsage(VarUsage node);

  visitExpressions(Expressions node);
  visitBinaryExpression(BinaryExpression node);
  visitUnaryExpression(UnaryExpression node);

  visitIdentifier(Identifier node);
  visitWildcard(Wildcard node);
  visitThisOperator(ThisOperator node);
  visitNegation(Negation node);

  visitDartStyleExpression(DartStyleExpression node);
  visitFontExpression(FontExpression node);
  visitBoxExpression(BoxExpression node);
  visitMarginExpression(MarginExpression node);
  visitBorderExpression(BorderExpression node);
  visitHeightExpression(HeightExpression node);
  visitPaddingExpression(PaddingExpression node);
  visitWidthExpression(WidthExpression node);
}

/** Base vistor class for the style sheet AST. */
class Visitor implements VisitorBase {
  /** Helper function to walk a list of nodes. */
  void _visitNodeList(List<TreeNode> list) {
    // Don't use iterable otherwise the list can't grow while using Visitor.
    // It certainly can't have items deleted before the index being iterated
    // but items could be added after the index.
    for (var index = 0; index < list.length; index++) {
      list[index].visit(this);
    }
  }

  visitTree(StyleSheet tree) => visitStyleSheet(tree);

  visitStyleSheet(StyleSheet ss) {
    _visitNodeList(ss.topLevels);
  }

  visitNoOp(NoOp node) {}

  visitTopLevelProduction(TopLevelProduction node) {}

  visitDirective(Directive node) {}

  visitCalcTerm(CalcTerm node) {
    visitLiteralTerm(node);
    visitLiteralTerm(node.expr);
  }

  visitCssComment(CssComment node) {}

  visitCommentDefinition(CommentDefinition node) {}

  visitMediaExpression(MediaExpression node) {
    visitExpressions(node.exprs);
  }

  visitMediaQuery(MediaQuery node) {
    for (var mediaExpr in node.expressions) {
      visitMediaExpression(mediaExpr);
    }
  }

  visitDocumentDirective(DocumentDirective node) {
    _visitNodeList(node.functions);
    _visitNodeList(node.groupRuleBody);
  }

  visitSupportsDirective(SupportsDirective node) {
    node.condition.visit(this);
    _visitNodeList(node.groupRuleBody);
  }

  visitSupportsConditionInParens(SupportsConditionInParens node) {
    node.condition.visit(this);
  }

  visitSupportsNegation(SupportsNegation node) {
    node.condition.visit(this);
  }

  visitSupportsConjunction(SupportsConjunction node) {
    _visitNodeList(node.conditions);
  }

  visitSupportsDisjunction(SupportsDisjunction node) {
    _visitNodeList(node.conditions);
  }

  visitViewportDirective(ViewportDirective node) {
    node.declarations.visit(this);
  }

  visitMediaDirective(MediaDirective node) {
    _visitNodeList(node.mediaQueries);
    _visitNodeList(node.rules);
  }

  visitHostDirective(HostDirective node) {
    _visitNodeList(node.rules);
  }

  visitPageDirective(PageDirective node) {
    for (var declGroup in node._declsMargin) {
      if (declGroup is MarginGroup) {
        visitMarginGroup(declGroup);
      } else {
        visitDeclarationGroup(declGroup);
      }
    }
  }

  visitCharsetDirective(CharsetDirective node) {}

  visitImportDirective(ImportDirective node) {
    for (var mediaQuery in node.mediaQueries) {
      visitMediaQuery(mediaQuery);
    }
  }

  visitKeyFrameDirective(KeyFrameDirective node) {
    visitIdentifier(node.name);
    _visitNodeList(node._blocks);
  }

  visitKeyFrameBlock(KeyFrameBlock node) {
    visitExpressions(node._blockSelectors);
    visitDeclarationGroup(node._declarations);
  }

  visitFontFaceDirective(FontFaceDirective node) {
    visitDeclarationGroup(node._declarations);
  }

  visitStyletDirective(StyletDirective node) {
    _visitNodeList(node.rules);
  }

  visitNamespaceDirective(NamespaceDirective node) {}

  visitVarDefinitionDirective(VarDefinitionDirective node) {
    visitVarDefinition(node.def);
  }

  visitMixinRulesetDirective(MixinRulesetDirective node) {
    _visitNodeList(node.rulesets);
  }

  visitMixinDefinition(MixinDefinition node) {}

  visitMixinDeclarationDirective(MixinDeclarationDirective node) {
    visitDeclarationGroup(node.declarations);
  }

  visitIncludeDirective(IncludeDirective node) {
    for (var index = 0; index < node.args.length; index++) {
      var param = node.args[index];
      _visitNodeList(param);
    }
  }

  visitContentDirective(ContentDirective node) {
    // TODO(terry): TBD
  }

  visitRuleSet(RuleSet node) {
    visitSelectorGroup(node._selectorGroup);
    visitDeclarationGroup(node._declarationGroup);
  }

  visitDeclarationGroup(DeclarationGroup node) {
    _visitNodeList(node.declarations);
  }

  visitMarginGroup(MarginGroup node) => visitDeclarationGroup(node);

  visitDeclaration(Declaration node) {
    visitIdentifier(node._property);
    if (node._expression != null) node._expression.visit(this);
  }

  visitVarDefinition(VarDefinition node) {
    visitIdentifier(node._property);
    if (node._expression != null) node._expression.visit(this);
  }

  visitIncludeMixinAtDeclaration(IncludeMixinAtDeclaration node) {
    visitIncludeDirective(node.include);
  }

  visitExtendDeclaration(ExtendDeclaration node) {
    _visitNodeList(node.selectors);
  }

  visitSelectorGroup(SelectorGroup node) {
    _visitNodeList(node.selectors);
  }

  visitSelector(Selector node) {
    _visitNodeList(node.simpleSelectorSequences);
  }

  visitSimpleSelectorSequence(SimpleSelectorSequence node) {
    node.simpleSelector.visit(this);
  }

  visitSimpleSelector(SimpleSelector node) => node._name.visit(this);

  visitNamespaceSelector(NamespaceSelector node) {
    if (node._namespace != null) node._namespace.visit(this);
    if (node.nameAsSimpleSelector != null) {
      node.nameAsSimpleSelector.visit(this);
    }
  }

  visitElementSelector(ElementSelector node) => visitSimpleSelector(node);

  visitAttributeSelector(AttributeSelector node) {
    visitSimpleSelector(node);
  }

  visitIdSelector(IdSelector node) => visitSimpleSelector(node);

  visitClassSelector(ClassSelector node) => visitSimpleSelector(node);

  visitPseudoClassSelector(PseudoClassSelector node) =>
      visitSimpleSelector(node);

  visitPseudoElementSelector(PseudoElementSelector node) =>
      visitSimpleSelector(node);

  visitPseudoClassFunctionSelector(PseudoClassFunctionSelector node) =>
      visitSimpleSelector(node);

  visitPseudoElementFunctionSelector(PseudoElementFunctionSelector node) =>
      visitSimpleSelector(node);

  visitNegationSelector(NegationSelector node) => visitSimpleSelector(node);

  visitSelectorExpression(SelectorExpression node) {
    _visitNodeList(node.expressions);
  }

  visitUnicodeRangeTerm(UnicodeRangeTerm node) {}

  visitLiteralTerm(LiteralTerm node) {}

  visitHexColorTerm(HexColorTerm node) {}

  visitNumberTerm(NumberTerm node) {}

  visitUnitTerm(UnitTerm node) {}

  visitLengthTerm(LengthTerm node) {
    visitUnitTerm(node);
  }

  visitPercentageTerm(PercentageTerm node) {
    visitLiteralTerm(node);
  }

  visitEmTerm(EmTerm node) {
    visitLiteralTerm(node);
  }

  visitExTerm(ExTerm node) {
    visitLiteralTerm(node);
  }

  visitAngleTerm(AngleTerm node) {
    visitUnitTerm(node);
  }

  visitTimeTerm(TimeTerm node) {
    visitUnitTerm(node);
  }

  visitFreqTerm(FreqTerm node) {
    visitUnitTerm(node);
  }

  visitFractionTerm(FractionTerm node) {
    visitLiteralTerm(node);
  }

  visitUriTerm(UriTerm node) {
    visitLiteralTerm(node);
  }

  visitResolutionTerm(ResolutionTerm node) {
    visitUnitTerm(node);
  }

  visitChTerm(ChTerm node) {
    visitUnitTerm(node);
  }

  visitRemTerm(RemTerm node) {
    visitUnitTerm(node);
  }

  visitViewportTerm(ViewportTerm node) {
    visitUnitTerm(node);
  }

  visitFunctionTerm(FunctionTerm node) {
    visitLiteralTerm(node);
    visitExpressions(node._params);
  }

  visitGroupTerm(GroupTerm node) {
    for (var term in node._terms) {
      term.visit(this);
    }
  }

  visitItemTerm(ItemTerm node) {
    visitNumberTerm(node);
  }

  visitIE8Term(IE8Term node) {}

  visitOperatorSlash(OperatorSlash node) {}

  visitOperatorComma(OperatorComma node) {}

  visitOperatorPlus(OperatorPlus node) {}

  visitOperatorMinus(OperatorMinus node) {}

  visitVarUsage(VarUsage node) {
    _visitNodeList(node.defaultValues);
  }

  visitExpressions(Expressions node) {
    _visitNodeList(node.expressions);
  }

  visitBinaryExpression(BinaryExpression node) {
    // TODO(terry): TBD
    throw new UnimplementedError();
  }

  visitUnaryExpression(UnaryExpression node) {
    // TODO(terry): TBD
    throw new UnimplementedError();
  }

  visitIdentifier(Identifier node) {}

  visitWildcard(Wildcard node) {}

  visitThisOperator(ThisOperator node) {}

  visitNegation(Negation node) {}

  visitDartStyleExpression(DartStyleExpression node) {}

  visitFontExpression(FontExpression node) {
    // TODO(terry): TBD
    throw new UnimplementedError();
  }

  visitBoxExpression(BoxExpression node) {
    // TODO(terry): TBD
    throw new UnimplementedError();
  }

  visitMarginExpression(MarginExpression node) {
    // TODO(terry): TBD
    throw new UnimplementedError();
  }

  visitBorderExpression(BorderExpression node) {
    // TODO(terry): TBD
    throw new UnimplementedError();
  }

  visitHeightExpression(HeightExpression node) {
    // TODO(terry): TB
    throw new UnimplementedError();
  }

  visitPaddingExpression(PaddingExpression node) {
    // TODO(terry): TBD
    throw new UnimplementedError();
  }

  visitWidthExpression(WidthExpression node) {
    // TODO(terry): TBD
    throw new UnimplementedError();
  }
}
