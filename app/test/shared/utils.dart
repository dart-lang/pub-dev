// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:gcloud/service_scope.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:pub_dev/frontend/dom/dom.dart' show isSelfClosing;
import 'package:pub_dev/service/announcement/backend.dart';
import 'package:pub_dev/shared/configuration.dart';
import 'package:test/test.dart';
import 'package:xml/xml.dart' as xml;

Future scoped(Function() func) {
  return fork(() async {
    return func();
  });
}

void scopedTest(
  String name,
  Function() func, {
  Timeout? timeout,
  dynamic skip,
}) {
  test(name, () {
    return fork(() async {
      // double fork to allow further override
      registerActiveConfiguration(Configuration.test());
      registerAnnouncementBackend(AnnouncementBackend());
      return await fork(() async => func());
    });
  }, timeout: timeout, skip: skip);
}

/// Pretty printing [input] using HTML parser and XML formatter.
String prettyPrintHtml(String input, {bool isFragment = false}) {
  final htmlDoc =
      isFragment ? parseFragment('<fragment>$input</fragment>') : parse(input);
  return htmlDoc.toXml().toXmlString(
            pretty: true,
            indent: '  ',
            entityMapping: xml.XmlDefaultEntityMapping.html5(),
          ) +
      '\n';
}

extension ToXmlExt on Node {
  xml.XmlNode toXml() {
    switch (this) {
      case Document():
        return xml.XmlDocument(nodes.map((e) => e.toXml()));
      case DocumentType():
        final t = this as DocumentType;
        return xml.XmlDoctype(t.name ?? '');
      case DocumentFragment():
        return xml.XmlDocument(nodes.map((e) => e.toXml()));
      case Text():
        return xml.XmlText(text ?? '');
      case Comment():
        return xml.XmlComment(text ?? '');
      case Element():
        final e = this as Element;
        final tag = e.localName ?? '';
        return xml.XmlElement(
          xml.XmlName(tag),
          e.attributes.entries.map(
              (e) => xml.XmlAttribute(xml.XmlName(e.key.toString()), e.value)),
          e.nodes.map((e) => e.toXml()).toList(),
          isSelfClosing(tag),
        );
    }
    throw UnimplementedError('toXml not implemented: $runtimeType');
  }
}
