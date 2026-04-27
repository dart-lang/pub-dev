# Unzip

A ZIP archive reader for Dart with no runtime dependencies.

## Features

-   Stream-based reading of ZIP archives.
-   Support for Deflate and Store compression methods.
-   No external dependencies (uses `dart:io` for decompression).
-   Supports both file-based and memory-based reading via `RandomAccessReader` interface.

## Usage

See [example/example.dart](example/example.dart) for a complete example.

```dart
import 'dart:io';
import 'package:unzip/unzip.dart';

void main() async {
  final zipReader = await ZipReader.open('archive.zip');
 
   for (final f in zipReader.files) {
     print(f.header.name);
     final stream = f.open();
     await for (final chunk in stream) {
       stdout.add(chunk);
     }
   }
   await zipReader.close();
}
```

## Attribution

This package is an adaptation of the Go standard library's `archive/zip` package.
Copyright (c) 2009 The Go Authors. All rights reserved.
See the [LICENSE](LICENSE) file for the full license text.
