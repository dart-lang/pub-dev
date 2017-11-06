v0.5.3
- Merged pull request to support crypto 2.0.0
- Support convert 2.0.0

v0.5.2
- Merged pull request to upgrade crypto library to 1.0.0.

v0.5.1
- Merged pull request for various updates and cleanup.

v0.5.0
- Reverted back to custom AES implementation. Moved RNG methods to UuidUtil (import 'package:uuid/uuid_util.dart')
- Fixed a potential bug with custom RNG method passing and added more ways to pass in custom RNG functions.
- Cleaned up and refactored some stuff. Using only v1 is only 67kb of js, Using only v4 is 97kb. Using crypt v4 is 118kb. Using both v1 and non-crypto v4 is 126kb.
- Default RNG for v4 is now the mathRNG function. If you wish to use cryptoRNG, import UuidUtil and pass in cryptoRNG.
- Updated README.md with more examples and usages.
- Updated Tests.

v0.4.1
- Changed initCipher location so that if you ever only use v1 UUIDs, you will get a very small Dart2JS output compared to v4 or v5 that do load it.

v0.4.0
- Use Cipher base.dart, as I don't need entropy generators, and this allows me to merge client/server together again
  and fix many issues this caused.

v0.3.2
- Fix import/library bug.

v0.3.1
- Update pubspec to allow installation of the latest Cipher 0.7.

v0.3.0
- Updated to latest Cipher at 0.6.0. This created a breaking change in the imports. Please make sure you update your code.
- Fixed problem when creating v4 UUIDs too fast, it would create duplicate UUIDs.

v0.2.2
- Pegging cipher to 0.4.0 temporarily for browser support

v0.2.1
- Using new version of cipher.

v0.2.0
- Dart 1.0 Readiness
- Switched from custom AES to [cipher](https://github.com/izaera/cipher) package AES.

v0.1.6
- Adjusting usage of constants.
- Fixing tests.

v0.1.5
- Stupid typo on import.

v0.1.4
- Fixing Crypto package move.

v0.1.3
- Fixing language changes.

v0.1.2
- Fix change of charCodes to codeUnits

v0.1.1
- Fixing syntax for upcoming breaking changes.

v0.1.0
- Cleanup, changes, and prep for M3.

v0.0.9
- Minor fix with a const RegExp
- Made sure everything builds on latest dart.
- Fixed pubspec to now import unittest from pub instead of sdk.

v0.0.8
- Changed to the new optional paramater syntaxes and usages.
- Adjusted tests for the new function call style due to parameter change.
- Fixed Import/Source/Library statements to the new format.

v0.0.7
- Made changes requested by the Google team to get my package up on pub.dartlang.org

v0.0.6
- Fixed up some code to make it possibly faster and using better Dart practices.
- Cleaned up some documentation.

v0.0.5
- Added Initial AES for Dart (untested if it actually works/matches other AES encryptors)
- Use AES cipher to create crypto strong bytes.

v0.0.4
- Issue wasn't Math.Random() but a bad reseed by me.
- Cleaned up for new Pub layout.

v0.0.3
- Added UUIDv5
- Fixed UUIDv4 bugs
- Added more unit tests
- Found bug in dart's Math.Random(), reported, waiting for fix to fix my code.

v0.0.2
- Initial tests
- Fixed some parser bugs.

v0.0.1
- Initial Release
- No tests
