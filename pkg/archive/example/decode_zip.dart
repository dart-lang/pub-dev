import 'dart:html' as Html;
import 'package:archive/archive.dart' as Arc;
import 'dart:convert';

/**
 * Decode a zip file, extract a jpeg image file from it, and replace the
 * image on the html page with the image from the zip file.
 */
void main() {
  Html.ImageElement img = Html.querySelector('#trees');
  String path = img.src;
  path = path.substring(0, path.lastIndexOf('/'));

  // Get the zip file from the same directory the image is in.
  var req = new Html.HttpRequest();
  req.open('GET', path + '/test.zip');
  req.overrideMimeType('text\/plain; charset=x-user-defined');
  req.onLoadEnd.listen((e) {
    if (req.status == 200) {
      // Convert the responseText to binary.
      var bytes = req.responseText.split('').map((e){
        return new String.fromCharCode(e.codeUnitAt(0) & 0xff);
       }).join('').codeUnits;

      // Decode the zip file.
      Arc.Archive archive = new Arc.ZipDecoder().decodeBytes(bytes);

      // Extract the cat.jpg file from the zip.
      var jpg = archive.findFile('cat.jpg').content;

      // Replace the html image content with the image we just extracted.
      var jpg64 = BASE64.encode(jpg);
      img.src = 'data:image/jpeg;base64,${jpg64}';
    }
  });
  req.send('');
}
