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
  String? iconUrl,
  required String label,
}) {
  final isSimpleLabel = iconUrl == null && customTypeClass == null;
  return d.element(
    'button',
    id: id,
    classes: [
      'mdc-button',
      if (raised) 'mdc-button--raised',
      if (unelevated) 'mdc-button--unelevated',
      if (customTypeClass != null) customTypeClass,
      if (classes != null) ...classes,
    ],
    attributes: {
      'data-mdc-auto-init': 'MDCRipple',
      if (attributes != null) ...attributes,
    },
    children: isSimpleLabel
        ? [d.text(label)]
        : [
            d.div(classes: ['mdc-button__ripple']),
            if (iconUrl != null)
              d.img(
                classes: [
                  'mdc-button__icon',
                  if (customTypeClass != null) '$customTypeClass-img',
                ],
                src: iconUrl,
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

/// Renders a material raised button.
d.Node raisedButton({
  String? id,
  Iterable<String>? classes,
  required String label,
}) {
  return button(
    id: id,
    classes: classes,
    raised: true,
    label: label,
  );
}

/// Renders a two-state material icon button
d.Node iconButton({
  required String id,
  required bool isOn,
  Map<String, String>? attributes,
  required int iconWidth,
  required int iconHeight,
  required String onIconUrl,
  required String offIconUrl,
}) {
  return d.element(
    'button',
    id: id,
    classes: [
      'mdc-icon-button',
      if (isOn) 'mdc-icon-button--on',
    ],
    attributes: attributes,
    children: [
      d.img(
        classes: ['mdc-icon-button__icon'],
        src: offIconUrl,
        attributes: {
          'width': '$iconWidth',
          'height': '$iconHeight',
        },
      ),
      d.img(
        classes: ['mdc-icon-button__icon', 'mdc-icon-button__icon--on'],
        src: onIconUrl,
        attributes: {
          'width': '$iconWidth',
          'height': '$iconHeight',
        },
      ),
    ],
  );
}

/// Renders a material text field.
d.Node textField({
  required String id,
  required String label,
  String? value,
}) {
  return d.fragment([
    d.label(attributes: {'for': id}, text: label),
    d.div(
      classes: ['mdc-text-field', 'mdc-text-field--outlined'],
      attributes: {'data-mdc-auto-init': 'MDCTextField'},
      children: [
        d.input(
          type: 'text',
          id: id,
          classes: ['mdc-text-field__input'],
          value: value,
        ),
        d.div(
          classes: ['mdc-notched-outline'],
          children: [
            d.div(classes: ['mdc-notched-outline__leading'], text: ''),
            d.div(classes: ['mdc-notched-outline__trailing'], text: ''),
          ],
        ),
      ],
    ),
  ]);
}

/// Renders a material text area.
d.Node textArea({
  required String id,
  required String label,
  required int rows,
  required int cols,
  int maxLength = 4096,
  String? value,
}) {
  return d.fragment([
    d.label(attributes: {'for': id}, text: label),
    d.div(
      classes: ['mdc-text-field', 'mdc-text-field--textarea'],
      attributes: {'data-mdc-auto-init': 'MDCTextField'},
      children: [
        d.div(
          classes: ['mdc-text-field-character-counter'],
          text: '${value?.length ?? 0} / $maxLength',
        ),
        d.element(
          'textarea',
          id: id,
          classes: ['mdc-text-field__input'],
          attributes: {
            'rows': '$rows',
            'cols': '$cols',
            'maxlength': '$maxLength',
          },
          text: value,
        ),
        d.div(
          classes: ['mdc-notched-outline'],
          children: [
            d.div(classes: ['mdc-notched-outline__leading'], text: ''),
            d.div(classes: ['mdc-notched-outline__trailing'], text: ''),
          ],
        ),
      ],
    ),
  ]);
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

/// Renders a material data table.
d.Node dataTable<T>({
  String? id,
  String? ariaLabel,
  required Iterable<DataTableColumn<T>> columns,
  required Iterable<T> entries,
}) {
  return d.div(
    id: id,
    classes: ['mdc-data-table'],
    child: d.element(
      'table',
      classes: ['mdc-data-table__table'],
      attributes: {
        if (ariaLabel != null) 'aria-label': ariaLabel,
      },
      children: [
        d.element(
          'thead',
          child: d.tr(
            classes: ['mdc-data-table__header-row'],
            children: columns.map(
              (c) => d.th(
                classes: [
                  'mdc-data-table__header-cell',
                  if (c.headerClasses != null) ...c.headerClasses!,
                ],
                attributes: {
                  'role': 'columnheader',
                  'scope': 'col',
                },
                child: c.headerContent,
              ),
            ),
          ),
        ),
        d.element(
          'tbody',
          classes: ['mdc-data-table__content'],
          children: entries.map(
            (entry) => d.tr(
              classes: ['mdc-data-table__row'],
              children: columns.map(
                (c) => d.td(
                  classes: ['mdc-data-table__cell'],
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
