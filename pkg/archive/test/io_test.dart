part of archive_test;

void defineIoTests() {
  io.File script = new io.File(io.Platform.script.toFilePath());
  String path = script.parent.path;

  group('io', () {
    test('InputFileStream', () {
      // Test fundamental assumption setPositionSync does what we expect.
      io.RandomAccessFile fp = new io.File(path + '/res/cat.jpg').openSync();
      fp.setPositionSync(9);
      int b1 = fp.readByteSync();
      int b2 = fp.readByteSync();
      fp.setPositionSync(9);
      int c1 = fp.readByteSync();
      int c2 = fp.readByteSync();
      expect(b1, equals(c1));
      expect(b2, equals(c2));

      // Test rewind across buffer boundary.
      InputFileStream input = new InputFileStream(path + '/res/cat.jpg',
          bufferSize: 10);

      for (int i = 0; i < 9; ++i) {
        input.readByte();
      }
      b1 = input.readByte();
      b2 = input.readByte();
      input.rewind(2);
      c1 = input.readByte();
      c2 = input.readByte();
      expect(b1, equals(c1));
      expect(b2, equals(c2));

      // Test if peekBytes works across a buffer boundary.
      input = new InputFileStream(path + '/res/cat.jpg',
          bufferSize: 10);
      for (int i = 0; i < 9; ++i) {
        input.readByte();
      }
      b1 = input.readByte();
      b2 = input.readByte();

      input.close();
      input = new InputFileStream(path + '/res/cat.jpg',
          bufferSize: 10);
      for (int i = 0; i < 9; ++i) {
        input.readByte();
      }

      InputStream b = input.peekBytes(2);
      expect(b.length, equals(2));
      expect(b[0], equals(b1));
      expect(b[1], equals(b2));

      InputStream c = input.readBytes(2);
      expect(b[0], equals(c[0]));
      expect(b[1], equals(c[1]));

      input.close();

      input = new InputFileStream(path + '/res/cat.jpg',
          bufferSize: 10);
      InputStream input2 = new InputStream(
          new io.File(path + '/res/cat.jpg').readAsBytesSync());

      bool same = true;
      while (!input.isEOS && same) {
        same = input.readByte() == input2.readByte();
      }
      expect(same, equals(true));
      expect(input.isEOS, equals(input2.isEOS));

      // Test skip across buffer boundary
      input = new InputFileStream(path + '/res/cat.jpg',
          bufferSize: 10);
      for (int i = 0; i < 11; ++i) {
        input.readByte();
      }
      b1 = input.readByte();
      input.close();
      input = new InputFileStream(path + '/res/cat.jpg',
          bufferSize: 10);
      for (int i = 0; i < 9; ++i) {
        input.readByte();
      }
      input.skip(2);
      c1 = input.readByte();
      expect(b1, equals(c1));
      input.close();

      // Test skip to end of buffer
      input = new InputFileStream(path + '/res/cat.jpg',
          bufferSize: 10);
      for (int i = 0; i < 10; ++i) {
        input.readByte();
      }
      b1 = input.readByte();
      input.close();
      input = new InputFileStream(path + '/res/cat.jpg',
          bufferSize: 10);
      for (int i = 0; i < 9; ++i) {
        input.readByte();
      }
      input.skip(1);
      c1 = input.readByte();
      expect(b1, equals(c1));
      input.close();
    });

    test('InputFileStream/OutputFileStream', () {
      InputFileStream input = new InputFileStream(path + '/res/cat.jpg');
      OutputFileStream output = new OutputFileStream(path + '/out/cat2.jpg');
      while (!input.isEOS) {
        InputStream bytes = input.readBytes(50);
        output.writeInputStream(bytes);
      }
      input.close();
      output.close();

      List<int> a_bytes = new io.File(path + '/res/cat.jpg').readAsBytesSync();
      List<int> b_bytes = new io.File(path + '/out/cat2.jpg').readAsBytesSync();

      expect(a_bytes.length, equals(b_bytes.length));
      bool same = true;
      for (int i = 0; same && i < a_bytes.length; ++i) {
        same = a_bytes[i] == b_bytes[i];
      }
      expect(same, equals(true));
    });

    test('stream tar decode', () {
      // Decode a tar from disk to memory
      InputFileStream stream = new InputFileStream(path + '/res/test2.tar');
      TarDecoder tarArchive = new TarDecoder();
      tarArchive.decodeBuffer(stream);

      for (TarFile file in tarArchive.files) {
        if (!file.isFile) {
          continue;
        }
        String filename = file.filename;
        try {
          io.File f = new io.File('${path}/out/${filename}');
          f.parent.createSync(recursive: true);
          f.writeAsBytesSync(file.content);
        } catch (e) {}
      }

      expect(tarArchive.files.length, equals(9));
    });

    test('stream tar encode', () {
      // Encode a directory from disk to disk, no memory
      TarFileEncoder encoder = new TarFileEncoder();
      encoder.open('$path/out/test3.tar');
      encoder.addDirectory(new io.Directory('$path/res/test2'));
      encoder.close();
    });

    test('stream gzip encode', () {
      InputFileStream input = new InputFileStream(path + '/res/cat.jpg');
      OutputFileStream output = new OutputFileStream(path + '/out/cat.jpg.gz');

      GZipEncoder encoder = new GZipEncoder();
      encoder.encode(input, output: output);
    });

    test('stream gzip decode', () {
      InputFileStream input = new InputFileStream(path + '/out/cat.jpg.gz');
      OutputFileStream output = new OutputFileStream(path + '/out/cat.jpg');

      new GZipDecoder().decodeStream(input, output);
    });

    test('stream tgz encode', () {
      // Encode a directory from disk to disk, no memory
      TarFileEncoder encoder = new TarFileEncoder();
      encoder.open('$path/out/example2.tar');
      encoder.addDirectory(new io.Directory('$path/res/test2'));
      encoder.close();

      InputFileStream input = new InputFileStream(path + '/out/example2.tar');
      OutputFileStream output = new OutputFileStream(path + '/out/example2.tgz');
      new GZipEncoder()..encode(input, output: output);
      input.close();
      new io.File(input.path).deleteSync();
    });
  });
}
