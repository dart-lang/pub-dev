import 'package:_pub_shared/dartdoc/dartdoc_page.dart';
import 'package:test/test.dart';

void main() {
  test('DartDocSidebar.parse marks images with nonce', () {
    final html = '<img src="https://example.com/image.png">';
    final sidebar = DartDocSidebar.parse(html);
    final nonce = sidebar.nonce;
    expect(nonce, hasLength(32));
    expect(
      sidebar.content,
      contains(
        'src="https://pub.dev/img/image-proxy-placeholder.png#{{$nonce:https%3A%2F%2Fexample.com%2Fimage.png}}"',
      ),
    );
  });

  test('DartDocSidebar.parse preserves double curlies', () {
    final html = '<p>Some text with {{marker}} and }} and {{.</p>';
    final sidebar = DartDocSidebar.parse(html);
    expect(sidebar.content, contains('{{marker}}'));
    expect(sidebar.content, contains('}}'));
    expect(sidebar.content, contains('{{'));
  });

  test('DartDocSidebar.parse does not mark trusted images', () {
    final html = '<img src="https://pub.dev/static/img/logo.png">';
    final sidebar = DartDocSidebar.parse(html);
    expect(
      sidebar.content,
      contains('src="https://pub.dev/static/img/logo.png"'),
    );
  });
}
