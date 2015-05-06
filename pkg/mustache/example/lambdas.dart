import 'package:mustache/mustache.dart';

main() {
  var t = new Template('{{ foo }}');
  var lambda = (_) => 'bar';
  var output = t.renderString({'foo': lambda}); // bar
  print(output);

  t = new Template('{{# foo }}hidden{{/ foo }}');
  lambda = (_) => 'shown';
  output = t.renderString({'foo': lambda}); // shown
  print(output);

  t = new Template('{{# foo }}oi{{/ foo }}');
  lambda = (LambdaContext ctx) => '<b>${ctx.renderString().toUpperCase()}</b>';
  output = t.renderString({'foo': lambda}); // <b>OI</b>
  print(output);

  t = new Template('{{# foo }}{{bar}}{{/ foo }}');
  lambda = (LambdaContext ctx) => '<b>${ctx.renderString().toUpperCase()}</b>';
  output = t.renderString({'foo': lambda, 'bar': 'pub'}); // <b>PUB</b>
  print(output);

  t = new Template('{{# foo }}{{bar}}{{/ foo }}');
  lambda = (LambdaContext ctx) => '<b>${ctx.renderString().toUpperCase()}</b>';
  output = t.renderString({'foo': lambda, 'bar': 'pub'}); // <b>PUB</b>
  print(output);

  t = new Template('{{# foo }}{{bar}}{{/ foo }}');
  lambda = (LambdaContext ctx) => ctx.renderSource(ctx.source + '{{cmd}}');
  output = t.renderString({'foo': lambda, 'bar': 'pub', 'cmd': 'build'}); // pub build
  print(output);
}
