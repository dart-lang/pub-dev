part of archive_test;

void defineInputStreamTests() {
  group('InputStream', () {
    test('empty', () {
      InputStream input = new InputStream([]);
      expect(input.length, equals(0));
      expect(input.isEOS, equals(true));
    });

    test('readByte', () {
      const List<int> data = const [0xaa, 0xbb, 0xcc];
      InputStream input = new InputStream(data);
      expect(input.length, equals(3));
      expect(input.readByte(), equals(0xaa));
      expect(input.readByte(), equals(0xbb));
      expect(input.readByte(), equals(0xcc));
      expect(input.isEOS, equals(true));
    });

    test('peakBytes', () {
      const List<int> data = const [0xaa, 0xbb, 0xcc];

      InputStream input = new InputStream(data);
      expect(input.readByte(), equals(0xaa));

      InputStream bytes = input.peekBytes(2);
      expect(bytes[0], equals(0xbb));
      expect(bytes[1], equals(0xcc));
      expect(input.readByte(), equals(0xbb));
      expect(input.readByte(), equals(0xcc));
      expect(input.isEOS, equals(true));
    });

    test('skip', () {
      const List<int> data = const [0xaa, 0xbb, 0xcc];
      InputStream input = new InputStream(data);
      expect(input.length, equals(3));
      expect(input.readByte(), equals(0xaa));
      input.skip(1);
      expect(input.readByte(), equals(0xcc));
      expect(input.isEOS, equals(true));
    });

    test('subset', () {
      const List<int> data = const [0xaa, 0xbb, 0xcc, 0xdd, 0xee];
      InputStream input = new InputStream(data);
      expect(input.length, equals(5));
      expect(input.readByte(), equals(0xaa));

      InputStream i2 = input.subset(null, 3);

      InputStream i3 = i2.subset(1, 2);

      expect(i2.readByte(), equals(0xbb));
      expect(i2.readByte(), equals(0xcc));
      expect(i2.readByte(), equals(0xdd));
      expect(i2.isEOS, equals(true));

      expect(i3.readByte(), equals(0xcc));
      expect(i3.readByte(), equals(0xdd));
    });

    test('readString', () {
      const List<int> data = const [84, 101, 115, 116, 0];
      InputStream input = new InputStream(data);
      String s = input.readString();
      expect(s, equals('Test'));
      expect(input.isEOS, equals(true));

      input.reset();

      s = input.readString(4);
      expect(s, equals('Test'));
      expect(input.readByte(), equals(0));
      expect(input.isEOS, equals(true));
    });

    test('readBytes', () {
      const List<int> data = const [84, 101, 115, 116, 0];
      InputStream input = new InputStream(data);
      InputStream b = input.readBytes(3);
      expect(b.length, equals(3));
      expect(b[0], equals(84));
      expect(b[1], equals(101));
      expect(b[2], equals(115));
      expect(input.readByte(), equals(116));
      expect(input.readByte(), equals(0));
      expect(input.isEOS, equals(true));
    });

    test('readUint16', () {
      const List<int> data = const [0xaa, 0xbb, 0xcc, 0xdd, 0xee];
      // Little endian (by default)
      InputStream input = new InputStream(data);
      expect(input.readUint16(), equals(0xbbaa));

      // Big endian
      InputStream i2 = new InputStream(data, byteOrder: BIG_ENDIAN);
      expect(i2.readUint16(), equals(0xaabb));
    });

    test('readUint24', () {
      const List<int> data = const [0xaa, 0xbb, 0xcc, 0xdd, 0xee];
      // Little endian (by default)
      InputStream input = new InputStream(data);
      expect(input.readUint24(), equals(0xccbbaa));

      // Big endian
      InputStream i2 = new InputStream(data, byteOrder: BIG_ENDIAN);
      expect(i2.readUint24(), equals(0xaabbcc));
    });

    test('readUint32', () {
      const List<int> data = const [0xaa, 0xbb, 0xcc, 0xdd, 0xee];
      // Little endian (by default)
      InputStream input = new InputStream(data);
      expect(input.readUint32(), equals(0xddccbbaa));

      // Big endian
      InputStream i2 = new InputStream(data, byteOrder: BIG_ENDIAN);
      expect(i2.readUint32(), equals(0xaabbccdd));
    });

    test('readUint64', () {
      const List<int> data = const [0xaa, 0xbb, 0xcc, 0xdd, 0xee, 0xff,
                                    0xee, 0xdd];
      // Little endian (by default)
      InputStream input = new InputStream(data);
      expect(input.readUint64(), equals(0xddeeffeeddccbbaa));

      // Big endian
      InputStream i2 = new InputStream(data, byteOrder: BIG_ENDIAN);
      expect(i2.readUint64(), equals(0xaabbccddeeffeedd));
    });
  });
}
