// Copyright (c) 2026, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:pub_dev_image_proxy/prohibited_addresses.dart';
import 'package:test/test.dart';

void main() {
  group('CidrBlock', () {
    test('parses and matches IPv4 blocks', () {
      final block = CidrBlock.parse('172.16.0.0/12');
      expect(block.contains(InternetAddress('172.16.0.0')), isTrue);
      expect(block.contains(InternetAddress('172.16.0.1')), isTrue);
      expect(block.contains(InternetAddress('172.31.255.255')), isTrue);
      expect(block.contains(InternetAddress('172.15.255.255')), isFalse);
      expect(block.contains(InternetAddress('172.32.0.0')), isFalse);
    });

    test('parses and matches IPv6 blocks', () {
      final block = CidrBlock.parse('fc00::/7');
      expect(block.contains(InternetAddress('fc00::1')), isTrue);
      expect(
        block.contains(
          InternetAddress('fdff:ffff:ffff:ffff:ffff:ffff:ffff:ffff'),
        ),
        isTrue,
      );
      expect(block.contains(InternetAddress('fbff::')), isFalse);
      expect(block.contains(InternetAddress('fe00::')), isFalse);
    });

    test('family mismatch returns false', () {
      final ipv4Block = CidrBlock.parse('10.0.0.0/8');
      expect(ipv4Block.contains(InternetAddress('::1')), isFalse);

      final ipv6Block = CidrBlock.parse('fc00::/7');
      expect(ipv6Block.contains(InternetAddress('10.0.0.1')), isFalse);
    });

    test('throws on invalid CIDR strings and prefix lengths', () {
      expect(() => CidrBlock.parse('10.0.0.0'), throwsFormatException);
      expect(() => CidrBlock.parse('10.0.0.0/abc'), throwsFormatException);
      expect(() => CidrBlock.parse('not.an.ip/8'), throwsFormatException);
      expect(
        () => CidrBlock(InternetAddress('10.0.0.0'), -1),
        throwsArgumentError,
      );
      expect(
        () => CidrBlock(InternetAddress('10.0.0.0'), 33),
        throwsArgumentError,
      );
      expect(() => CidrBlock(InternetAddress('::1'), 129), throwsArgumentError);
    });
  });

  group('isProhibitedAddress', () {
    test('returns false for public IP addresses', () {
      expect(isProhibitedAddress(InternetAddress('8.8.8.8')), isFalse);
      expect(isProhibitedAddress(InternetAddress('1.1.1.1')), isFalse);
      expect(isProhibitedAddress(InternetAddress('142.250.190.46')), isFalse);
      expect(
        isProhibitedAddress(InternetAddress('2001:4860:4860::8888')),
        isFalse,
      );
    });

    test('returns true for RFC 1918 private IPv4 addresses', () {
      expect(isProhibitedAddress(InternetAddress('10.0.0.1')), isTrue);
      expect(isProhibitedAddress(InternetAddress('10.255.255.255')), isTrue);
      expect(isProhibitedAddress(InternetAddress('172.16.0.1')), isTrue);
      expect(isProhibitedAddress(InternetAddress('172.31.255.254')), isTrue);
      expect(isProhibitedAddress(InternetAddress('192.168.0.1')), isTrue);
      expect(isProhibitedAddress(InternetAddress('192.168.255.255')), isTrue);
    });

    test('returns true for link-local and cloud metadata addresses', () {
      expect(isProhibitedAddress(InternetAddress('169.254.169.254')), isTrue);
      expect(isProhibitedAddress(InternetAddress('169.254.0.1')), isTrue);
      expect(isProhibitedAddress(InternetAddress('fe80::1')), isTrue);
    });

    test('returns true for loopback addresses', () {
      expect(isProhibitedAddress(InternetAddress('127.0.0.1')), isTrue);
      expect(isProhibitedAddress(InternetAddress('127.255.255.254')), isTrue);
      expect(isProhibitedAddress(InternetAddress('::1')), isTrue);
    });

    test('returns true for carrier-grade NAT / RFC 6598 addresses', () {
      expect(isProhibitedAddress(InternetAddress('100.64.0.1')), isTrue);
      expect(isProhibitedAddress(InternetAddress('100.127.255.255')), isTrue);
      expect(isProhibitedAddress(InternetAddress('100.63.255.255')), isFalse);
      expect(isProhibitedAddress(InternetAddress('100.128.0.0')), isFalse);
    });

    test('returns true for RFC 4193 unique local IPv6 addresses', () {
      expect(isProhibitedAddress(InternetAddress('fc00::1')), isTrue);
      expect(isProhibitedAddress(InternetAddress('fd00::1')), isTrue);
    });
  });
}
