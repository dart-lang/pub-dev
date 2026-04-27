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

## Limitations

This package is a minimal implementation of the ZIP specification and does not support all features:

-   **Read-Only**: It does not support creating or modifying ZIP archives.
-   **Encryption**: Password-protected ZIP files are not supported.
-   **Compression Methods**: Only **Store** (0) and **Deflate** (8) are supported.
-   **Multi-disk Archives**: Split or spanned archives are not supported.
-   **Zip64 Support**: Basic support for reading Zip64 locators and headers is implemented, but full compliance with all Zip64 edge cases is not guaranteed.

## Attribution

This package is an adaptation of the Go standard library's `archive/zip` package.
Copyright (c) 2009 The Go Authors. All rights reserved.
See the [LICENSE](LICENSE) file for the full license text.
