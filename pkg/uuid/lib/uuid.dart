library Uuid;
import 'dart:math';
import 'uuid_util.dart';
import 'package:crypto/crypto.dart';
import 'package:convert/convert.dart' as convert;

/**
 *  uuid for Dart
 *
 *  Copyright (c) 2015 Yulian Kuncheff
 *
 *  Released under MIT License.
 *
 *  Based on node-uuid by Robert Kieffer.
 */

class Uuid {

  // This isn't used, I just am propogating to use of TAU over PI - http://tauday.com/tau-manifesto
  static final TAU = 2*PI;

  // RFC4122 provided namespaces for v3 and v5 namespace based UUIDs
  static const NAMESPACE_DNS = '6ba7b810-9dad-11d1-80b4-00c04fd430c8';
  static const NAMESPACE_URL = '6ba7b811-9dad-11d1-80b4-00c04fd430c8';
  static const NAMESPACE_OID = '6ba7b812-9dad-11d1-80b4-00c04fd430c8';
  static const NAMESPACE_X500= '6ba7b814-9dad-11d1-80b4-00c04fd430c8';
  static const NAMESPACE_NIL = '00000000-0000-0000-0000-000000000000';

  var _seedBytes, _nodeId, _clockSeq, _lastMSecs = 0, _lastNSecs = 0;
  List<String> _byteToHex;
  Map<String, int> _hexToByte;

  Uuid() {
    _byteToHex = new List<String>(256);
    _hexToByte = new Map<String, int>();

    // Easy number <-> hex conversion
    for(var i = 0; i < 256; i++) {
      var hex = new List<int>();
      hex.add(i);
      _byteToHex[i] = convert.hex.encode(hex);
      _hexToByte[_byteToHex[i]] = i;
    }

    // Sets initial seedBytes, node, and clock seq based on MathRNG.
    _seedBytes = UuidUtil.mathRNG();

    // Per 4.5, create a 48-bit node id (47 random bits + multicast bit = 1)
    _nodeId = [_seedBytes[0] | 0x01, _seedBytes[1], _seedBytes[2], _seedBytes[3], _seedBytes[4], _seedBytes[5]];

    // Per 4.2.2, randomize (14 bit) clockseq
    _clockSeq = (_seedBytes[6] << 8 | _seedBytes[7]) & 0x3ffff;
  }

  /**
   * Parses the provided [uuid] into a list of byte values.
   * Can optionally be provided a [buffer] to write into and
   *  a positional [offset] for where to start inputting into the buffer.
   */
  List<int> parse(String uuid, {List<int> buffer, int offset: 0}) {
    var i = offset, ii = 0;

    // Create a 16 item buffer if one hasn't been provided.
    buffer = (buffer != null) ? buffer : new List<int>(16);

    // Convert to lowercase and replace all hex with bytes then
    // string.replaceAll() does a lot of work that I don't need, and a manual
    // regex gives me more control.
    final RegExp regex = new RegExp('[0-9a-f]{2}');
    for(Match match in regex.allMatches(uuid.toLowerCase())) {
      if(ii < 16) {
        var hex = uuid.toLowerCase().substring(match.start,match.end);
        buffer[i + ii++] = _hexToByte[hex];
      }
    }

    // Zero out any left over bytes if the string was too short.
    while (ii < 16) {
      buffer[i + ii++] = 0;
    }

    return buffer;
  }

  /**
   * Unparses a [buffer] of bytes and outputs a proper UUID string.
   * An optional [offset] is allowed if you want to start at a different point
   *  in the buffer.
   */
  String unparse(List buffer, {int offset: 0}) {
    var i = offset;
    return '${_byteToHex[buffer[i++]]}${_byteToHex[buffer[i++]]}'
           '${_byteToHex[buffer[i++]]}${_byteToHex[buffer[i++]]}-'
           '${_byteToHex[buffer[i++]]}${_byteToHex[buffer[i++]]}-'
           '${_byteToHex[buffer[i++]]}${_byteToHex[buffer[i++]]}-'
           '${_byteToHex[buffer[i++]]}${_byteToHex[buffer[i++]]}-'
           '${_byteToHex[buffer[i++]]}${_byteToHex[buffer[i++]]}'
           '${_byteToHex[buffer[i++]]}${_byteToHex[buffer[i++]]}'
           '${_byteToHex[buffer[i++]]}${_byteToHex[buffer[i++]]}';
  }

  /**
   * v1() Generates a time-based version 1 UUID
   *
   * By default it will generate a string based off current time, and will
   * return a string.
   *
   * If an optional [buffer] list is provided, it will put the byte data into
   * that buffer and return a buffer.
   *
   * Optionally an [offset] can be provided with a start position in the buffer.
   *
   * The first argument is an options map that takes various configuration
   * options detailed in the readme.
   *
   * http://tools.ietf.org/html/rfc4122.html#section-4.2.2
   */
  v1({Map options: null, List buffer: null, int offset:0 }) {
    var i = offset;
    var buf = (buffer != null) ? buffer : new List(16);
    options = (options != null) ? options : new Map();

    var clockSeq = (options['clockSeq'] != null) ? options['clockSeq'] : _clockSeq;

    // UUID timestamps are 100 nano-second units since the Gregorian epoch,
    // (1582-10-15 00:00). Time is handled internally as 'msecs' (integer
    // milliseconds) and 'nsecs' (100-nanoseconds offset from msecs) since unix
    // epoch, 1970-01-01 00:00.
    var mSecs = (options['mSecs'] != null) ? options['mSecs'] : (new DateTime.now()).millisecondsSinceEpoch;

    // Per 4.2.1.2, use count of uuid's generated during the current clock
    // cycle to simulate higher resolution clock
    var nSecs = (options['nSecs'] != null) ? options['nSecs'] : _lastNSecs + 1;

    // Time since last uuid creation (in msecs)
    var dt = (mSecs - _lastMSecs) + (nSecs - _lastNSecs)/10000;

    // Per 4.2.1.2, Bump clockseq on clock regression
    if (dt < 0 && options['clockSeq'] == null) {
      clockSeq = clockSeq + 1 & 0x3fff;
    }

    // Reset nsecs if clock regresses (new clockseq) or we've moved onto a new
    // time interval
    if ((dt < 0 || mSecs > _lastMSecs) && options['nSecs'] == null) {
      nSecs = 0;
    }

    // Per 4.2.1.2 Throw error if too many uuids are requested
    if (nSecs >= 10000) {
      throw new Exception('uuid.v1(): Can\'t create more than 10M uuids/sec');
    }

    _lastMSecs = mSecs;
    _lastNSecs = nSecs;
    _clockSeq = clockSeq;

    // Per 4.1.4 - Convert from unix epoch to Gregorian epoch
    mSecs += 12219292800000;

    // time Low
    var tl = ((mSecs & 0xfffffff) * 10000 + nSecs) % 0x100000000;
    buf[i++] = tl >> 24 & 0xff;
    buf[i++] = tl >> 16 & 0xff;
    buf[i++] = tl >> 8 & 0xff;
    buf[i++] = tl & 0xff;

    // time mid
    var tmh = (mSecs ~/ 0x100000000 * 10000) & 0xfffffff;
    buf[i++] = tmh >> 8 & 0xff;
    buf[i++] = tmh & 0xff;

    // time high and version
    buf[i++] = tmh >> 24 & 0xf | 0x10; // include version
    buf[i++] = tmh >> 16 & 0xff;

    // clockSeq high and reserved (Per 4.2.2 - include variant)
    buf[i++] = clockSeq >> 8 | 0x80;

    // clockSeq low
    buf[i++] = clockSeq & 0xff;

    // node
    var node = (options['node'] != null) ? options['node'] : _nodeId;
    for (var n = 0; n < 6; n++) {
      buf[i + n] = node[n];
    }

    return (buffer != null) ? buffer : unparse(buf);
  }

  /**
   * v4() Generates a time-based version 4 UUID
   *
   * By default it will generate a string based AES-based RNG, and will return
   * a string.
   *
   * If an optional [buffer] list is provided, it will put the byte data into
   * that buffer and return a buffer.
   *
   * Optionally an [offset] can be provided with a start position in the buffer.
   *
   * The first argument is an options map that takes various configuration
   * options detailed in the readme.
   *
   * http://tools.ietf.org/html/rfc4122.html#section-4.4
   */
  v4({Map<String, dynamic> options: null, List buffer: null, int offset: 0}) {
    var i = offset;
    options = (options != null) ? options : new Map<String, dynamic>();

    // Use the built-in RNG or a custom provided RNG
    var positionalArgs = (options['positionalArgs'] != null) ? options['positionalArgs'] : [];
    var namedArgs = (options['namedArgs'] != null) ? options['namedArgs'] as Map<Symbol, dynamic> : const <Symbol, dynamic>{};
    var rng = (options['rng'] != null) ? Function.apply(options['rng'], positionalArgs, namedArgs) : UuidUtil.mathRNG();

    // Use provided values over RNG
    var rnds = (options['random'] != null) ? options['random'] : rng;

    // per 4.4, set bits for version and clockSeq high and reserved
    rnds[6] = (rnds[6] & 0x0f) | 0x40;
    rnds[8] = (rnds[8] & 0x3f) | 0x80;

    // Copy the bytes to the buffer if one is provided.
    if (buffer != null) {
      for (var j = 0; j < 16; j++) {
        buffer[i+j] = rnds[j];
      }
    }

    return (buffer != null) ? buffer : unparse(rnds);
  }

  /**
   * v5() Generates a namspace & name-based version 5 UUID
   *
   * By default it will generate a string based on a provided uuid namespace and
   * name, and will return a string.
   *
   * If an optional [buffer] list is provided, it will put the byte data into
   * that buffer and return a buffer.
   *
   * Optionally an [offset] can be provided with a start position in the buffer.
   *
   * The first argument is an options map that takes various configuration
   * options detailed in the readme.
   *
   * http://tools.ietf.org/html/rfc4122.html#section-4.4
   */
  v5(String namespace, String name, {Map options: null, List buffer: null, int offset: 0}) {
    var i = offset;
    options = (options != null) ? options : new Map();

    // Check if user wants a random namespace generated by v4() or a NIL namespace.
    var useRandom = (options['randomNamespace'] != null) ? options['randomNamespace'] : true;

    // If useRandom is true, generate UUIDv4, else use NIL
    var blankNS = useRandom ? v4() : NAMESPACE_NIL;

    // Use provided namespace, or use whatever is decided by options.
    namespace = (namespace != null) ? namespace : blankNS;

    // Use provided name,
    name = (name != null) ? name : '';

    // Convert namespace UUID to Byte List
    var bytes = parse(namespace);

    // Convert name to a list of bytes
    var nameBytes = new List<int>();
    for(var singleChar in name.codeUnits) {
      nameBytes.add(singleChar);
    }

    // Generate SHA1 using namespace concatenated with name
    List hashBytes = sha1.convert(new List.from(bytes)..addAll(nameBytes)).bytes;

    // per 4.4, set bits for version and clockSeq high and reserved
    hashBytes[6] = (hashBytes[6] & 0x0f) | 0x50;
    hashBytes[8] = (hashBytes[8] & 0x3f) | 0x80;

    // Copy the bytes to the buffer if one is provided.
    if (buffer != null) {
      for (var j = 0; j < 16; j++) {
        buffer[i+j] = hashBytes[j];
      }
    }

    return (buffer != null) ? buffer : unparse(hashBytes);
  }
}
