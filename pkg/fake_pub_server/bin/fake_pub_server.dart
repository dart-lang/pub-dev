import 'package:args/args.dart';
import 'package:logging/logging.dart';

import 'package:fake_gcloud/mem_storage.dart';
import 'package:fake_pub_server/fake_pub_server.dart';
import 'package:fake_pub_server/fake_storage_server.dart';

final _argParser = ArgParser()
  ..addOption('port',
      defaultsTo: '8080', help: 'The HTTP port of the fake pub server.')
  ..addOption('storage-port',
      defaultsTo: '8081', help: 'The HTTP port for the fake storage server.');

Future main(List<String> args) async {
  final argv = _argParser.parse(args);
  final port = int.parse(argv['port'] as String);
  final storagePort = int.parse(argv['storage-port'] as String);

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

  await Future.wait(
    [
      storageServer.run(port: storagePort),
      pubServer.run(
          port: port, storageBaseUrl: 'http://localhost:$storagePort'),
    ],
    eagerError: true,
  );
}
