library UuidUtil;
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'aes.dart';

class UuidUtil {

  /**
   * Math.Random()-based RNG. All platforms, fast, not cryptographically strong. Optional Seed passable.
   */
  static List<int> mathRNG({int seed: null}) {
    var rand, b = new List<int>(16);

    var _rand = (seed == null) ? new Random() : new Random(seed);
    for(var i = 0; i < 16; i++) {
      if ((i & 0x03) == 0) {
        rand = (_rand.nextDouble() * 0x100000000).floor().toInt();
      }
      b[i] = rand >> ((i & 0x03) << 3) & 0xff;
    }

    return b;
  }

  /**
   * AES-based RNG. All platforms, unknown speed, cryptographically strong (theoretically)
   */
  static List cryptoRNG() {
    int nBytes = 32;
    var pwBytes = new List(nBytes);

    var bytes = mathRNG();
    pwBytes = sha256.convert(bytes).bytes.sublist(0, nBytes);

    return AES.cipher(pwBytes, AES.keyExpansion(pwBytes));
  }
}