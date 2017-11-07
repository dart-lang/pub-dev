import 'package:mustache/mustache.dart';

main() {
  var partial = new Template('{{ foo }}', name: 'partial');

  var resolver = (String name) {
     if (name == 'partial-name') { // Name of partial tag.
       return partial;
     }
  };

  var t = new Template('{{> partial-name }}', partialResolver: resolver);

  var output = t.renderString({'foo': 'bar'}); // bar
  print(output);
}
