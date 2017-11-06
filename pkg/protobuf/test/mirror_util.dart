// Copyright(c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library mirror_util;

import 'dart:mirrors';

/// Returns the names of the public properties and methods on a class.
/// (Also visits its superclasses, recursively.)
Set<String> findMemberNames(String importName, Symbol classSymbol) {
  var lib = currentMirrorSystem().libraries[Uri.parse(importName)];
  ClassMirror cls = lib.declarations[classSymbol];

  var result = new Set<String>();

  addNames(ClassMirror cls) {
    String prefixToRemove = MirrorSystem.getName(cls.simpleName) + ".";

    String chooseName(Symbol sym) {
      String name = MirrorSystem.getName(sym);
      if (name.startsWith(prefixToRemove)) {
        return name.substring(prefixToRemove.length);
      }
      return name;
    }

    for (var decl in cls.declarations.values) {
      if (!decl.isPrivate &&
          decl is! VariableMirror &&
          decl is! TypeVariableMirror) {
        result.add(chooseName(decl.simpleName));
      }
    }
  }

  while (cls != null) {
    addNames(cls);
    cls = cls.superclass;
  }

  return result;
}
