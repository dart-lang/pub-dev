import 'package:build/build.dart' show BuildStep, log;
import 'package:code_builder/code_builder.dart' as code;
import 'package:code_builder/code_builder.dart' show Code;
import 'package:http_methods/http_methods.dart' show isHttpMethod;
import 'package:meta/meta.dart';
import 'package:source_gen/source_gen.dart' as g;
import 'package:analyzer/dart/element/element.dart'
    show ClassElement, ExecutableElement;
import 'package:shelf/shelf.dart' as shelf;
import '../api_generator.dart' show EndPoint;

// Type checkers that we need later
final _endPointType = g.TypeChecker.fromRuntime(EndPoint);
final _responseType = g.TypeChecker.fromRuntime(shelf.Response);
final _requestType = g.TypeChecker.fromRuntime(shelf.Request);
final _stringType = g.TypeChecker.fromRuntime(String);

/// A representation of a handler that was annotated with [EndPoint].
class _Handler {
  final String verb, route;
  final ExecutableElement element;

  _Handler(this.verb, this.route, this.element);
}

/// Find members of a class annotated with [EndPoint].
List<ExecutableElement> getAnnotatedElementsOrderBySourceOffset(
    ClassElement cls) {
  return <ExecutableElement>[]
    ..addAll(cls.methods.where(_endPointType.hasAnnotationOfExact))
    ..addAll(cls.accessors.where(_endPointType.hasAnnotationOfExact))
    ..sort((a, b) => (a.nameOffset ?? -1).compareTo(b.nameOffset ?? -1));
}

class ApiRouterGenerator extends g.Generator {
  @override
  Future<String> generate(g.LibraryReader library, BuildStep step) async {
    // Create a map from ClassElement to list of annotated elements sorted by
    // offset in source code, this is not type checked yet.
    final classes = <ClassElement, List<_Handler>>{};
    for (final cls in library.classes) {
      final elements = getAnnotatedElementsOrderBySourceOffset(cls);
      if (elements.isEmpty) {
        continue;
      }
      log.info('found EndPoint annotations in ${cls.name}');

      classes[cls] = elements
          .map((e) => _endPointType.annotationsOfExact(e).map((a) => _Handler(
                a.getField('verb').toStringValue(),
                a.getField('route').toStringValue(),
                e,
              )))
          .expand((i) => i)
          .toList();
    }
    if (classes.isEmpty) {
      return null; // nothing to do if nothing was annotated
    }

    // TODO: Type checking at code-gen time would be nice to have.
    for (final handlers in classes.values) {
      for (final h in handlers) {
        if (!isHttpMethod(h.verb)) {
          throw g.InvalidGenerationSourceError(
            '"${h.verb}" is not a valid HTTP verb.',
            element: h.element,
          );
        }
      }
    }

    // Build library and emit code with all generate methods.
    final methods = classes.entries.map((e) => _buildRouterMethod(
          classElement: e.key,
          handlers: e.value,
        ));
    return code.Library((b) => b.body.addAll(methods))
        .accept(code.DartEmitter())
        .toString();
  }
}

/// Generate a `_$<className>Router(<className> service)` method that returns a
/// `shelf_router.Router` configured based on annotated handlers.
code.Method _buildRouterMethod({
  @required ClassElement classElement,
  @required List<_Handler> handlers,
}) =>
    code.Method(
      (b) => b
        ..name = '_\$${classElement.name}Router'
        ..requiredParameters.add(
          code.Parameter((b) => b
            ..name = 'service'
            ..type = code.refer(classElement.name)),
        )
        ..returns = code.refer('Router')
        ..body = code.Block.of([
          code.refer('Router').newInstance([]).assignFinal('router').statement,
          for (final h in handlers)
            _buildAddHandlerCode(
              router: code.refer('router'),
              service: code.refer('service'),
              handler: h,
            ),
          code.refer('router').returned.statement,
        ]),
    );

/// Generate the code statement that adds [handler] from [service] to [router].
code.Code _buildAddHandlerCode({
  @required code.Reference router,
  @required code.Reference service,
  @required _Handler handler,
}) {
  // service.property(handler.element.name)
  // Find the route parameters
  final routeParams = handler.element.parameters
      .skip(1)
      .takeWhile((p) => p.type.isDartCoreString)
      .map((p) => p.displayName);
  final hasBody = !handler.element.parameters.last.type.isDartCoreString;
  final bodyType = handler.element.parameters.last.type.displayName;
  final returnsResponse =
      _responseType.isExactly(handler.element.returnType.element);
  return router.property('add').call([
    code.literalString(handler.verb.toUpperCase()),
    code.literalString(handler.route, raw: true),
    code.Method(
      (b) => b
        ..modifier = code.MethodModifier.async
        ..requiredParameters.addAll([
          // First parameter is ALWAYS a shelf.Request
          code.Parameter(
            (b) => b
              ..name = 'request'
              ..type = code.refer('Request'),
          ),
          // Followed a number of string parameters from the router
          for (final param in routeParams)
            code.Parameter(
              (b) => b
                ..name = param
                ..type = code.refer('String'),
            ),
        ])
        ..returns = code.refer('Response')
        ..body = code.Block.of([
          Code('try {'),
          service
              .property(handler.element.name)
              .call([
                code.refer('request'),
                for (final param in routeParams) code.refer(param),
                if (hasBody)
                  code.refer('\$utilities').property('decodeJson').call([
                    code.refer('request'),
                    code.Method(
                      (b) => b
                        ..requiredParameters
                            .add(code.Parameter((b) => b.name = 'o'))
                        ..body = code
                            .refer(bodyType)
                            .property('fromJson')
                            .call([code.refer('o')])
                            .returned
                            .statement,
                    ).closure,
                  ], {}, [
                    code.refer(bodyType),
                  ]).awaited,
              ])
              .awaited
              .assignFinal('_\$result')
              .statement,
          (returnsResponse
              ? Code('return _\$result;')
              : Code('return \$utilities.encodeJson(_\$result.toJson());')),
          Code('} on ResponseException catch (e) {'),
          Code('  return e.asResponse();'),
          Code('}'),
        ]),
    ).closure,
  ]).statement;
}
