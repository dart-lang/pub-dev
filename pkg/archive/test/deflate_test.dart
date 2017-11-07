part of archive_test;

void defineDeflateTests() {
  group('deflate', () {
    List<int> buffer = new List<int>(0xfffff);
    for (int i = 0; i < buffer.length; ++i) {
      buffer[i] = i % 256;
    }

    test('NO_COMPRESSION', () {
      List<int> deflated = new Deflate(buffer,
          level: Deflate.NO_COMPRESSION).getBytes();

      List<int> inflated = new Inflate(deflated).getBytes();

      expect(inflated.length, equals(buffer.length));
      for (int i = 0; i < buffer.length; ++i) {
        expect(inflated[i], equals(buffer[i]));
      }
    });

    test('BEST_SPEED', () {
      List<int> deflated = new Deflate(buffer,
          level: Deflate.BEST_SPEED).getBytes();

      List<int> inflated = new Inflate(deflated).getBytes();

      expect(inflated.length, equals(buffer.length));
      for (int i = 0; i < buffer.length; ++i) {
        expect(inflated[i], equals(buffer[i]));
      }
    });

    test('BEST_COMPRESSION', () {
      List<int> deflated = new Deflate(buffer,
          level: Deflate.BEST_COMPRESSION).getBytes();

      List<int> inflated = new Inflate(deflated).getBytes();

      expect(inflated.length, equals(buffer.length));
      for (int i = 0; i < buffer.length; ++i) {
        expect(inflated[i], equals(buffer[i]));
      }
    });
  });
}
