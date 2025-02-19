// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:js_interop';

import 'package:web/web.dart';

extension NodeListTolist on NodeList {
  /// Take a snapshot of [NodeList] as a Dart [List].
  ///
  /// Notice that it's not really safe to use [Iterable], because the underlying
  /// [NodeList] might change if things are added/removed during iteration.
  /// Thus, we always convert to a Dart [List] and get a snapshot if the
  /// [NodeList].
  List<Node> toList() => List.generate(length, (i) => item(i)!);

  /// Take a snapshot of [NodeList] as a Dart [List] and casting the type of the
  /// [Node] to [Element] (or subtype of it).
  ///
  /// Notice that it's not really safe to use [Iterable], because the underlying
  /// [NodeList] might change if things are added/removed during iteration.
  /// Thus, we always convert to a Dart [List] and get a snapshot if the
  /// [NodeList].
  List<E> toElementList<E extends Element>() =>
      List<E>.generate(length, (i) => item(i) as E);
}

extension HTMLCollectionToList on HTMLCollection {
  /// Take a snapshot of [HTMLCollection] as a Dart [List].
  ///
  /// Notice that it's not really safe to use [Iterable], because the underlying
  /// [HTMLCollection] might change if things are added/removed during iteration.
  /// Thus, we always convert to a Dart [List] and get a snapshot if the
  /// [HTMLCollection].
  List<Element> toList() => List.generate(length, (i) => item(i)!);
}

extension JSStringArrayIterable on JSArray<JSString> {
  Iterable<String> get iterable => toDart.map((s) => s.toDart);
}

extension WindowExt on Window {
  /// Returns a Future that completes just before the window is about to
  /// repaint so the user can draw an animation frame.
  Future<void> get animationFrame {
    final completer = Completer.sync();
    requestAnimationFrame((() {
      completer.complete();
    }).toJSCaptureThis);
    return completer.future;
  }
}

extension DOMTokenListExt on DOMTokenList {
  void addAll(Iterable<String> items) {
    for (final item in items) {
      add(item);
    }
  }
}
