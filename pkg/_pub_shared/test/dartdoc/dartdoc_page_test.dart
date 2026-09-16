import 'package:_pub_shared/dartdoc/dartdoc_page.dart';
import 'package:test/test.dart';

void main() {
  test('DartDocSidebar.parse marks images with imageProxyNonce', () {
    final html = '<img src="https://example.com/image.png">';
    final sidebar = DartDocSidebar.parse(html);
    final imageProxyNonce = sidebar.imageProxyNonce;
    expect(imageProxyNonce, hasLength(32));
    expect(
      sidebar.content,
      contains(
        'src="$imageProxyMarkerPrefix'
        '{$imageProxyNonce}:{https%3A%2F%2Fexample.com%2Fimage.png}"',
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

  test('DartDocSidebar.parse does not activate content from comments', () {
    final html =
        '<!-- --$imageProxyMarkerPrefix>'
        '<span class="hidden">comment</span><p> -->';
    final sidebar = DartDocSidebar.parse(html);
    expect(sidebar.content, isNot(contains('hidden')));
  });

  test('DartDocSidebar.parse strips comments', () {
    final sidebar = DartDocSidebar.parse('<p>a</p><!-- secret --><p>b</p>');
    expect(sidebar.content, '<p>a</p><p>b</p>');
  });
}
