import 'package:mustache/mustache.dart';

main() {
  var template = new Template('{{ author.name }}');
  var output = template.renderString({'author': {'name': 'Greg Lowe'}});
  print(output);
}
