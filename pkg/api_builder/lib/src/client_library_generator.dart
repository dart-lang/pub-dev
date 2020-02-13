import 'package:code_builder/code_builder.dart' as code;
import 'package:code_builder/code_builder.dart' show Code;
import 'package:analyzer/dart/element/element.dart'
    show ClassElement, ExecutableElement;
import 'package:analyzer/dart/element/type.dart'
    show DartType, ParameterizedType;
import 'package:shelf/shelf.dart' as shelf;
import 'package:source_gen/source_gen.dart' as g;

import 'shared.dart' show EndPointGenerator, Handler;

code.Reference _referToType(DartType type) =>
    code.refer(type.name, type.element.source.uri.toString());

final _responseType = g.TypeChecker.fromRuntime(shelf.Response);

/// Use the first Handler when a method has multiple EndPoint annotations.
Iterable<Handler> _removeDuplicateHandlers(Iterable<Handler> handlers) {
  final seen = <ExecutableElement>{};
  return handlers.where((h) {
    return seen.add(h.element);
  });
}

class ClientLibraryGenerator extends EndPointGenerator {
  @override
  Future<String> generateForClasses(
    Map<ClassElement, List<Handler>> classes,
  ) async {
    return code.Library((b) => b
          ..directives.add(code.Directive.export(
            'package:api_builder/_client_utils.dart',
            show: ['RequestException'],
          ))
          ..body.addAll([
            for (final cls in classes.entries)
              _buildClientClass(cls.key, cls.value),
          ]))
        .accept(
          code.DartEmitter(code.Allocator.simplePrefixing(), true),
        )
        .toString();
  }
}

code.Class _buildClientClass(
  ClassElement cls,
  List<Handler> handlers,
) =>
    code.Class(
      (b) => b
        ..docs.addAll([
          '/// Client for invoking `${cls.name}` through the generated router.',
          '///',
          '/// Reponses other than 2xx causes the methods to throw',
          '/// `RequestException`. JSON encoding/decoding errors are not',
          '/// handled gracefully. End-points that does not return a JSON',
          '/// structure result in a method that returns the response body',
          '/// as bytes',
        ])
        ..name = '${cls.name}Client'
        ..fields.add(code.Field(
          (b) => b
            ..name = '_client'
            ..type =
                code.refer('Client', 'package:api_builder/_client_utils.dart')
            ..modifier = code.FieldModifier.final$,
        ))
        ..constructors.add(code.Constructor((b) => b
          ..requiredParameters.add(code.Parameter(
            (b) => b
              ..name = 'baseUrl'
              ..type = code.refer('String'),
          ))
          ..optionalParameters.add(code.Parameter(
            (b) => b
              ..name = 'client'
              ..named = true
              ..type = code.refer('Client', 'package:http/http.dart'),
          ))
          ..initializers.add(
            code
                .refer('_client')
                .assign(
                  code
                      .refer('Client', 'package:api_builder/_client_utils.dart')
                      .call([
                    code.refer('baseUrl'),
                  ], {
                    'client': code.refer('client'),
                  }),
                )
                .code,
          )))
        ..methods.addAll(
          _removeDuplicateHandlers(handlers).map(_buildClientMethod),
        ),
    );

/// Route pattern parser
///
/// This will match `'user/<userId|.*>'` as `['user/', 'userId', '.*']`.
final _parser = RegExp(r'([^<]*)(?:<([^>|]+)(?:\|([^>]*))?>)?');

code.Method _buildClientMethod(
  Handler h,
) {
  // Find url parameters
  final params = _parser
      .allMatches(h.route)
      .map((m) => m[2])
      .where((p) => p != null)
      .toList();
  // Create a url pattern that embeds parameters above
  final urlPattern = h.route.replaceAllMapped(
    _parser,
    (m) => m[2] != null ? '${m[1]}\$${m[2]}' : m[1],
  );

  // Check the return value of the method.
  var retType = h.element.returnType;
  // Unpack Future<T> and FutureOr<T> wrapping of responseType
  if (retType.isDartAsyncFuture || retType.isDartAsyncFutureOr) {
    retType = (retType as ParameterizedType).typeArguments.first;
  }
  final returnsResponse = _responseType.isAssignableFromType(retType);

  // If return type is a Response, we create a client that return List<int>
  code.Reference returnTypeRef = _referToType(retType);
  if (returnsResponse) {
    returnTypeRef = code.refer('List<int>');
  }

  // Serialized code mapping query names to query parameters in a
  // Map<String,String> (used later in the generated code)
  final queryMap =
      h.queryParameters.map((p) => '${p.name} != null').join(' || ') +
          ' ? <String,String>{' +
          h.queryParameters
              .map((p) => 'if (${p.name} != null) \'${p.name}\': ${p.name}')
              .join(', ') +
          '} : null';

  return code.Method(
    (b) => b
      ..name = h.element.name
      ..returns = code.TypeReference((b) => b
        ..symbol = 'Future'
        ..types.add(returnTypeRef))
      ..requiredParameters.addAll([
        for (final param in params)
          code.Parameter(
            (b) => b
              ..name = param
              ..type = code.refer('String'),
          ),
        if (h.hasPayload)
          code.Parameter(
            (b) => b
              ..name = 'payload'
              ..type = _referToType(h.payloadType),
          )
      ])
      ..optionalParameters.addAll([
        for (final param in h.queryParameters)
          code.Parameter(
            (b) => b
              ..name = param.name
              ..type = code.refer('String')
              ..named = true,
          )
      ])
      ..modifier = code.MethodModifier.async
      ..body = returnsResponse ? Code.scope((r) => '''
        return await _client.requestBytes(
          verb: '${h.verb.toLowerCase()}',
          path: '$urlPattern',
          ${h.queryParameters.isEmpty ? '' : 'query: ' + queryMap + ','}
          ${h.hasPayload ? 'body: payload.toJson(),' : ''}
        );
      ''') : Code.scope((r) => '''
        return ${r(returnTypeRef)}.fromJson(await _client.requestJson(
          verb: '${h.verb.toLowerCase()}',
          path: '$urlPattern',
          ${h.queryParameters.isEmpty ? '' : 'query: ' + queryMap + ','}
          ${h.hasPayload ? 'body: payload.toJson(),' : ''}
        ));
      '''),
  );
}
