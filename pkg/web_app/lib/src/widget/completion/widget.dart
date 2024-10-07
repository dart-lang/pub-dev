// Copyright (c) 2023, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';
import 'dart:js_interop';
import 'dart:math' as math;

import 'package:collection/collection.dart';
import 'package:http/http.dart' deferred as http show read;
import 'package:web/web.dart';

import '../../web_util.dart';

/// Create a [_CompletionWidget] on [element].
///
/// Here [element] must:
///  * be an `<input>` element, with
///    * `type="text"`, or,
///    * `type="search".
///  * have properties:
///    * `data-completion-src`, URL from which completion data should be
///       loaded.
///    * `data-completion-class` (optional), class that should be applied to
///       the dropdown that provides completion options.
///       Useful if styling multiple completer widgets.
///
/// The dropdown that provides completions will be appended to
/// `document.body` and given the following classes:
///   * `completion-dropdown` for the completion dropdown.
///   * `completion-option` for each option in the dropdown, and,
///   * `completion-option-select` is applied to selected options.
void create(HTMLElement element, Map<String, String> options) {
  if (!element.isA<HTMLInputElement>()) {
    throw UnsupportedError('Must be <input> element');
  }
  final input = element as HTMLInputElement;

  if (input.type != 'text' && input.type != 'search') {
    throw UnsupportedError('Must have type="text" or type="search"');
  }

  final src = options['src'] ?? '';
  if (src.isEmpty) {
    throw UnsupportedError('Must have completion-src="<url>"');
  }
  final srcUri = Uri.tryParse(src);
  if (srcUri == null) {
    throw UnsupportedError('completion-src="$src" must be a valid URI');
  }
  final completionClass = options['class'] ?? '';

  // Setup attributes
  input.autocomplete = 'off';
  input.autocapitalize = 'off';
  input.spellcheck = false;
  input.setAttribute('autocorrect', 'off'); // safari only

  scheduleMicrotask(() async {
    // Don't do anymore setup before input has focus
    if (document.activeElement != input) {
      await input.onFocus.first;
    }

    final _CompletionData data;
    try {
      data = await _CompletionWidget._completionDataFromUri(srcUri);
    } on Exception catch (e) {
      throw Exception(
        'Unable to load autocompletion-src="$src", error: $e',
      );
    }

    // Create and style the dropdown element
    final dropdown = HTMLDivElement()
      ..style.display = 'none'
      ..style.position = 'absolute'
      ..classList.add('completion-dropdown');
    if (completionClass.isNotEmpty) {
      dropdown.classList.add(completionClass);
    }

    _CompletionWidget._(
      input: input,
      dropdown: dropdown,
      data: data,
    );
    // Add dropdown after the <input>
    document.body!.append(dropdown);
  });
}

typedef _CompletionData = List<
    ({
      Set<String> match,
      List<String> options,
      bool terminal,
      bool forcedOnly,
    })>;
typedef _Suggestions = List<
    ({
      String value,
      String html, // TODO: Don't create HTML manually!
      int start,
      int end,
      double score,
    })>;

final class _State {
  /// Completion is not active, happens whens:
  ///  * The input element doesn't have focus, or,
  ///  * There is a non-empty selection.
  final bool inactive;

  /// User actively closed completion with 'Escape'
  final bool closed;

  /// User force enabled completion with 'Ctrl+Space'
  final bool forced;

  /// Completion was automatically triggered
  final bool triggered;

  /// Value from the `<input>` element.
  final String text;

  /// Offset of caret
  final int caret;

  /// Suggestions on the form: {value, html, start, end}
  final _Suggestions suggestions;

  /// Selected suggestion
  final int selectedIndex;

  _State({
    this.inactive = false,
    this.closed = false,
    this.forced = false,
    this.triggered = false,
    this.text = '',
    this.caret = 0,
    this.suggestions = const [],
    this.selectedIndex = 0,
  });

  _State update({
    bool? inactive,
    bool? closed,
    bool? forced,
    bool? triggered,
    String? text,
    int? caret,
    _Suggestions? suggestions,
    int? selectedIndex,
  }) =>
      _State(
        inactive: inactive ?? this.inactive,
        closed: closed ?? this.closed,
        forced: forced ?? this.forced,
        triggered: triggered ?? this.triggered,
        text: text ?? this.text,
        caret: caret ?? this.caret,
        suggestions: suggestions ?? this.suggestions,
        selectedIndex: selectedIndex ?? this.selectedIndex,
      );

  @override
  String toString() =>
      '_State(forced: $forced, triggered: $triggered, caret: $caret, text: $text, selected: $selectedIndex)';
}

final class _CompletionWidget {
  static final _whitespace = RegExp(r'\s');
  static final optionClass = 'completion-option';
  static final selectedOptionClass = 'completion-option-selected';

  final HTMLInputElement input;
  final HTMLDivElement dropdown;
  final _CompletionData data;
  var state = _State();

  _CompletionWidget._({
    required this.input,
    required this.dropdown,
    required this.data,
  }) {
    // Setup event handlers
    dropdown.onMouseDown.listen(handleMouseDown);
    input.onInput.listen(trackState);
    input.addEventListener('focusin', trackState.toJS);
    input.addEventListener('focusout', trackState.toJS);
    input.onFocus.listen(trackState);
    input.onBlur.listen(trackState);
    input.onMouseDown.listen(trackState);
    window.document.addEventListener('selectionchange', trackState.toJS);
    input.onKeyDown.listen(handleKeyDown);

    // Track state to ensure initial state is sound, as the user may have
    // started typing already.
    trackState();
  }

  void trackState([Event? _]) {
    // Check if [input] has focus
    if (document.activeElement != input) {
      state = _State(inactive: true);
      update();
      return;
    }
    // Check if we have a non-empty selection
    final caret = input.selectionStart ?? 0;
    if (caret != (input.selectionEnd ?? 0)) {
      state = _State(inactive: true);
      update();
      return;
    }
    // Check if state has changed
    final text = input.value;
    if (!state.inactive && state.text == text && state.caret == caret) {
      return; // abort, no changes happened
    }
    final String delta;
    if (caret > state.caret) {
      delta = text.substring(state.caret, caret);
    } else {
      delta = state.text.substring(caret, state.caret);
    }
    final crossedWordBoundary = delta.contains(_whitespace);
    final (:trigger, :suggestions) = suggest(
      data,
      text,
      caret,
    );
    state = _State(
      forced: !crossedWordBoundary && state.forced && suggestions.isNotEmpty,
      triggered: trigger,
      suggestions: suggestions,
      text: text,
      caret: caret,
    );
    update();
  }

  /// Display dropdown
  bool get displayDropdown {
    return !state.inactive &&
        !state.closed &&
        (state.forced || state.triggered) &&
        state.suggestions.isNotEmpty;
  }

  var _renderedSuggestions = _Suggestions.empty();

  void update() {
    if (!displayDropdown) {
      dropdown.style.display = 'none';
      return;
    }

    // Detect changes, first we try just a quick reference equality
    var changed = _renderedSuggestions != state.suggestions;
    if (changed) {
      // Compare all entries
      changed = _renderedSuggestions.length != state.suggestions.length;
      for (var i = 0; !changed && i < _renderedSuggestions.length; i++) {
        changed |= _renderedSuggestions[i] != state.suggestions[i];
      }
    }

    // Update DOM elements if there was a change
    if (changed) {
      dropdown.children.toList().forEach((e) => e.remove());
      for (final (i, s) in state.suggestions.indexed) {
        dropdown.appendChild(HTMLDivElement()
          ..setHTMLUnsafe(s.html.toJS)
          ..setAttribute('data-completion-option-index', i.toString())
          ..classList.add(optionClass));
      }
    }
    _renderedSuggestions = state.suggestions;

    final inputBoundingRect = input.getBoundingClientRect();
    final caretOffset =
        getTextWidth(state.text.substring(0, state.caret), input);

    // Update dropdown position
    dropdown.style
      ..display = 'block'
      ..left = '${inputBoundingRect.left + caretOffset}px'
      ..top = '${inputBoundingRect.bottom}px';

    // Apply selectedOptionClass to selected option
    if (state.suggestions.isNotEmpty) {
      final selected =
          dropdown.children.item(state.selectedIndex) as HTMLDivElement;
      if (!selected.classList.contains(selectedOptionClass)) {
        dropdown.children.toList().forEach(
              (c) => c.classList.remove(selectedOptionClass),
            );
        selected
          ..classList.add(selectedOptionClass)
          ..scrollIntoView(ScrollIntoViewOptions(block: 'nearest'));
      }
    }
  }

  void handleMouseDown(MouseEvent event) {
    if (event.defaultPrevented) {
      return;
    }

    // If explicily closed using 'Escape', then we handle no more keys
    if (state.closed) {
      return;
    }

    // If not triggered automatically and not forced by Ctrl+Space, then
    // we're done.
    if (!state.triggered && !state.forced) {
      return;
    }

    // If there are no suggestions, then there are no keys to handle.
    if (state.suggestions.isEmpty) {
      return;
    }

    // If mouse down on an option element, then we select and apply it
    if (event.target.isA<HTMLDivElement>()) {
      final target = event.target as HTMLDivElement;

      final index = target.getAttribute('data-completion-option-index');
      if (index == null || index.isEmpty) return;
      final i = int.tryParse(index);
      if (i == null) return;

      state = state.update(selectedIndex: i);
      event.preventDefault();
      applySelectedSuggestion();
      return;
    }
  }

  void handleKeyDown(KeyboardEvent event) {
    if (state.inactive || event.defaultPrevented) {
      return;
    }

    final ctrlOrMeta = event.metaKey || event.ctrlKey;
    final shiftOrAlt = event.shiftKey || event.altKey;

    // Ctrl+Space always triggers forced completion.
    if (event.code == 'Space' && ctrlOrMeta && !shiftOrAlt) {
      state = state.update(
        closed: false,
        forced: true,
      );
      event.preventDefault();
      update();
      return;
    }

    // If not visible then we have no interactions
    if (!displayDropdown) {
      return;
    }

    // Ignore keys with modifiers!
    if (ctrlOrMeta || shiftOrAlt) {
      return;
    }

    // 'Escape' (without modifiers) will close completion
    if (event.code == 'Escape') {
      state = state.update(
        closed: true,
        forced: false,
      );
      event.preventDefault();
      update();
      return;
    }
    if (event.code == 'ArrowUp') {
      final N = state.suggestions.length;
      state = state.update(
        selectedIndex: (state.selectedIndex + N - 1) % N,
      );
      event.preventDefault();
      update();
      return;
    }
    if (event.code == 'ArrowDown') {
      final N = state.suggestions.length;
      state = state.update(
        selectedIndex: (state.selectedIndex + 1) % N,
      );
      event.preventDefault();
      update();
      return;
    }
    if (event.code == 'Enter' || event.code == 'Tab') {
      event.preventDefault();
      applySelectedSuggestion();
      return;
    }
  }

  /// Apply the selected suggestion
  void applySelectedSuggestion() {
    final selected = state.suggestions[state.selectedIndex];
    input.setRangeText(
      selected.value,
      selected.start,
      selected.end,
      'end',
    );
    // reset state and track state again, to be certain
    state = _State();
    trackState();
  }

  /// Load completion data from [src].
  ///
  /// Completion data must be a JSON response on the form:
  /// ```js
  /// {
  ///   "completions": [
  ///     {
  ///       // The match trigger automatic completion (except empty match).
  ///       // Example: `platform:` or `platform:win`
  ///       // Match and an option must be combined to form a keyword.
  ///       // Example: `platform:windows`
  ///       "match": ["platform:", "-platform:"],
  ///       "forcedOnly": false,  // Only display this when forced to match
  ///       "terminal": true,     // Add whitespace when completing
  ///       "options": [
  ///         "linux",
  ///         "windows",
  ///         "android",
  ///         "ios",
  ///         ...
  ///       ],
  ///     },
  ///     ...
  ///   ],
  /// }
  /// ```
  ///
  /// Ideally, an end-point serving this kind of completion data should have
  /// `Cache-Control` headers that allow caching for a decent period of time.
  /// Compression with `gzip` (or similar) would probably also be wise.
  static Future<_CompletionData> _completionDataFromUri(Uri src) async {
    await http.loadLibrary();
    final root = jsonDecode(
      await http.read(src, headers: {
        'Accept': 'application/json',
      }).timeout(Duration(seconds: 30)),
    );
    return _completionDataFromJson(root);
  }

  /// Load completion data from [json].
  ///
  /// Completion data must be JSON on the form:
  /// ```js
  /// {
  ///   "completions": [
  ///     {
  ///       // The match trigger automatic completion (except empty match).
  ///       // Example: `platform:` or `platform:win`
  ///       // Match and an option must be combined to form a keyword.
  ///       // Example: `platform:windows`
  ///       "match": ["platform:", "-platform:"],
  ///       "forcedOnly": false,  // Only display this when forced to match
  ///       "terminal": true,     // Add whitespace when completing
  ///       "options": [
  ///         "linux",
  ///         "windows",
  ///         "android",
  ///         "ios",
  ///         ...
  ///       ],
  ///     },
  ///     ...
  ///   ],
  /// }
  /// ```
  static _CompletionData _completionDataFromJson(Object? json) {
    if (json is! Map) throw FormatException('root must be a object');
    final completions = json['completions'];
    if (completions is! List) {
      throw FormatException('completions must be a list');
    }
    return completions.map((e) {
      if (e is! Map) throw FormatException('completion entries must be object');
      final terminal = e['terminal'] ?? true;
      if (terminal is! bool) throw FormatException('termianl must be bool');
      final forcedOnly = e['forcedOnly'] ?? false;
      if (forcedOnly is! bool) throw FormatException('forcedOnly must be bool');
      final match = e['match'];
      if (match is! List) throw FormatException('match must be a list');
      final options = e['options'];
      if (options is! List) throw FormatException('options must be a list');
      return (
        match: match
            .map((m) => m is String
                ? m
                : throw FormatException('match must be strings'))
            .toSet(),
        forcedOnly: forcedOnly,
        terminal: terminal,
        options: options
            .map((option) => option is String
                ? option
                : throw FormatException('options must be strings'))
            .toList(),
      );
    }).toList();
  }

  static late final _canvas = HTMLCanvasElement();
  static int getTextWidth(String text, Element element) {
    final ctx = _canvas.context2D;
    final style = window.getComputedStyle(element);
    ctx.font = [
      style.fontWeight.isNotEmpty ? style.fontWeight : 'normal',
      style.fontSize.isNotEmpty ? style.fontSize : '16px',
      style.fontFamily.isNotEmpty ? style.fontFamily : 'Times New Roman',
    ].join(' ');
    return ctx.measureText(text).width.floor();
  }

  /// Given [data] and [caret] position inside [text] what suggestions do we
  /// want to offer and should completion be automatically triggered?
  static ({bool trigger, _Suggestions suggestions}) suggest(
    _CompletionData data,
    String text,
    int caret,
  ) {
    // Get position before caret
    final beforeCaret = caret > 0 ? caret - 1 : 0;
    // Get position of space after the caret
    final spaceAfterCaret = text.indexOf(' ', caret);

    // Start and end of word we are completing
    final start = text.lastIndexOf(' ', beforeCaret) + 1;
    final end = spaceAfterCaret != -1 ? spaceAfterCaret : text.length;

    // If caret is not at the end, and the next character isn't space then we
    // do not automatically trigger completion.
    bool trigger;
    if (caret < text.length && text[caret] != ' ') {
      trigger = false;
    } else {
      // If the part before the caret is matched, then we can auto trigger
      final wordBeforeCaret = text.substring(start, caret);
      trigger = data.any(
        (c) => !c.forcedOnly && c.match.any(wordBeforeCaret.startsWith),
      );
    }

    // Get the word that we are completing
    final word = text.substring(start, end);

    // Find the longest match for each completion entry
    final completionWithBestMatch = data.map((c) => (
          completion: c,
          match: maxBy(c.match.where(word.startsWith), (m) => m.length),
        ));
    // Find the best completion entry
    final (:completion, :match) = maxBy(completionWithBestMatch, (c) {
          final m = c.match;
          return m != null ? m.length : -1;
        }) ??
        (completion: null, match: null);
    if (completion == null || match == null) {
      return (
        trigger: false,
        suggestions: [],
      );
    }

    // prefix to be used for completion of options
    final prefix = word.substring(match.length);

    if (completion.options.contains(prefix)) {
      // If prefix is an option, and there is no other options we don't have
      // anything to suggest.
      if (completion.options.length == 1) {
        return (
          trigger: false,
          suggestions: [],
        );
      }
      // We don't to auto trigger completion unless there is an option that is
      // also a prefix and longer than what prefix currently matches.
      trigger &= completion.options.any(
        (opt) => opt.startsWith(prefix) && opt != prefix,
      );
    }

    // Terminate suggestion with a ' ' suffix, if this is a terminal completion
    final suffix = completion.terminal ? ' ' : '';

    return (
      trigger: trigger,
      suggestions: completion.options
          .map((option) {
            final overlap = _lcs(prefix, option);
            var html = option;
            if (overlap.isNotEmpty) {
              html = html.replaceAll(overlap, '<strong>$overlap</strong>');
            }
            return (
              value: match + option + suffix,
              start: start,
              end: end,
              html: html,
              score:
                  (option.startsWith(word) ? math.pow(overlap.length, 3) : 0) +
                      math.pow(overlap.length, 2) +
                      (option.startsWith(overlap) ? overlap.length : 0) +
                      overlap.length / option.length,
            );
          })
          .sortedBy<num>((s) => s.score)
          .reversed
          .toList(),
    );
  }
}

/// The longest common substring
String _lcs(String S, String T) {
  final r = S.length;
  final n = T.length;
  var Lp = List.filled(n, 0); // ignore: non_constant_identifier_names
  var Li = List.filled(n, 0); // ignore: non_constant_identifier_names
  var z = 0;
  var [start, end] = [0, 0];
  for (var i = 0; i < r; i++) {
    for (var j = 0; j < n; j++) {
      if (S[i] == T[j]) {
        if (i == 0 || j == 0) {
          Li[j] = 1;
        } else {
          Li[j] = Lp[j - 1] + 1;
        }
        if (Li[j] > z) {
          z = Li[j];
          [start, end] = [i - z + 1, i + 1];
        }
      }
    }
    [Lp, Li] = [Li, Lp..fillRange(0, Lp.length, 0)];
  }
  return S.substring(start, end);
}
