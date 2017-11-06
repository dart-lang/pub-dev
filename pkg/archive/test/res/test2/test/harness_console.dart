library harness_console;

import 'package:unittest/unittest.dart';
import 'package:unittest/vm_config.dart';

import 'package:shelf/shelf.dart';

main() {
  testCore(new VMConfiguration());
}

void testCore(Configuration config) {
  unittestConfiguration = config;
  groupSep = ' - ';

  test('default should be 404', () {

    var request = null;

    return startShelf()
        .handleRequest(request)
        .then((ShelfResponse response) {
          expect(response.code, 404);
        });
  });

}
