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
    expect(
      needsNewerSdk(sdkVersion: null, constraint: null),
      false,
    );

    expect(
      needsNewerSdk(
          sdkVersion: null, constraint: VersionConstraint.parse('^3.0.0')),
      false,
    );

    expect(
      needsNewerSdk(sdkVersion: Version.parse('3.0.0'), constraint: null),
      false,
    );

    expect(
      needsNewerSdk(
          sdkVersion: Version.parse('3.0.0'),
          constraint: VersionConstraint.parse('^3.0.0')),
      false,
    );

    expect(
      needsNewerSdk(
          sdkVersion: Version.parse('3.0.0'),
          constraint: VersionConstraint.parse('^3.0.1')),
      true,
    );
  });
}
