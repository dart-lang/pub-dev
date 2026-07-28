// Copyright 2019 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     https://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:html/dom.dart';
import 'package:html/parser.dart' as html_parser;

final _allowedElements = <String>{
  'H1',
  'H2',
  'H3',
  'H4',
  'H5',
  'H6',
  'H7',
  'H8',
  'BR',
  'B',
  'I',
  'STRONG',
  'EM',
  'A',
  'PRE',
  'CODE',
  'IMG',
  'TT',
  'DIV',
  'INS',
  'DEL',
  'SUP',
  'SUB',
  'P',
  'PICTURE',
  'OL',
  'UL',
  'TABLE',
  'THEAD',
  'TBODY',
  'TFOOT',
  'BLOCKQUOTE',
  'DL',
  'DT',
  'DD',
  'KBD',
  'Q',
  'SAMP',
  'VAR',
  'HR',
  'RUBY',
  'RT',
  'RP',
  'LI',
  'TR',
  'TD',
  'TH',
  'S',
  'STRIKE',
  'SUMMARY',
  'DETAILS',
  'CAPTION',
  'FIGURE',
  'FIGCAPTION',
  'ABBR',
  'BDO',
  'CITE',
  'DFN',
  'MARK',
  'SMALL',
  'SOURCE',
  'SPAN',
  'TIME',
  'WBR',
};

final _alwaysAllowedAttributes = <String>{
  'abbr',
  'accept',
  'accept-charset',
  'accesskey',
  'action',
  'align',
  'alt',
  'aria-describedby',
  'aria-hidden',
  'aria-label',
  'aria-labelledby',
  'axis',
  'border',
  'cellpadding',
  'cellspacing',
  'char',
  'charoff',
  'charset',
  'checked',
  'clear',
  'cols',
  'colspan',
  'color',
  'compact',
  'coords',
  'datetime',
  'dir',
  'disabled',
  'enctype',
  'for',
  'frame',
  'headers',
  'height',
  'hreflang',
  'hspace',
  'ismap',
  'label',
  'lang',
  'maxlength',
  'media',
  'method',
  'multiple',
  'name',
  'nohref',
  'noshade',
  'nowrap',
  'open',
  'prompt',
  'readonly',
  'rel',
  'rev',
  'rows',
  'rowspan',
  'rules',
  'scope',
  'selected',
  'shape',
  'size',
  'span',
  'start',
  'summary',
  'tabindex',
  'target',
  'title',
  'type',
  'usemap',
  'valign',
  'value',
  'vspace',
  'width',
  'itemprop',
};

bool _alwaysAllowed(String _) => true;

bool _validLink(String url) {
  try {
    final uri = Uri.parse(url);
    return uri.isScheme('https') ||
        uri.isScheme('http') ||
        uri.isScheme('mailto') ||
        !uri.hasScheme;
  } on FormatException {
    return false;
  }
}

bool _validUrl(String url) {
  try {
    final uri = Uri.parse(url);
    return uri.isScheme('https') || uri.isScheme('http') || !uri.hasScheme;
  } on FormatException {
    return false;
  }
}

// `srcset` is a comma-separated list of "<url> [descriptor]" candidates.
// Validate every candidate's URL with the same scheme rules as `src`, so a
// single bad entry (e.g. a `javascript:` URL) rejects the whole attribute. The
// optional descriptor must be a width (`640w`) or pixel-density (`1.5x`) value;
// arbitrary trailing text rejects the attribute.
//
// See also: https://html.spec.whatwg.org/multipage/images.html#srcset-attributes
final _srcsetDescriptor = RegExp(r'^(?:[0-9]+w|[0-9]*\.?[0-9]+x)$');

bool _validSrcset(String value) {
  for (final candidate in value.split(',')) {
    final trimmed = candidate.trim();
    if (trimmed.isEmpty) continue;
    final parts = trimmed.split(RegExp(r'\s+'));
    if (!_validUrl(parts.first)) return false;
    if (parts.length > 2) return false;
    if (parts.length == 2 && !_srcsetDescriptor.hasMatch(parts[1])) {
      return false;
    }
  }
  return true;
}

final _citeAttributeValidator = <String, bool Function(String)>{
  'cite': _validUrl,
};

final _elementAttributeValidators =
    <String, Map<String, bool Function(String)>>{
  'A': {
    'href': _validLink,
  },
  'IMG': {
    'src': _validUrl,
    'longdesc': _validUrl,
  },
  'SOURCE': {
    'srcset': _validSrcset,
  },
  'DIV': {
    'itemscope': _alwaysAllowed,
    'itemtype': _alwaysAllowed,
  },
  'BLOCKQUOTE': _citeAttributeValidator,
  'DEL': _citeAttributeValidator,
  'INS': _citeAttributeValidator,
  'Q': _citeAttributeValidator,
};

/// An implementation of [html.NodeValidator] that only allows sane HTML tags
/// and attributes protecting against XSS.
///
/// Modeled after the [rules employed by Github][1] when sanitizing GFM (Github
/// Flavored Markdown). Notably this excludes CSS styles and other tags that
/// easily interferes with the rest of the page.
///
/// [1]: https://github.com/gjtorikian/html-pipeline/blob/main/lib/html_pipeline/sanitization_filter.rb
class SaneHtmlValidator {
  final bool Function(String)? allowElements;
  final bool Function(String)? allowElementId;
  final bool Function(String)? allowClassName;
  final Iterable<String>? Function(String)? addLinkRel;

  SaneHtmlValidator({
    required this.allowElements,
    required this.allowElementId,
    required this.allowClassName,
    required this.addLinkRel,
  });

  String sanitize(String htmlString) {
    final root = html_parser.parseFragment(htmlString);
    _sanitize(root);
    return root.outerHtml;
  }

  void _sanitize(Node node) {
    if (node is Element) {
      final tagName = node.localName!.toUpperCase();
      if (!_allowedElements.contains(tagName) &&
          !(allowElements?.call(tagName) ?? false)) {
        node.remove();
        return;
      }
      node.attributes.removeWhere((k, v) {
        final attrName = k.toString();
        if (attrName == 'id') {
          return allowElementId == null || !allowElementId!(v);
        }
        if (attrName == 'class') {
          if (allowClassName == null) return true;
          node.classes.removeWhere((cn) => !allowClassName!(cn));
          return node.classes.isEmpty;
        }
        return !_isAttributeAllowed(tagName, attrName, v);
      });
      if (tagName == 'A') {
        final href = node.attributes['href'];
        if (href != null && addLinkRel != null) {
          final rels = addLinkRel!(href);
          if (rels != null && rels.isNotEmpty) {
            final currentRel = node.attributes['rel'] ?? '';
            final allRels = <String>{
              ...currentRel.split(' ').where((e) => e.isNotEmpty),
              ...rels,
            };
            node.attributes['rel'] = allRels.join(' ');
          }
        }
      }
    }
    if (node.hasChildNodes()) {
      // doing it in reverse order, because we could otherwise skip one, when a
      // node is removed...
      for (var i = node.nodes.length - 1; i >= 0; i--) {
        _sanitize(node.nodes[i]);
      }
    }
  }

  bool _isAttributeAllowed(String tagName, String attrName, String value) {
    if (_alwaysAllowedAttributes.contains(attrName)) return true;

    // Special validators for special attributes on special tags (href/src/cite)
    final attributeValidators = _elementAttributeValidators[tagName];
    if (attributeValidators == null) {
      return false;
    }

    final validator = attributeValidators[attrName];
    if (validator == null) {
      return false;
    }

    return validator(value);
  }
}
