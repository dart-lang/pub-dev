import 'package:pub_semver/pub_semver.dart';
import 'package:pub_worker/src/utils.dart';
import 'package:test/test.dart';

void main() {
  test('streamToBuffer', () async {
    final s = () async* {
      yield [1, 2, 3, 4];
      yield [5, 6, 7];
      yield [8];
    }();

    final buf = await streamToBuffer(s);
    expect(buf, [1, 2, 3, 4, 5, 6, 7, 8]);
  });

  test('stripTrailingSlashes', () {
    expect(stripTrailingSlashes('test'), 'test');
    expect(stripTrailingSlashes('test/'), 'test');
    expect(stripTrailingSlashes('test//'), 'test');
  });

  test('needs newer SDK', () {
    expect(sdkMatchesConstraint(sdkVersion: null, constraint: null), true);

    expect(
      sdkMatchesConstraint(
        sdkVersion: null,
        constraint: VersionConstraint.parse('^3.0.0'),
      ),
      true,
    );

    expect(
      sdkMatchesConstraint(
        sdkVersion: Version.parse('3.0.0'),
        constraint: null,
      ),
      true,
    );

    expect(
      sdkMatchesConstraint(
        sdkVersion: Version.parse('3.0.0'),
        constraint: VersionConstraint.parse('^3.0.0'),
      ),
      true,
    );

    expect(
      sdkMatchesConstraint(
        sdkVersion: Version.parse('3.0.0'),
        constraint: VersionConstraint.parse('^2.12.0'),
      ),
      true,
    );

    expect(
      sdkMatchesConstraint(
        sdkVersion: Version.parse('3.0.0'),
        constraint: VersionConstraint.parse('^1.0.0'),
      ),
      true,
    );

    expect(
      sdkMatchesConstraint(
        sdkVersion: Version.parse('3.0.0'),
        constraint: VersionConstraint.parse('>=0.0.0 <1.0.0'),
      ),
      true,
    );

    expect(
      sdkMatchesConstraint(
        sdkVersion: Version.parse('3.0.0'),
        constraint: VersionConstraint.parse('>=0.0.0 <4.0.0'),
      ),
      true,
    );

    expect(
      sdkMatchesConstraint(
        sdkVersion: Version.parse('3.0.0'),
        constraint: VersionConstraint.any,
      ),
      true,
    );

    // requires newer SDK
    expect(
      sdkMatchesConstraint(
        sdkVersion: Version.parse('3.0.0'),
        constraint: VersionConstraint.parse('^3.0.1'),
      ),
      false,
    );
  });

  group('parseSandboxOutput', () {
    test('handles null and empty input', () {
      expect(parseSandboxOutput(null), isEmpty);
      expect(parseSandboxOutput(''), isEmpty);
    });

    test('parses legacy colon-separated paths', () {
      expect(parseSandboxOutput('/tmp/a:/tmp/b::/tmp/c'), [
        '/tmp/a',
        '/tmp/b',
        '/tmp/c',
      ]);
    });

    test('parses JSON array of paths including paths with colons', () {
      expect(
        parseSandboxOutput(
          r'["/tmp/a","/tmp/with:colon","C:\\Users\\test\\out"]',
        ),
        ['/tmp/a', '/tmp/with:colon', r'C:\Users\test\out'],
      );
    });

    test('throws FormatException on invalid JSON or non-string list', () {
      expect(() => parseSandboxOutput('[invalid'), throwsFormatException);
      expect(() => parseSandboxOutput('[123]'), throwsFormatException);
    });
  });
}
