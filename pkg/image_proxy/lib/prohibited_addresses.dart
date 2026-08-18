// Copyright (c) 2026, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

/// Represents an IPv4 or IPv6 Classless Inter-Domain Routing (CIDR) address block
/// (for example, `'10.0.0.0/8'` or `'fc00::/7'`).
///
/// Performance:
/// - [CidrBlock.parse] runs in \(O(B)\) time where \(B\) is the length of the string.
/// - [contains] runs in \(O(N)\) time where \(N\) is the number of bytes in the IP address (4 for IPv4, 16 for IPv6).
final class CidrBlock {
  /// The base network address of this CIDR block.
  final InternetAddress baseAddress;

  /// The prefix length (number of network mask bits) for this CIDR block.
  final int prefixLength;

  /// Creates a [CidrBlock] with [baseAddress] and [prefixLength].
  ///
  /// Preconditions:
  /// - [prefixLength] must be non-negative.
  /// - [prefixLength] must not exceed 32 for IPv4 addresses or 128 for IPv6 addresses.
  ///
  /// Throws [ArgumentError] if [prefixLength] is negative or exceeds the maximum
  /// number of address bits.
  CidrBlock(this.baseAddress, this.prefixLength) {
    if (prefixLength < 0) {
      throw ArgumentError.value(
        prefixLength,
        'prefixLength',
        'Must be non-negative',
      );
    }
    final maxBits = baseAddress.type == InternetAddressType.IPv4 ? 32 : 128;
    if (prefixLength > maxBits) {
      throw ArgumentError.value(
        prefixLength,
        'prefixLength',
        'Exceeds maximum bits ($maxBits for ${baseAddress.type.name})',
      );
    }
  }

  /// Parses a CIDR string in the format `<ip_address>/<prefix_length>`
  /// (for example, `'10.0.0.0/8'` or `'fc00::/7'`).
  ///
  /// Preconditions:
  /// - [cidr] must contain exactly one `/` separating a valid IP address and an integer prefix length.
  ///
  /// Throws [FormatException] or [ArgumentError] if [cidr] is malformed or if
  /// the prefix length is out of range for the address type.
  factory CidrBlock.parse(String cidr) {
    final parts = cidr.split('/');
    if (parts.length != 2) {
      throw FormatException(
        'Invalid CIDR format (expected <ip>/<prefix_length>): $cidr',
      );
    }
    final InternetAddress address;
    try {
      address = InternetAddress(parts[0]);
    } on ArgumentError {
      throw FormatException('Invalid IP address in CIDR: ${parts[0]}');
    }
    final prefixLength = int.tryParse(parts[1]);
    if (prefixLength == null) {
      throw FormatException('Invalid integer prefix length in CIDR: $cidr');
    }
    return CidrBlock(address, prefixLength);
  }

  /// Checks whether [address] is contained within this CIDR block.
  ///
  /// Preconditions:
  /// - [address] must not be `null`.
  ///
  /// Returns `true` if [address] is of the same address family as [baseAddress]
  /// and its leading [prefixLength] bits match [baseAddress].
  bool contains(InternetAddress address) {
    if (address.type != baseAddress.type) {
      return false;
    }
    final rawBase = baseAddress.rawAddress;
    final rawTarget = address.rawAddress;
    var bitsLeft = prefixLength;
    for (var i = 0; i < rawBase.length && bitsLeft > 0; i++) {
      final mask = bitsLeft >= 8 ? 0xff : (0xff << (8 - bitsLeft)) & 0xff;
      if ((rawBase[i] & mask) != (rawTarget[i] & mask)) {
        return false;
      }
      bitsLeft -= 8;
    }
    return true;
  }

  @override
  String toString() => '${baseAddress.address}/$prefixLength';
}

/// The list of prohibited IP address blocks that must not be proxied to prevent
/// Server-Side Request Forgery (SSRF).
final List<CidrBlock> prohibitedCidrBlocks = [
  // RFC 1122 Current network (0.0.0.0/8)
  CidrBlock.parse('0.0.0.0/8'),
  // RFC 1918 Private IPv4 networks
  CidrBlock.parse('10.0.0.0/8'),
  CidrBlock.parse('172.16.0.0/12'),
  CidrBlock.parse('192.168.0.0/16'),
  // RFC 1122 Loopback IPv4
  CidrBlock.parse('127.0.0.0/8'),
  // RFC 3927 Link-local IPv4 (includes cloud metadata servers such as 169.254.169.254)
  CidrBlock.parse('169.254.0.0/16'),
  // RFC 6598 Carrier-grade NAT / shared address space
  CidrBlock.parse('100.64.0.0/10'),
  // RFC 4193 Unique local IPv6 addresses
  CidrBlock.parse('fc00::/7'),
  // RFC 3513 Site-local IPv6 addresses (deprecated)
  CidrBlock.parse('fec0::/10'),
  // Loopback IPv6
  CidrBlock.parse('::1/128'),
];

/// Checks whether [address] belongs to a private, loopback, link-local, multicast,
/// or reserved network address range.
///
/// Preconditions:
/// - [address] must not be `null`.
///
/// Checks:
/// - [InternetAddress.isLoopback]
/// - [InternetAddress.isLinkLocal]
/// - [InternetAddress.isMulticast]
/// - Inclusion in any of [prohibitedCidrBlocks]
///
/// Performance:
/// - Runs in \(O(K \cdot N)\) time where \(K\) is the number of [prohibitedCidrBlocks]
///   and \(N\) is the byte length of [address].
///
/// Returns `true` if [address] is within a prohibited network range.
bool isProhibitedAddress(InternetAddress address) {
  if (address.isLoopback || address.isLinkLocal || address.isMulticast) {
    return true;
  }
  for (final block in prohibitedCidrBlocks) {
    if (block.contains(address)) {
      return true;
    }
  }
  return false;
}
