// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library code_transformers.src.dart_sdk;

import 'dart:io' show Directory;

import 'package:analyzer/file_system/file_system.dart';
import 'package:analyzer/src/context/context.dart';
import 'package:analyzer/src/dart/sdk/sdk.dart';
import 'package:analyzer/src/generated/engine.dart';
import 'package:analyzer/src/generated/sdk.dart';
import 'package:analyzer/src/generated/source.dart';
import 'package:analyzer/src/summary/idl.dart';
import 'package:cli_util/cli_util.dart' as cli_util;

/// Attempts to provide the current Dart SDK directory.
///
/// This will return null if the SDK cannot be found
///
/// Note that this may not be correct when executing outside of `pub`.
String get dartSdkDirectory {
  Directory sdkDir = cli_util.getSdkDir();
  return sdkDir != null ? sdkDir.path : null;
}

/// Sources that are annotated with a source uri, so it is easy to resolve how
/// to support `Resolver.getImportUri`.
abstract class UriAnnotatedSource extends Source {
  Uri get uri;
}

/// Dart SDK which wraps all Dart sources as [UriAnnotatedSource] to ensure they
/// are tracked with Uris.
class FolderBasedDartSdkProxy extends FolderBasedDartSdk {
  FolderBasedDartSdkProxy(
      ResourceProvider resourceProvider, String sdkDirectory)
      : super(resourceProvider, resourceProvider.getFolder(sdkDirectory));

  Source mapDartUri(String dartUri) =>
      DartSourceProxy.wrap(super.mapDartUri(dartUri), Uri.parse(dartUri));
}

/// Dart SDK resolver which wraps all Dart sources to ensure they are tracked
/// with URIs.
class DartUriResolverProxy implements DartUriResolver {
  final DartUriResolver _proxy;
  DartUriResolverProxy(DartSdk sdk) : _proxy = new DartUriResolver(sdk);

  Source resolveAbsolute(Uri uri, [Uri actualUri]) =>
      DartSourceProxy.wrap(_proxy.resolveAbsolute(uri, actualUri), uri);

  DartSdk get dartSdk => _proxy.dartSdk;

  Source fromEncoding(UriKind kind, Uri uri) =>
      throw new UnsupportedError('fromEncoding is not supported');

  Uri restoreAbsolute(Source source) =>
      throw new UnsupportedError('restoreAbsolute is not supported');
}

/// Source file for dart: sources which track the sources with dart: URIs.
///
/// This is primarily to support [Resolver.getImportUri] for Dart SDK (dart:)
/// based libraries.
class DartSourceProxy implements UriAnnotatedSource {
  /// Absolute URI which this source can be imported from
  final Uri uri;

  /// Underlying source object.
  final Source _proxy;

  Source get source => this;

  DartSourceProxy(this._proxy, this.uri);

  /// Ensures that [source] is a DartSourceProxy.
  static DartSourceProxy wrap(Source source, Uri uri) {
    if (source == null || source is DartSourceProxy) return source;
    return new DartSourceProxy(source, uri);
  }

  // Note: to support both analyzer versions <0.22.0 and analyzer >=0.22.0, we
  // implement both `resolveRelative` and `resolveRelativeUri`. Only one of them
  // is available at a time in the analyzer package, so we use the `as dynamic`
  // in these methods to hide warnings for the code that is missing. These APIs
  // are invoked from the analyzer itself, so we don't expect them to cause
  // failures.
  Source resolveRelative(Uri relativeUri) {
    // Assume that the type can be accessed via this URI, since these
    // should only be parts for dart core files.
    return wrap((_proxy as dynamic).resolveRelative(relativeUri), uri);
  }

  Uri resolveRelativeUri(Uri relativeUri) {
    return (_proxy as dynamic).resolveRelativeUri(relativeUri);
  }

  bool exists() => _proxy.exists();

  bool operator ==(Object other) =>
      (other is DartSourceProxy && _proxy == other._proxy);

  int get hashCode => _proxy.hashCode;

  TimestampedData<String> get contents => _proxy.contents;

  String get encoding => _proxy.encoding;

  String get fullName => _proxy.fullName;

  Source get librarySource => _proxy.librarySource;

  int get modificationStamp => _proxy.modificationStamp;

  String get shortName => _proxy.shortName;

  UriKind get uriKind => _proxy.uriKind;

  bool get isInSystemLibrary => _proxy.isInSystemLibrary;
}

/// Dart SDK which contains a mock implementation of the SDK libraries. May be
/// used to speed up resultion when most of the core libraries is not needed.
class MockDartSdk implements DartSdk {
  final Map<Uri, _MockSdkSource> _sources = {};
  final bool reportMissing;
  final Map<String, SdkLibrary> _libs = {};
  final String sdkVersion = '0';
  List<String> get uris => _sources.keys.map((uri) => '$uri').toList();
  final InternalAnalysisContext context;
  DartUriResolver _resolver;
  DartUriResolver get resolver => _resolver;

  MockDartSdk(Map<String, String> sources, AnalysisOptions options,
      {this.reportMissing})
      : this.context = new SdkAnalysisContext(options) {
    sources.forEach((uriString, contents) {
      var uri = Uri.parse(uriString);
      _sources[uri] = new _MockSdkSource(uri, contents);
      _libs[uriString] = new SdkLibraryImpl(uri.path)
        ..setDart2JsLibrary()
        ..setVmLibrary();
    });
    _resolver = new DartUriResolver(this);
    context.sourceFactory = new SourceFactory([_resolver]);
  }

  List<SdkLibrary> get sdkLibraries => _libs.values.toList();
  SdkLibrary getSdkLibrary(String dartUri) => _libs[dartUri];
  Source mapDartUri(String dartUri) => _getSource(Uri.parse(dartUri));

  Source fromEncoding(UriKind kind, Uri uri) {
    if (kind != UriKind.DART_URI) {
      throw new UnsupportedError('expected dart: uri kind, got $kind.');
    }
    return _getSource(uri);
  }

  Source _getSource(Uri uri) {
    var src = _sources[uri];
    if (src == null) {
      if (reportMissing) print('warning: missing mock for $uri.');
      _sources[uri] =
          src = new _MockSdkSource(uri, 'library dart.${uri.path};');
    }
    return src;
  }

  @override
  Source fromFileUri(Uri uri) {
    throw new UnsupportedError('MockDartSdk.fromFileUri');
  }

  @override
  PackageBundle getLinkedBundle() => null;
}

class _MockSdkSource implements UriAnnotatedSource {
  /// Absolute URI which this source can be imported from.
  final Uri uri;
  final String _contents;

  Source get source => this;

  Source get librarySource => null;

  _MockSdkSource(this.uri, this._contents);

  bool exists() => true;

  int get hashCode => uri.hashCode;

  final int modificationStamp = 1;

  TimestampedData<String> get contents =>
      new TimestampedData(modificationStamp, _contents);

  String get encoding => "${uriKind.encoding}$uri";

  String get fullName => shortName;

  String get shortName => uri.path;

  UriKind get uriKind => UriKind.DART_URI;

  bool get isInSystemLibrary => true;

  Source resolveRelative(Uri relativeUri) =>
      throw new UnsupportedError('not expecting relative urls in dart: mocks');

  Uri resolveRelativeUri(Uri relativeUri) =>
      throw new UnsupportedError('not expecting relative urls in dart: mocks');

  bool operator ==(Object other) => identical(this, other);
}

/// Sample mock SDK sources.
final Map<String, String> mockSdkSources = {
  // The list of types below is derived from types that are used internally by
  // the resolver (see _initializeFrom in analyzer/src/generated/resolver.dart).
  'dart:core': '''
        library dart.core;

        void print(Object o) {}

        class Object {
          String toString(){}
        }
        class Function {}
        class StackTrace {}
        class Symbol {}
        class Type {}

        class String {}
        class bool {}
        class num {
          num operator +(num other) {}
        }
        class int extends num {
          int operator-() {}
        }
        class double extends num {}
        class DateTime {}
        class Null {}

        class Deprecated {
          final String expires;
          const Deprecated(this.expires);
        }
        const Object deprecated = const Deprecated("next release");
        class _Override { const _Override(); }
        const Object override = const _Override();
        class _Proxy { const _Proxy(); }
        const Object proxy = const _Proxy();

        class Iterable<E> {}
        class List<E> implements Iterable<E> {}
        class Map<K, V> {}
        ''',
  'dart:async': '''
        class Future<T> {
          Future then(callback) {}
        }
        class FutureOr<T> {}
        class Stream<T> {}
  ''',
  'dart:html': '''
        library dart.html;
        class HtmlElement {}
        ''',
};
