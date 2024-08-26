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

extension on HTMLCollection {
  /// Take a snapshot of [HTMLCollection] as a Dart [List].
  ///
  /// Notice that it's not really safe to use [Iterable], because the underlying
  /// [HTMLCollection] might change if things are added/removed during iteration.
  /// Thus, we always convert to a Dart [List] and get a snapshot if the
  /// [HTMLCollection].
  List<Element> toList() => List.generate(length, (i) => item(i)!);
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

  /// Text
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

final class CompletionWidget {
  static final _whitespace = RegExp(r'\s');

  final Uri? src;
  final HTMLInputElement input;
  final HTMLDivElement dropdown;
  final String optionClass;
  final String selectedOptionClass;
  _CompletionData data;
  var state = _State();

  CompletionWidget._({
    required this.input,
    required this.dropdown,
    required this.src,
    required this.data,
    required this.optionClass,
    required this.selectedOptionClass,
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

    if (src != null) {
      scheduleMicrotask(() async {
        try {
          data = await _completionDataFromUri(src!);
        } on Exception catch (e) {
          throw Exception(
            'Unable to load autocompletion-src="$src", error: $e',
          );
        }
      });
    }
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
    final suggestions = suggest(
      data,
      text,
      caret,
      !crossedWordBoundary && state.forced,
    );
    state = _State(
      forced: !crossedWordBoundary && state.forced && suggestions.isNotEmpty,
      triggered: shouldTrigger(data, text, caret),
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
    final padding = 4; // padding and border size
    final caretOffset =
        getTextWidth(state.text.substring(0, state.caret), input);

    // Update dropdown position
    dropdown.style
      ..display = 'block'
      ..left = '${inputBoundingRect.left + padding + caretOffset}px'
      ..top = '${inputBoundingRect.bottom - padding}px';

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
        suggestions: suggest(
          data,
          state.text,
          state.caret,
          true,
        ),
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
        suggestions: suggest(
          data,
          state.text,
          state.caret,
          false,
        ),
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

  static void create(Element element) {
    if (!element.isA<HTMLInputElement>()) {
      throw UnsupportedError('Must be <input> element');
    }
    final input = element as HTMLInputElement;

    if (input.type != 'text' && input.type != 'search') {
      throw UnsupportedError('Must have type="text" or type="search"');
    }
    final dataBase64 = input.getAttribute('data-completion-base64') ?? '';
    _CompletionData? initialData;
    if (dataBase64.isNotEmpty) {
      try {
        initialData = _completionDataFromJson(
          json.decode(utf8.decode(base64.decode(dataBase64))),
        );
      } on FormatException catch (e) {
        throw Exception('Unable to load autocompletion-base64, error: $e');
      }
    }
    final src = input.getAttribute('data-completion-src') ?? '';
    if (src.isEmpty) {
      throw UnsupportedError('Must have completion-src="<url>"');
    }
    final srcUri = Uri.tryParse(src);
    if (srcUri == null && initialData == null) {
      throw UnsupportedError('completion-src="$src" must be a valid URI');
    }
    final dropdownClass = input.getAttribute('data-completion-class') ?? '';
    final optionClass =
        input.getAttribute('data-completion-option-class') ?? '';
    final selectedOptionClass =
        input.getAttribute('data-completion-selected-option-class') ?? '';

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

      if (initialData == null) {
        try {
          initialData = await _completionDataFromUri(srcUri!);
        } on Exception catch (e) {
          throw Exception(
            'Unable to load autocompletion-src="$src", error: $e',
          );
        }
      }

      // Create and style the dropdown element
      final dropdown = HTMLDivElement();
      dropdown.style.display = 'none';
      dropdown.style.position = 'absolute';
      if (dropdownClass.isNotEmpty) {
        dropdown.classList.add(dropdownClass);
      }

      CompletionWidget._(
        input: input,
        dropdown: dropdown,
        data: initialData!,
        src: srcUri,
        optionClass: optionClass,
        selectedOptionClass: selectedOptionClass,
      );
      // Add dropdown after the <input>
      document.body!.after(dropdown);
    });
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

  /// Given [data] should [caret] position inside [text] trigger completion.
  static bool shouldTrigger(_CompletionData data, String text, int caret) {
    // If caret is not at the end, and the next character isn't space then we
    // do not automatically trigger completion.
    if (caret < text.length && text[caret] != ' ') {
      return false;
    }

    // First find space before the caret, search reverse from caret - 1,
    // because "is:| " will otherwise find a space at caret position (3).
    // But obviously we can't do -1 if caret is at position zero.
    final spaceBeforeCaret = text.lastIndexOf(' ', caret - (caret > 0 ? 1 : 0));
    final wordBeforeCaret = text.substring(spaceBeforeCaret + 1, caret);

    return data.any(
      (c) => !c.forcedOnly && c.match.any(wordBeforeCaret.startsWith),
    );
  }

  static _Suggestions suggest(
    _CompletionData data,
    String text,
    int caret,
    // TODO: suggest shouldn't take forced as a parameter, this is messy.
    //       Instead we should return a tuple (triggered, suggestions)
    //       And merge shouldTrigger with suggest.
    bool forced,
  ) {
    // Get position before caret
    final beforeCaret = caret > 0 ? caret - 1 : 0;
    // Get position of space after the caret
    final spaceAfterCaret = text.indexOf(' ', caret);

    // Start and end of word we are completing
    final start = text.lastIndexOf(' ', beforeCaret) + 1;
    final end = spaceAfterCaret != -1 ? spaceAfterCaret : text.length;

    // Get the word that we are completing
    final word = text.substring(start, end);

    // Find the longest match
    final c = maxBy(
        data.map((c) => (
              completion: c,
              match: maxBy(c.match.where(word.startsWith), (m) => m.length),
            )), (c) {
      final m = c.match;
      if (m != null) return m.length;
      return -1;
    });
    if (c == null) return [];
    final match = c.match;
    if (match == null) return [];
    final completion = c.completion;
    final options = c.completion.options;

    // prefix to be used for completion of options
    final prefix = word.substring(match.length);

    if (options.contains(prefix)) {
      // If prefix is an option, and there is no other options we don't have
      // anything to suggest.
      if (options.length == 1) {
        return [];
      }
      // Unless we're forcing suggestions, we don't want to suggest something
      // if there isn't a prefix that is also longer!
      if (!forced &&
          !options.any((opt) => opt.startsWith(prefix) && opt != prefix)) {
        return [];
      }
    }

    // Terminate suggestion with a ' ' suffix, if this is a terminal completion
    final suffix = completion.terminal ? ' ' : '';

    return options
        .map((option) {
          final overlap = lcs(prefix, option);
          var html = option;
          if (overlap.isNotEmpty) {
            html = html.replaceAll(overlap, '<strong>$overlap</strong>');
          }
          return (
            value: match + option + suffix,
            start: start,
            end: end,
            html: html,
            score: (option.startsWith(word) ? math.pow(overlap.length, 3) : 0) +
                math.pow(overlap.length, 2) +
                (option.startsWith(overlap) ? overlap.length : 0) +
                overlap.length / option.length,
          );
        })
        .sortedBy<num>((s) => s.score)
        .reversed
        .toList();
  }
}

/// The longest common substring
String lcs(String S, String T) {
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
