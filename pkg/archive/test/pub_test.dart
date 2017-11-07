part of archive_test;

void extract7z(List urls) {
  io.File script = new io.File(io.Platform.script.toFilePath());
  String path = script.parent.path;

  for (String url in urls) {
    String filename = url.split('/').last;
    String inputPath = '$path\\out\\$filename';

    String outputPath = path + '\\out\\' + filename + '.7z';
    print('$inputPath : $outputPath');

    io.Directory outDir = new io.Directory(outputPath);
    if (!outDir.existsSync()) {
      outDir.createSync(recursive: true);
    }

    print('EXTRACTING $inputPath');
    io.Process.runSync('7z', ['x', '-o${outputPath}',
    '$inputPath']);

    String tar_filename = filename.substring(0, filename.lastIndexOf('.'));
    String tar_path = '$outputPath\\$tar_filename';
    if (!new io.File(tar_path).existsSync()) {
      tar_path = '$outputPath\\intermediate.tar';
    }
    print('TAR $tar_path');

    io.Process.runSync('7z', ['x', '-y', '-o${outputPath}', '$tar_path']);

    new io.File(tar_path).deleteSync();
  }
}

downloadUrls(io.HttpClient client, List urls) async {
  io.File script = new io.File(io.Platform.script.toFilePath());
  String path = script.parent.path;

  List downloads = [];
  for (String url in urls) {
    print(url);

    String filename = url.split('/').last;

    var download = new io.HttpClient().getUrl(Uri.parse(url))
        .then((io.HttpClientRequest request) => request.close())
        .then((io.HttpClientResponse response) =>
        response.pipe(new io.File(path + '/out/' + filename).openWrite()));

    downloads.add(download);
  }

  for (var download in downloads) {
    await download;
  }
}

void extractDart(List urls) {
  io.File script = new io.File(io.Platform.script.toFilePath());
  String path = script.parent.path;

  for (String url in urls) {
    String filename = url.split('/').last;
    String inputPath = '$path\\out\\$filename';

    String outputPath = path + '\\out\\' + filename + '.out';
    print('$inputPath : $outputPath');

    print('EXTRACTING $inputPath');

    io.File fp = new io.File(path + '/out/' + filename);
    List<int> data = fp.readAsBytesSync();

    TarDecoder tarArchive = new TarDecoder();
    tarArchive.decodeBytes(new GZipDecoder().decodeBytes(data));

    print('EXTRACTING $filename');

    io.Directory outDir = new io.Directory(outputPath);
    if (!outDir.existsSync()) {
      outDir.createSync(recursive: true);
    }

    for (TarFile file in tarArchive.files) {
      if (!file.isFile) {
        continue;
      }
      String filename = file.filename;
      try {
        io.File f = new io.File(
            '${outputPath}${io.Platform.pathSeparator}${filename}');
        f.parent.createSync(recursive: true);
        f.writeAsBytesSync(file.content);
      } catch (e) {
      }
    }
  }
}

void compareDirs(List urls) {
  io.File script = new io.File(io.Platform.script.toFilePath());
  String path = script.parent.path;

  for (String url in urls) {
    String filename = url.split('/').last;
    String outPath7z = '$path\\out\\${filename}.7z';
    String outPathDart = '$path\\out\\${filename}.out';
    print('$outPathDart : $outPath7z');

    List files7z = [];
    ListDir(files7z, new io.Directory(outPath7z));
    List filesDart = [];
    ListDir(filesDart, new io.Directory(outPathDart));

    expect(filesDart.length, files7z.length);
    //print("#${filesDart.length} : ${files7z.length}");

    for (int i = 0; i < filesDart.length; ++i) {
      io.File fd = filesDart[i];
      io.File f7z = files7z[i];

      List bytes_dart = fd.readAsBytesSync();
      List bytes_7z = f7z.readAsBytesSync();

      expect(bytes_dart.length, bytes_7z.length);

      for (int j = 0; j < bytes_dart.length; ++j) {
        expect(bytes_dart[j], bytes_7z[j]);
      }
    }
  }
}

void definePubTests() {
  group('pub archives', () {
    io.HttpClient client;

    setUpAll(() {
      client = new io.HttpClient();
    });

    tearDownAll(() {
      client.close(force: true);
    });

    test('PUB ARCHIVES', () async {
      io.File script = new io.File(io.Platform.script.toFilePath());
      String path = script.parent.path;
      io.File fp = new io.File(path + '/res/tarurls.txt');
      List urls = fp.readAsLinesSync();

      await downloadUrls(client, urls);
      extractDart(urls);
      // TODO need a generic system level tar exe to work with the
      // travis CI system.
      //extract7z(urls);
      //compareDirs(urls);
    });
  });
}
