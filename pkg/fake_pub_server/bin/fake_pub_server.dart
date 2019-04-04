import 'package:logging/logging.dart';

import 'package:fake_gcloud/mem_storage.dart';
import 'package:fake_pub_server/fake_pub_server.dart';
import 'package:fake_pub_server/fake_storage_server.dart';

Future main() async {
  Logger.root.onRecord.listen((r) {
    print([
      r.time.toIso8601String(),
      r.toString(),
      r.error,
      r.stackTrace?.toString(),
    ].where((e) => e != null).join(' '));
  });

  final storage = MemStorage();

  final storageServer = FakeStorageServer(storage);
  final pubServer = FakePubServer(storage);

  await Future.wait([
    storageServer.run(),
    pubServer.run(),
  ]);
}
