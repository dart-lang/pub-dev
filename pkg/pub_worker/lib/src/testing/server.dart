/// A test server for pub_worker.
library;

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:_pub_shared/data/package_api.dart';
import 'package:_pub_shared/data/task_api.dart';
import 'package:async/async.dart';
import 'package:collection/collection.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:indexed_blob/indexed_blob.dart';
import 'package:mime/mime.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:pubspec_parse/pubspec_parse.dart';
import 'package:retry/retry.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_router/shelf_router.dart';
import 'package:tar/tar.dart';
import 'package:yaml/yaml.dart';

part 'server.g.dart';

class PubWorkerTestServer {
  final List<Package> packages;
  final String? _fallbackPubHostedUrl;
  final _uploadedResults = <String, Uint8List>{};
  final _finished = <String, Completer<void>>{};
  var started = false;
  Uri? _baseUrl;
  HttpServer? _server;
  final _client = http.Client();

  Uri get baseUrl {
    final u = _baseUrl;
    if (u == null) {
      throw StateError('Server must be running!');
    }
    return u;
  }

  /// Create a pub.dev test server that emulates everything needed for
  /// `pub_worker` to do analysis.
  ///
  /// Packages not specified in [packages] are proxied from
  /// [fallbackPubHostedUrl] if specified.
  PubWorkerTestServer(this.packages, {String? fallbackPubHostedUrl})
      : _fallbackPubHostedUrl = fallbackPubHostedUrl;

  /// Start the server, returns when the server has started.
  Future<void> start() async {
    if (started) {
      throw StateError('Server have already been started');
    }
    started = true;

    final server = await io.serve(_router.call, 'localhost', 0);
    _baseUrl = Uri.parse('http://localhost:${server.port}');
    _server = server;
  }

  /// Stop the server, returns when the server has stopped.
  ///
  /// Servers cannot be restarted! Created a new instance if you need to do so.
  Future<void> stop() async {
    final server = _server;
    if (server == null) {
      return;
    }

    await server.close(force: true);
    _server = null;
    _baseUrl = null;

    _client.close();
  }

  Router get _router => _$PubWorkerTestServerRouter(this);

  Future<BlobIndexPair> waitForResult(String package, String version) async {
    await _finished
        .putIfAbsent('$package/$version', () => Completer<void>())
        .future;

    final index = _uploadedResults['$package/$version/index.json'];
    final blob = _uploadedResults['$package/$version/files.blob'];
    if (index == null) {
      throw Exception('index.json was not uploaded for $package/$version');
    }
    if (blob == null) {
      throw Exception('index.json was not uploaded for $package/$version');
    }

    return BlobIndexPair(blob, BlobIndex.fromBytes(index));
  }

  @Route.get('/api/packages/<package>')
  Future<Response> _listPackageVersions(
    Request request,
    String package,
  ) async {
    final pkgs = packages.where((p) => p.name == package).toList();
    if (pkgs.isEmpty) {
      if (_fallbackPubHostedUrl != null) {
        return await retry(() async {
          final u = Uri.parse('$_fallbackPubHostedUrl/api/packages/$package');
          final res = await _client.get(u);
          if (res.statusCode == 404) {
            return Response.notFound('no such package: "$package"');
          }
          if (res.statusCode == 200) {
            // We don't rewrite the archive_url, that way we won't have to
            // handle proxying of the archives.
            return Response.ok(res.bodyBytes, headers: {
              'Content-Type': 'application/json',
            });
          }
          throw Exception('status: ${res.statusCode} from "$u"');
        }, retryIf: (e) => true).catchError(
          (_) => Response.notFound('no such package: "$package"'),
        );
      }
      return Response.notFound('no such package: "$package"');
    }
    return Response.ok(
        json.encode({
          'name': package,
          'latest': null,
          'versions': pkgs
              .map((p) => {
                    'version': '${p.version}',
                    'pubspec': p.pubspecJson,
                    'archive_url':
                        '$baseUrl/api/packages/$package/versions/${p.version}.tar.gz',
                  })
              .toList()
        }),
        headers: {'Content-Type': 'application/json'});
  }

  @Route.get('/api/packages/<package>/versions/<version>.tar.gz')
  Future<Response> _downloadPackage(
    Request request,
    String package,
    String version,
  ) async {
    final v = Version.parse(version);
    final p = packages.firstWhereOrNull(
      (p) => p.name == package && p.version == v,
    );

    if (p == null) {
      // We don't rewrite the archive_url when proxying version listing from
      // _fallbackPubHostedUrl, so we don't need to proxy archives.
      return Response.notFound('no package "$package" version "$version"');
    }
    return Response.ok(
      p.archive,
      headers: {'Content-Type': 'application/octet'},
    );
  }

  @Route.post('/api/tasks/<package>/<version>/upload')
  Future<Response> _taskUploadUrls(
    Request request,
    String package,
    String version,
  ) async {
    if (!(request.headers['User-Agent'] ?? '').contains('pub_worker')) {
      return Response.badRequest(body: 'User-Agent must say pub_worker');
    }
    return Response.ok(json.encode(UploadTaskResultResponse(
      blobId: 'files.blob',
      blob: UploadInfo(
        url: '$baseUrl/upload-result/$package/$version/files.blob',
        fields: {},
      ),
      index: UploadInfo(
        url: '$baseUrl/upload-result/$package/$version/index.json',
        fields: {},
      ),
    )));
  }

  @Route.post('/api/tasks/<package>/<version>/finished')
  Future<Response> _reportTaskFinished(
    Request request,
    String package,
    String version,
  ) async {
    _finished
        .putIfAbsent('$package/$version', () => Completer<void>())
        .complete();
    return Response.ok('{}');
  }

  @Route.post('/upload-result/<package>/<version>/<name>')
  Future<Response> _uploadResult(
    Request request,
    String package,
    String version,
    String name,
  ) async {
    if (request.mimeType != 'multipart/form-data') {
      return Response.forbidden('request must be multipart');
    }
    await for (final part in _readMultiparts(request)) {
      final contentDisposition = part.headers['content-disposition'] ?? '';
      final field = contentDisposition
          .split(';')
          .map((s) => s.trim())
          .where((s) => s.startsWith('name='))
          .first
          .replaceFirst('name="', '')
          .replaceAll('"', '');
      if (field == 'file') {
        _uploadedResults['$package/$version/$name'] = await collectBytes(part);
      } else {
        await part.drain();
      }
    }
    return Response.ok('{}');
  }
}

class Package {
  final Pubspec pubspec;
  final Map<String, dynamic> pubspecJson;
  final Uint8List archive;

  String get name => pubspec.name;
  Version get version => pubspec.version!;

  Package._(this.pubspec, this.pubspecJson, this.archive);

  static Future<Package> fromGzippedArchive(Uint8List archive) async {
    final tar = TarReader(Stream.value(gzip.decode(archive)));
    while (await tar.moveNext()) {
      if (tar.current.name == 'pubspec.yaml') {
        final yaml = utf8.decode(await collectBytes(tar.current.contents));
        final pubspecJson = json.decode(json.encode(loadYaml(yaml)));
        if (pubspecJson is! Map<String, dynamic>) {
          throw FormatException('pubspec.yaml must be a map');
        }
        final spec = Pubspec.parse(yaml, lenient: true);
        if (spec.version == null) {
          throw FormatException('pubspec.yaml must contain a "version"');
        }
        return Package._(spec, pubspecJson, archive);
      }
    }
    throw FormatException('Could not find pubspec.yaml in archive');
  }

  static Future<Package> fromFiles(Iterable<FileEntry> files) async {
    return await fromGzippedArchive(await collectBytes(
      Stream<TarEntry>.fromIterable(files.map(
        (f) => TarEntry.data(
          TarHeader(
            name: f.name,
            mode: 420, // 644₈
          ),
          f.bytes,
        ),
      )).transform(tarWriter).transform(gzip.encoder),
    ));
  }
}

class FileEntry {
  final String name;
  final List<int> bytes;

  FileEntry.fromBytes({required this.name, required this.bytes});
  FileEntry.fromString({required this.name, required String contents})
      : bytes = utf8.encode(contents);
  FileEntry.fromJson({required this.name, required Object data})
      : bytes = json.fuse(utf8).encode(data);
}

/// Auxiliary function to read multipart requests to shelf.
Stream<MimeMultipart> _readMultiparts(Request request) {
  String? boundary;
  try {
    final c = MediaType.parse(
      request.headers[HttpHeaders.contentTypeHeader] ?? '',
    );
    if (c.type == 'multipart') {
      boundary = c.parameters['boundary'];
    }
  } on FormatException {
    // pass
  }
  if (boundary == null) {
    throw StateError('request must be multipart');
  }
  return MimeMultipartTransformer(boundary).bind(request.read());
}
