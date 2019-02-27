import 'package:test/test.dart';

import 'package:fake_gcloud/src/cloner.dart';

void main() {
  final cloner = Cloner();

  test('sample', () {
    final x = cloner.clone(Sample()
      ..type = 't1'
      ..count = 1);
    expect(x, isNotNull);
    expect(x.type, 't1');
    expect(x.count, 1);
  });
}

class Sample {
  String type;
  int count;
}
