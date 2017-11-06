// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
import 'dart:async';

import 'package:build/build.dart';
import 'package:barback/barback.dart' as barback;

import '../util/barback.dart';

/// A builder which wraps a [barback.DeclaringTransformer].
class TransformerBuilder implements Builder {
  final barback.Transformer transformer;
  @override
  final Map<String, List<String>> buildExtensions;

  TransformerBuilder(this.transformer, this.buildExtensions);

  @override
  Future build(BuildStep buildStep) {
    var transform = toBarbackTransform(buildStep);
    return new Future.value(transformer.apply(transform));
  }

  @override
  String toString() => 'TransformerBuilder[$transformer]';
}
