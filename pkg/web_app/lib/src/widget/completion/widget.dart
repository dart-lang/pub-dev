// Copyright (c) 2023, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';
import 'dart:js_interop';

import 'package:_pub_shared/data/completion.dart';
import 'package:http/http.dart' deferred as http show read;
import 'package:web/web.dart';

import '../../web_util.dart';
import 'suggest.dart';

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

    final CompletionData data;
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
    // Append dropdown to body
    document.body!.append(dropdown);
  });
}

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
  final Suggestions suggestions;

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
    Suggestions? suggestions,
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
  final CompletionData data;
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

  var _renderedSuggestions = Suggestions.empty();

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
  static Future<CompletionData> _completionDataFromUri(Uri src) async {
    await http.loadLibrary();
    final root = jsonDecode(
      await http.read(src, headers: {
        'Accept': 'application/json',
      }).timeout(Duration(seconds: 30)),
    );
    return CompletionData.fromJson(root as Map<String, dynamic>);
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
}
