
part of archive_test;

void defineAdlerTests() {
  group('adler32', () {
    test('empty', () {
      int adlerVal = getAdler32([]);
      expect(adlerVal, 1);
    });
    test('1 byte', () {
      int adlerVal = getAdler32([1]);
      expect(adlerVal, 0x20002);
    });
    test('10 bytes', () {
      int adlerVal = getAdler32([1, 2, 3, 4, 5, 6, 7, 8, 9, 0]);
      expect(adlerVal, 0xDC002E);
    });
    test('100000 bytes', () {
      int adlerVal = getAdler32([]);
      for (int i = 0; i < 10000; i++) {
        adlerVal = getAdler32([1, 2, 3, 4, 5, 6, 7, 8, 9, 0], adlerVal);
      }
      expect(adlerVal, 0x96C8DE2B);
    });
  });

  group('adler32 class', () {
    test('empty', () {
      Adler32 adler = new Adler32();
      expect(adler.close(), [0, 0, 0, 1]);
    });
    test('1 byte', () {
      Adler32 adler = new Adler32();
      adler.add([1]);
      expect(adler.close(), [0, 0x02, 0, 0x02]);
    });
    test('10 bytes', () {
      Adler32 adler = new Adler32();
      adler.add([1, 2, 3, 4, 5, 6, 7, 8, 9, 0]);
      expect(adler.close(), [0, 0xDC, 0, 0x2E]);
    });
    test('100000 bytes', () {
      Adler32 adler = new Adler32();
      for (int i = 0; i < 10000; i++) {
        adler.add([1, 2, 3, 4, 5, 6, 7, 8, 9, 0]);
      }
      expect(adler.close(), [0x96, 0xC8, 0xDE, 0x2B]);
    });
  });
}
