import 'dart:async';
import 'dart:html';
import 'package:markdown/markdown.dart' as md;

import 'highlight.dart';

final markdownInput = querySelector('#markdown') as TextAreaElement;
final htmlDiv = querySelector('#html') as DivElement;
final versionSpan = querySelector('.version') as SpanElement;

final nullSanitizer = new NullTreeSanitizer();
const typing = const Duration(milliseconds: 150);
final introText = r'''Markdown is the **best**!

* It has lists.
* It has [links](http://dartlang.org).
* It has _so much more_...''';

// Flavor support.
final basicRadio = querySelector('#basic-radio') as HtmlElement;
final commonmarkRadio = querySelector('#commonmark-radio') as HtmlElement;
final gfmRadio = querySelector('#gfm-radio') as HtmlElement;
md.ExtensionSet extensionSet;

final extensionSets = {
  'basic-radio': md.ExtensionSet.none,
  'commonmark-radio': md.ExtensionSet.commonMark,
  'gfm-radio': md.ExtensionSet.gitHub,
};

void main() {
  versionSpan.text = 'v${md.version}';
  markdownInput.onKeyUp.listen(_renderMarkdown);

  String savedMarkdown = window.localStorage['markdown'];

  if (savedMarkdown != null &&
      savedMarkdown.isNotEmpty &&
      savedMarkdown != introText) {
    markdownInput.value = savedMarkdown;
    markdownInput.focus();
    _renderMarkdown();
  } else {
    _typeItOut(introText, 82);
  }

  // GitHub is the default extension set.
  gfmRadio.attributes['checked'] = '';
  gfmRadio.querySelector('.glyph').text = 'radio_button_checked';
  extensionSet = extensionSets[gfmRadio.id];
  _renderMarkdown();

  basicRadio.onClick.listen(_switchFlavor);
  commonmarkRadio.onClick.listen(_switchFlavor);
  gfmRadio.onClick.listen(_switchFlavor);
}

void _renderMarkdown([Event event]) {
  var markdown = markdownInput.value;

  htmlDiv.setInnerHtml(md.markdownToHtml(markdown, extensionSet: extensionSet),
      treeSanitizer: nullSanitizer);

  for (var block in htmlDiv.querySelectorAll('pre code')) {
    try {
      highlightBlock(block);
    } catch (e) {
      window.console.error('Error highlighting markdown:');
      window.console.error(e);
    }
  }

  if (event != null) {
    // Not simulated typing. Store it.
    window.localStorage['markdown'] = markdown;
  }
}

void _typeItOut(String msg, int pos) {
  Timer timer;
  markdownInput.onKeyUp.listen((_) {
    timer?.cancel();
  });
  void addCharacter() {
    if (pos > msg.length) {
      return;
    }
    markdownInput.value = msg.substring(0, pos);
    markdownInput.focus();
    _renderMarkdown();
    pos++;
    timer = new Timer(typing, addCharacter);
  }

  timer = new Timer(typing, addCharacter);
}

void _switchFlavor(Event e) {
  var target = e.currentTarget as HtmlElement;
  if (!target.attributes.containsKey('checked')) {
    if (basicRadio != target) {
      basicRadio.attributes.remove('checked');
      basicRadio.querySelector('.glyph').text = 'radio_button_unchecked';
    }
    if (commonmarkRadio != target) {
      commonmarkRadio.attributes.remove('checked');
      commonmarkRadio.querySelector('.glyph').text = 'radio_button_unchecked';
    }
    if (gfmRadio != target) {
      gfmRadio.attributes.remove('checked');
      gfmRadio.querySelector('.glyph').text = 'radio_button_unchecked';
    }

    target.attributes['checked'] = '';
    target.querySelector('.glyph').text = 'radio_button_checked';
    extensionSet = extensionSets[target.id];
    _renderMarkdown();
  }
}

class NullTreeSanitizer implements NodeTreeSanitizer {
  void sanitizeTree(Node node) {}
}
