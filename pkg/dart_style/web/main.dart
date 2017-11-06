import 'dart:html';

import 'package:dart_style/dart_style.dart';

TextAreaElement before;
TextAreaElement after;

int width = 80;

PreElement columnMarker = querySelector(".column-marker");
InputElement widthInput = querySelector("#width");
OutputElement widthOutput = querySelector("#width-output");

void main() {
  before = querySelector("#before") as TextAreaElement;
  after = querySelector("#after") as TextAreaElement;

  before.onKeyUp.listen((event) {
    reformat();

    window.localStorage["code"] = before.value;
  });

  var code = window.localStorage["code"];
  if (code != null) before.text = code;

  if (window.localStorage.containsKey("width")) {
    setWidth(window.localStorage["width"]);
  }

  widthInput.onInput.listen((event) {
    setWidth(widthInput.value);
    window.localStorage["width"] = widthInput.value;
  });

  reformat();
}

void reformat() {
  var source = before.value;

  try {
    after.value = new DartFormatter(pageWidth: width).format(source);
    return;
  } on FormatterException {
    // Do nothing.
  }

  // Maybe it's a statement.
  try {
    after.value = new DartFormatter(pageWidth: width).formatStatement(source);
  } on FormatterException catch (err) {
    after.value = "Format failed:\n$err";
  }
}

void setWidth(String widthString) {
  width = int.parse(widthString);

  widthInput.value = widthString;
  widthOutput.value = widthString;

  var pad = " " * width + "|";
  columnMarker.innerHtml = "$pad $width columns" + "\n$pad" * 29;
  reformat();
}
