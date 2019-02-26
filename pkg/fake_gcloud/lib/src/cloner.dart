import 'dart:mirrors';

/// Configures a clone helper.
class Cloner {
  final List<Type> _immutableTypes;

  Cloner({List<Type> immutableTypes})
      : _immutableTypes = immutableTypes ?? <Type>[];

  /// Clone object.
  T clone<T>(T object) {
    if (object == null) return null;
    if (_immutableTypes.contains(object.runtimeType)) return object;

    final im = reflect(object);
    final cm = im.type;
    final typeName = cm.qualifiedName.toString();
    if (typeName.startsWith('Symbol("dart.core.')) {
      return object;
    }

    final result = cm.newInstance(Symbol(''), []);

    void updateFields(ClassMirror type) {
      final variables = type.declarations.values
          .where((dm) => dm is VariableMirror)
          .cast<VariableMirror>()
          .toList();
      for (VariableMirror vm in variables) {
        result.setField(
            vm.simpleName, clone(im.getField(vm.simpleName).reflectee));
      }

      if (type.superclass != null) {
        updateFields(type.superclass);
      }
    }

    updateFields(im.type);
    return result.reflectee as T;
  }
}
