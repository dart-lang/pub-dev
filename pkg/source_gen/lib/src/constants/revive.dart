// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
// ignore: implementation_imports
import 'package:analyzer/src/dart/constant/value.dart';

import '../utils.dart';

/// Returns a revivable instance of [object].
///
/// Optionally specify the [library] type that contains the reference.
///
/// Returns [null] if not revivable.
Revivable reviveInstance(DartObject object, [LibraryElement library]) {
  library ??= object.type.element.library;
  var url = Uri.parse(urlOfElement(object.type.element));
  final clazz = object?.type?.element as ClassElement;
  for (final e in clazz.fields.where(
    (f) => f.isPublic && f.isConst && f.computeConstantValue() == object,
  )) {
    return new Revivable._(source: url, accessor: e.name);
  }
  final i = (object as DartObjectImpl).getInvocation();
  if (i != null &&
      i.constructor.isPublic &&
      i.constructor.enclosingElement.isPublic) {
    url = Uri.parse(urlOfElement(i.constructor.enclosingElement));
    return new Revivable._(
      source: url,
      accessor: i.constructor.name,
      namedArguments: i.namedArguments,
      positionalArguments: i.positionalArguments,
    );
  }
  if (library == null) {
    return null;
  }
  for (final e in library.definingCompilationUnit.topLevelVariables.where(
    (f) => f.isPublic && f.isConst && f.computeConstantValue() == object,
  )) {
    return new Revivable._(
      source: Uri.parse(urlOfElement(library)).replace(fragment: ''),
      accessor: e.name,
    );
  }
  return null;
}

/// Decoded "instructions" for re-creating a const [DartObject] at runtime.
class Revivable {
  /// A URL pointing to the location and class name.
  ///
  /// For example, `LinkedHashMap` looks like: `dart:collection#LinkedHashMap`.
  ///
  /// An accessor to a top-level do does not have a fragment.
  final Uri source;

  /// Constructor or getter name used to invoke `const Class(...)`.
  ///
  /// Optional - if empty string (`''`) then this means the default constructor.
  final String accessor;

  /// Positional arguments used to invoke the constructor.
  final List<DartObject> positionalArguments;

  /// Named arguments used to invoke the constructor.
  final Map<String, DartObject> namedArguments;

  const Revivable._({
    this.source,
    this.accessor: '',
    this.positionalArguments: const [],
    this.namedArguments: const {},
  });

  /// Whether this instance is visible outside the same library.
  bool get isPrivate => accessor.startsWith('_');
}
