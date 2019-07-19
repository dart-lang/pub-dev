import 'package:code_builder/code_builder.dart' as code;
import 'package:code_builder/code_builder.dart' show Code;
import 'package:analyzer/dart/element/element.dart' show ClassElement;
import 'package:analyzer/dart/element/type.dart'
    show DartType, ParameterizedType;
import 'package:shelf/shelf.dart' as shelf;
import 'package:source_gen/source_gen.dart' as g;

import 'shared.dart' show EndPointGenerator, Handler;

code.Reference _referToType(DartType type) =>
    code.refer(type.name, type.element.source.uri.toString());

final _responseType = g.TypeChecker.fromRuntime(shelf.Response);

class ClientLibraryGenerator extends EndPointGenerator {
  @override
  Future<String> generateForClasses(
    Map<ClassElement, List<Handler>> classes,
  ) async {
    return code.Library((b) => b
          ..directives.add(code.Directive.import(
            'package:api_builder/_client_utils.dart',
            show: ['ResponseException'],
          ))
          ..body.addAll([
            for (final cls in classes.entries)
              _buildClientClass(cls.key, cls.value),
          ]))
        .accept(
          code.DartEmitter(code.Allocator.simplePrefixing()),
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
          '/// `ResponseException`. JSON encoding/decoding errors are not',
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
        ..methods.addAll(handlers.map(_buildClientMethod)),
    );

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

  // Find if we have payload, and what type
  final hasPayload = !h.element.parameters.last.type.isDartCoreString;
  final payloadType = h.element.parameters.last.type;

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
        if (hasPayload)
          code.Parameter(
            (b) => b
              ..name = 'payload'
              ..type = _referToType(payloadType),
          )
      ])
      ..modifier = code.MethodModifier.async
      ..body = returnsResponse ? Code.scope((r) => '''
        return await _client.requestBytes(
          verb: '${h.verb.toLowerCase()}',
          path: '$urlPattern',
          ${hasPayload ? 'body: payload.toJson(),' : ''}
        );
      ''') : Code.scope((r) => '''
        return ${r(returnTypeRef)}.fromJson(await _client.requestJson(
          verb: '${h.verb.toLowerCase()}',
          path: '$urlPattern',
          ${hasPayload ? 'body: payload.toJson(),' : ''}
        ));
      '''),
  );
}
