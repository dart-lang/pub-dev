// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dom.dart' as d;

/// Renders a material button element.
d.Node button({
  String? id,
  String? customTypeClass,
  Iterable<String>? classes,
  bool raised = false,
  bool unelevated = false,
  Map<String, String>? attributes,
  d.Image? icon,
  required String label,
}) {
  final isSimpleLabel = icon == null && customTypeClass == null;
  return d.element(
    'button',
    id: id,
    classes: [
      'mdc-button',
      if (raised) 'mdc-button--raised',
      if (unelevated) 'mdc-button--unelevated',
      if (customTypeClass != null) customTypeClass,
      ...?classes,
    ],
    attributes: {'data-mdc-auto-init': 'MDCRipple', ...?attributes},
    children: isSimpleLabel
        ? [d.text(label)]
        : [
            d.div(classes: ['mdc-button__ripple']),
            if (icon != null)
              d.img(
                classes: [
                  'mdc-button__icon',
                  if (customTypeClass != null) '$customTypeClass-img',
                ],
                image: icon,
                attributes: {'aria-hidden': 'true'},
              ),
            d.span(
              classes: [
                'mdc-button__label',
                if (customTypeClass != null) '$customTypeClass-label',
              ],
              text: label,
            ),
          ],
  );
}

/// Renders a material floating action button (FAB) element.
/// The FAB is 48x48px by default. If [fabMini] is `true` the FAB will be
/// 40x40px.
d.Node floatingActionButton({
  String? id,
  Iterable<String>? classes,
  bool fabMini = false,
  Map<String, String>? attributes,
  d.Image? icon,
}) {
  return d.element(
    'fab',
    id: id,
    classes: ['mdc-fab', if (fabMini) 'mdc-fab--mini', ...?classes],
    attributes: {'data-mdc-auto-init': 'MDCRipple', ...?attributes},
    children: [
      d.div(classes: ['mdc-fab__ripple']),
      if (icon != null)
        d.img(
          classes: ['mdc-fab__icon'],
          image: icon,
          attributes: {'aria-hidden': 'true'},
        ),
    ],
  );
}

/// Renders a material raised button.
d.Node raisedButton({
  String? id,
  Iterable<String>? classes,
  Map<String, String>? attributes,
  required String label,
}) {
  return button(
    id: id,
    classes: classes,
    attributes: attributes,
    raised: true,
    label: label,
  );
}

/// Renders a plain HTML text field.
d.Node textField({
  required String id,
  required String? label,
  String? name,
  String? value,
}) {
  return d.div(
    classes: ['pub-text-field'],
    children: [
      if (label != null)
        d.label(
          classes: ['pub-text-field-label'],
          attributes: {'for': id},
          text: label,
        ),
      d.input(
        type: 'text',
        id: id,
        name: name,
        classes: ['pub-text-field-input'],
        value: value,
      ),
    ],
  );
}

/// Renders a plain HTML text area.
d.Node textArea({
  required String id,
  required String label,
  required int rows,
  required int cols,
  int maxLength = 4096,
  String? name,
  String? value,
}) {
  return d.div(
    classes: ['pub-text-field', 'pub-text-field--textarea'],
    children: [
      d.label(
        classes: ['pub-text-field-label'],
        attributes: {'for': id},
        text: label,
      ),
      d.element(
        'textarea',
        id: id,
        classes: ['pub-text-field-input'],
        attributes: {
          if (name != null) 'name': name,
          'rows': '$rows',
          'cols': '$cols',
          'maxlength': '$maxLength',
        },
        text: value,
      ),
      d.div(
        classes: ['pub-text-field-character-counter'],
        text: '${value?.length ?? 0} / $maxLength',
      ),
    ],
  );
}

class DataTableColumn<T> {
  final d.Node headerContent;
  final List<String>? headerClasses;
  d.Node Function(T data) renderCell;

  DataTableColumn({
    required this.headerContent,
    this.headerClasses,
    required this.renderCell,
  });
}

/// Renders a plain HTML data table.
d.Node dataTable<T>({
  String? id,
  String? ariaLabel,
  required Iterable<DataTableColumn<T>> columns,
  required Iterable<T> entries,
}) {
  return d.div(
    id: id,
    classes: ['pub-data-table'],
    child: d.element(
      'table',
      classes: ['pub-data-table-table'],
      attributes: {if (ariaLabel != null) 'aria-label': ariaLabel},
      children: [
        d.element(
          'thead',
          child: d.tr(
            classes: ['pub-data-table-header-row'],
            children: columns.map(
              (c) => d.th(
                classes: ['pub-data-table-header-cell', ...?c.headerClasses],
                attributes: {'role': 'columnheader', 'scope': 'col'},
                child: c.headerContent,
              ),
            ),
          ),
        ),
        d.element(
          'tbody',
          classes: ['pub-data-table-content'],
          children: entries.map(
            (entry) => d.tr(
              classes: ['pub-data-table-row'],
              children: columns.map(
                (c) => d.td(
                  classes: ['pub-data-table-cell'],
                  child: c.renderCell(entry),
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

/// Renders a material checkbox component.
d.Node checkbox({
  required String id,
  required String label,
  required bool checked,
  bool indeterminate = false,
  d.Node Function(String label)? labelNodeContent,
}) {
  labelNodeContent ??= d.text;
  return d.div(
    classes: ['mdc-form-field'],
    children: [
      d.div(
        classes: ['mdc-checkbox'],
        children: [
          d.input(
            type: 'checkbox',
            classes: ['mdc-checkbox__native-control'],
            id: id,
            attributes: {
              if (checked) 'checked': 'checked',
              if (indeterminate) 'data-indeterminate': 'true',
              if (indeterminate) 'aria-checked': 'mixed',
            },
          ),
          d.div(
            classes: ['mdc-checkbox__background'],
            children: [
              d.element(
                'svg',
                classes: ['mdc-checkbox__checkmark'],
                attributes: {'viewBox': '0 0 24 24'},
                child: d.element(
                  'path',
                  classes: ['mdc-checkbox__checkmark-path'],
                  attributes: {
                    'fill': 'none',
                    'd': 'M1.73,12.91 8.1,19.28 22.79,4.59',
                  },
                ),
              ),
              d.div(classes: ['mdc-checkbox__mixedmark']),
            ],
          ),
          d.div(classes: ['mdc-checkbox__ripple']),
        ],
      ),
      d.label(attributes: {'for': id}, child: labelNodeContent(label)),
    ],
  );
}

/// Renders a plain HTML dropdown / select component.
///
/// [options] must be a list of `<option>` elements from [option].
d.Node dropdown({
  required String id,
  required String label,
  required Iterable<d.Node> options,
  Iterable<String>? classes,
}) {
  return d.div(
    classes: ['pub-select', ...?classes],
    children: [
      d.label(
        classes: ['pub-select-label'],
        attributes: {'for': id},
        text: label,
      ),
      d.select(id: id, classes: ['pub-select-input'], children: options),
    ],
  );
}

/// Renders an `<option>` item for the [dropdown] / select component.
d.Node option({
  required String value,
  required String text,
  bool selected = false,
  bool disabled = false,
}) {
  return d.option(
    value: value,
    text: text,
    selected: selected,
    disabled: disabled,
  );
}

d.Node radioButtons({
  required String name,
  required List<({String label, String value, String id})> radios,
  String? initialValue,
  Iterable<String>? classes,
  String? leadingText,
}) {
  final nodes = <d.Node>[];
  if (leadingText != null) {
    nodes.add(d.strong(text: leadingText));
  }
  radios.forEach((e) {
    final button = (d.input(
      id: e.id,
      type: 'radio',
      name: name,
      value: e.value,
      attributes: {if (e.value == initialValue) 'checked': ''},
    ));
    final label = d.label(attributes: {'for': e.id}, child: d.text(e.label));
    final div = d.div(children: [button, label]);
    nodes.add(div);
  });

  return d.div(classes: ['mdc-form-field', ...?classes], children: nodes);
}
