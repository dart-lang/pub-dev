part of archive_test;

void defineCommandTests() {
  io.File script = new io.File(io.Platform.script.toFilePath());
  String path = script.parent.path;

  group('commands', () {
    test('bin/tar.dart list', () {
      // Test that 'tar --list' does not throw.
      tar_command.listFiles(path + '/res/test2.tar.gz');
    });

    test('tar extract', () {
      io.Directory dir = io.Directory.systemTemp.createTempSync('foo');

      try {
        print(dir.path);

        String inputPath = path + '/res/test2.tar.gz';

        {
          io.Directory temp_dir = io.Directory.systemTemp.createTempSync('dart_archive');
          String tar_path = '${temp_dir.path}${io.Platform.pathSeparator}temp.tar';
          InputFileStream input = new InputFileStream(inputPath);
          OutputFileStream output = new OutputFileStream(tar_path);
          new GZipDecoder().decodeStream(input, output);
          input.close();
          output.close();

          List<int> a_bytes = new io.File(tar_path).readAsBytesSync();
          List<int> b_bytes = new io.File(path + '/res/test2.tar').readAsBytesSync();

          expect(a_bytes.length, equals(b_bytes.length));
          bool same = true;
          for (int i = 0; same && i < a_bytes.length; ++i) {
            same = a_bytes[i] == b_bytes[i];
          }
          expect(same, equals(true));

          temp_dir.deleteSync(recursive: true);
        }

        tar_command.extractFiles(path + '/res/test2.tar.gz', dir.path);
        //io.sleep(const Duration(seconds:1));
        expect(dir.listSync().length, 9);
      } finally {
        dir.deleteSync(recursive: true);
      }
    });

    test('tar create', () {
      io.Directory dir = io.Directory.systemTemp.createTempSync('foo');
      io.File file = new io.File('${dir.path}${io.Platform.pathSeparator}foo.txt');
      file.writeAsStringSync('foo bar');

      try {
        // Test that 'tar --create' does not throw.
        tar_command.createTarFile(dir.path);
      } finally {
        dir.delete(recursive: true);
      }
    });
  });
}
