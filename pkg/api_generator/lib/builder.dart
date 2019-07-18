import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart' as g;
import 'src/api_builder.dart' show ApiRouterGenerator;

Builder apiRouter(BuilderOptions _) => g.SharedPartBuilder(
      [ApiRouterGenerator()],
      'api_router',
    );
