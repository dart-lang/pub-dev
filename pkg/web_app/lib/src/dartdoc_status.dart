// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:html';

/// The dataset attribute name we use to store the documentation status.
const _hasDocumentationAttr = 'hasDocumentation';

void updateDartdocStatus() {
  final List<String> packages = document
      .querySelectorAll('.version-table')
      .map((e) => e.dataset['package'])
      .where((s) => s != null && s.isNotEmpty)
      .toSet()
      .toList();

  Future<void> update(String package) async {
    final List<Element> tables = document
        .querySelectorAll('.version-table')
        .where((e) => e.dataset['package'] == package)
        .toList();
    for (Element table in tables) {
      table.querySelectorAll('td.documentation').forEach((e) {
        e.dataset[_hasDocumentationAttr] = '-'; // unknown value
      });
    }

    try {
      final content =
          await HttpRequest.getString('/api/documentation/$package');
      final map = json.decode(content) as Map;
      final versionsList = map['versions'] as List;
      for (Map versionMap in versionsList.cast<Map>()) {
        final version = versionMap['version'] as String;
        final hasDocumentation = versionMap['hasDocumentation'] as bool;
        final status = versionMap['status'] as String;
        for (Element table in tables) {
          table
              .querySelectorAll('tr')
              .where((e) => e.dataset['version'] == version)
              .forEach(
            (row) {
              final docCol = row.querySelector('.documentation');
              if (docCol == null) return;
              final docLink = docCol.querySelector('a') as AnchorElement;
              if (docLink == null) return;
              if (status == 'awaiting') {
                docCol.dataset[_hasDocumentationAttr] = '...';
                docLink.text = 'awaiting';
              } else if (hasDocumentation) {
                docCol.dataset[_hasDocumentationAttr] = '1';
              } else {
                docCol.dataset[_hasDocumentationAttr] = '0';
                docLink.href += 'log.txt';
                docLink.text = 'failed';
              }
            },
          );
        }
      }

      // clear unknown values
      for (Element table in tables) {
        table.querySelectorAll('td.documentation').forEach((docCol) {
          if (docCol.dataset[_hasDocumentationAttr] == '-') {
            final docLink = docCol.querySelector('a') as AnchorElement;
            if (docLink != null) {
              docLink.remove();
            }
          }
        });
      }
    } catch (_) {
      // ignore errors
    }
  }

  for (String package in packages) {
    update(package);
  }
}
