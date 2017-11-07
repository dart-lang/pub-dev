import 'dart:io';
import 'dart:isolate';

import 'package:http/http.dart' as http;

main() async {
  var packageUrl = Uri.parse('package:node_preamble/');
  var lib = (await Isolate.resolvePackageUri(packageUrl)).toFilePath();

  var preamble = new File('$lib/preamble.js').readAsStringSync();

  var response = await http.post("https://javascript-minifier.com/raw",
      body: {"input": preamble});
  new File("$lib/preamble.min.js").writeAsStringSync(response.body);

  new File("$lib/preamble.dart").writeAsStringSync("""
library node_preamble;

final _minified = r\"""${response.body}\""";

final _normal = r\"""
$preamble\""";

/// Returns the text of the preamble.
///
/// If [minified] is true, returns the minified version rather than the
/// human-readable version.
String getPreamble({bool minified: false, List<String> additionalGlobals: const []}) =>
    (minified ? _minified : _normal) +
    (additionalGlobals == null ? "" :
        additionalGlobals.map((global) => "self.\$global=\$global;").join());
""");
}
