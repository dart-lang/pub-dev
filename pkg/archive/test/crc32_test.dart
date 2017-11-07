
part of archive_test;

void defineCrc32Tests() {
  group('crc32', () {
    test('empty', () {
      int crcVal = getCrc32([]);
      expect(crcVal, 0);
    });
    test('1 byte', () {
      int crcVal = getCrc32([1]);
      expect(crcVal, 0xA505DF1B);
    });
    test('10 bytes', () {
      int crcVal = getCrc32([1, 2, 3, 4, 5, 6, 7, 8, 9, 0]);
      expect(crcVal, 0xC5F5BE65);
    });
    test('100000 bytes', () {
      int crcVal = getCrc32([]);
      for (int i = 0; i < 10000; i++) {
        crcVal = getCrc32([1, 2, 3, 4, 5, 6, 7, 8, 9, 0], crcVal);
      }
      expect(crcVal, 0x3AC67C2B);
    });
  });

  group('crc32 class', () {
    test('empty', () {
      Crc32 crc = new Crc32();
      expect(crc.close(), [0, 0, 0, 0]);
    });
    test('1 byte', () {
      Crc32 crc = new Crc32();
      crc.add([1]);
      expect(crc.close(), [0xA5, 0x05, 0xDF, 0x1B]);
    });
    test('10 bytes', () {
      Crc32 crc = new Crc32();
      crc.add([1, 2, 3, 4, 5, 6, 7, 8, 9, 0]);
      expect(crc.close(), [0xC5, 0xF5, 0xBE, 0x65]);
    });
    test('100000 bytes', () {
      Crc32 crc = new Crc32();
      for (int i = 0; i < 10000; i++) {
        crc.add([1, 2, 3, 4, 5, 6, 7, 8, 9, 0]);
      }
      expect(crc.close(), [0x3A, 0xC6, 0x7C, 0x2B]);
    });
  });
}
