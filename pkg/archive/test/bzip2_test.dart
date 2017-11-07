part of archive_test;


void defineBzip2Tests() {
  io.File script = new io.File(io.Platform.script.toFilePath());
  String path = script.parent.path;

  group('bzip2', () {
    test('decode', () {
      List<int> orig =
          new io.File(path + '/res/bzip2/test.bz2').readAsBytesSync();

      new BZip2Decoder().decodeBytes(orig);
    });

    test('encode', () {
      List<int> file = new io.File(path + '/res/cat.jpg').readAsBytesSync();

      List<int> compressed = new BZip2Encoder().encode(file);

      List<int> d2 = new BZip2Decoder().decodeBytes(compressed);

      expect(d2.length, equals(file.length));
      for (int i = 0, len = d2.length; i < len; ++i) {
        expect(d2[i], equals(file[i]));
      }
    });
  });
}
