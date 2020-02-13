import 'package:code_builder/code_builder.dart' as code;
import 'package:code_builder/code_builder.dart' show Code;
import 'package:meta/meta.dart';
import 'package:source_gen/source_gen.dart' as g;
import 'package:analyzer/dart/element/element.dart' show ClassElement;
import 'package:analyzer/dart/element/type.dart' show ParameterizedType;
import 'package:shelf/shelf.dart' as shelf;
import 'shared.dart' show EndPointGenerator, Handler;

// Type checkers that we need later
final _responseType = g.TypeChecker.fromRuntime(shelf.Response);

class ApiRouterGenerator extends EndPointGenerator {
  @override
  Future<String> generateForClasses(
    Map<ClassElement, List<Handler>> classes,
  ) async {
    // Build library and emit code with all generate methods.
    final methods = classes.entries.map((e) => _buildRouterMethod(
          classElement: e.key,
          handlers: e.value,
        ));
    return code.Library((b) => b.body.addAll(methods))
        .accept(code.DartEmitter(code.Allocator.simplePrefixing(), true))
        .toString();
  }
}

/// Generate a `_$<className>Router(<className> service)` method that returns a
/// `shelf_router.Router` configured based on annotated handlers.
code.Method _buildRouterMethod({
  @required ClassElement classElement,
  @required List<Handler> handlers,
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
  @required Handler handler,
}) {
  // Check the return value of the method.
  var returnType = handler.element.returnType;
  // Unpack Future<T> and FutureOr<T> wrapping of responseType
  if (returnType.isDartAsyncFuture || returnType.isDartAsyncFutureOr) {
    returnType = (returnType as ParameterizedType).typeArguments.first;
  }
  final returnsResponse = _responseType.isAssignableFromType(returnType);

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
          for (final param in handler.routeParameters)
            code.Parameter(
              (b) => b
                ..name = param
                ..type = code.refer('String'),
            ),
        ])
        ..returns = code.refer('Response')
        ..body = code.Block.of([
          Code('try {'),
          Code(
              'final _\$result = await ${service.symbol}.${handler.element.name}('),
          Code('request,'),
          for (final param in handler.routeParameters) Code('$param,'),
          if (handler.hasPayload)
            Code(
                'await \$utilities.decodeJson<${handler.payloadType.name}>(request, (o) => ${handler.payloadType.name}.fromJson(o)),'),
          for (final param in handler.queryParameters)
            Code(
              '${param.name}: '
                      'request.requestedUri.queryParameters[\'${param.name}\'] ' +
                  (param.defaultValueCode != null
                      ? ' ?? ${param.defaultValueCode}'
                      : '') +
                  ',',
            ),
          Code(');'),
          (returnsResponse
              ? Code('return _\$result;')
              : Code('return \$utilities.jsonResponse(_\$result.toJson());')),
          Code('} on ApiResponseException catch (e) {'),
          Code('  return e.asApiResponse();'),
          Code('} catch (e, st) {'),
          Code('  return \$utilities.unhandledError(e, st);'),
          Code('}'),
        ]),
    ).closure,
  ]).statement;
}
