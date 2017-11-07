// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

part of gcloud.storage;

const String _ABSOLUTE_PREFIX = 'gs://';
const String _DIRECTORY_DELIMITER = 'gs://';

/// Representation of an absolute name consisting of bucket name and object
/// name.
class _AbsoluteName {
  String bucketName;
  String objectName;

  _AbsoluteName.parse(String absoluteName) {
    if (!absoluteName.startsWith(_ABSOLUTE_PREFIX)) {
      throw new FormatException("Absolute name '$absoluteName' does not start "
          "with '$_ABSOLUTE_PREFIX'");
    }
    int index = absoluteName.indexOf('/', _ABSOLUTE_PREFIX.length);
    if (index == -1 || index == _ABSOLUTE_PREFIX.length) {
      throw new FormatException("Absolute name '$absoluteName' does not have "
          "a bucket name");
    }
    if (index == absoluteName.length - 1) {
      throw new FormatException("Absolute name '$absoluteName' does not have "
          "an object name");
    }
    bucketName = absoluteName.substring(_ABSOLUTE_PREFIX.length, index);
    objectName = absoluteName.substring(index + 1);
  }
}

/// Storage API implementation providing access to buckets.
class _StorageImpl implements Storage {
  final String project;
  final storage_api.StorageApi _api;

  _StorageImpl(http.Client client, this.project)
      : _api = new storage_api.StorageApi(client);

  Future createBucket(String bucketName,
      {PredefinedAcl predefinedAcl, Acl acl}) {
    var bucket = new storage_api.Bucket()..name = bucketName;
    var predefinedName = predefinedAcl != null ? predefinedAcl._name : null;
    if (acl != null) {
      bucket.acl = acl._toBucketAccessControlList();
    }
    return _api.buckets
        .insert(bucket, project, predefinedAcl: predefinedName)
        .then((bucket) => null);
  }

  Future deleteBucket(String bucketName) {
    return _api.buckets.delete(bucketName);
  }

  Bucket bucket(String bucketName,
      {PredefinedAcl defaultPredefinedObjectAcl, Acl defaultObjectAcl}) {
    return new _BucketImpl(
        this, bucketName, defaultPredefinedObjectAcl, defaultObjectAcl);
  }

  Future<bool> bucketExists(String bucketName) {
    notFoundError(e) {
      return e is storage_api.DetailedApiRequestError && e.status == 404;
    }

    return _api.buckets
        .get(bucketName)
        .then((_) => true)
        .catchError((e) => false, test: notFoundError);
  }

  Future<BucketInfo> bucketInfo(String bucketName) {
    return _api.buckets
        .get(bucketName, projection: 'full')
        .then((bucket) => new _BucketInfoImpl(bucket));
  }

  Stream<String> listBucketNames() {
    Future<_BucketPageImpl> firstPage(pageSize) {
      return _listBuckets(pageSize, null)
          .then((response) => new _BucketPageImpl(this, pageSize, response));
    }

    return new StreamFromPages<String>(firstPage).stream;
  }

  Future<Page<String>> pageBucketNames({int pageSize: 50}) {
    return _listBuckets(pageSize, null).then((response) {
      return new _BucketPageImpl(this, pageSize, response);
    });
  }

  Future copyObject(String src, String dest) {
    var srcName = new _AbsoluteName.parse(src);
    var destName = new _AbsoluteName.parse(dest);
    return _api.objects
        .copy(null, srcName.bucketName, srcName.objectName, destName.bucketName,
            destName.objectName)
        .then((_) => null);
  }

  Future<storage_api.Buckets> _listBuckets(int pageSize, String nextPageToken) {
    return _api.buckets
        .list(project, maxResults: pageSize, pageToken: nextPageToken);
  }
}

class _BucketInfoImpl implements BucketInfo {
  final storage_api.Bucket _bucket;

  _BucketInfoImpl(this._bucket);

  String get bucketName => _bucket.name;

  String get etag => _bucket.etag;

  DateTime get created => _bucket.timeCreated;

  String get id => _bucket.id;

  Acl get acl => new Acl._fromBucketAcl(_bucket);
}

/// Bucket API implementation providing access to objects.
class _BucketImpl implements Bucket {
  final storage_api.StorageApi _api;
  PredefinedAcl _defaultPredefinedObjectAcl;
  Acl _defaultObjectAcl;
  final String bucketName;

  _BucketImpl(_StorageImpl storage, this.bucketName,
      this._defaultPredefinedObjectAcl, this._defaultObjectAcl)
      : this._api = storage._api;

  String absoluteObjectName(String objectName) {
    return '${_ABSOLUTE_PREFIX}$bucketName/$objectName';
  }

  StreamSink<List<int>> write(String objectName,
      {int length,
      ObjectMetadata metadata,
      Acl acl,
      PredefinedAcl predefinedAcl,
      String contentType}) {
    storage_api.Object object;
    if (metadata == null) {
      metadata = new _ObjectMetadata(acl: acl, contentType: contentType);
    } else {
      if (acl != null) {
        metadata = metadata.replace(acl: acl);
      }
      if (contentType != null) {
        metadata = metadata.replace(contentType: contentType);
      }
    }
    _ObjectMetadata objectMetadata = metadata;
    object = objectMetadata._object;

    // If no predefined ACL is passed use the default (if any).
    var predefinedName;
    if (predefinedAcl != null || _defaultPredefinedObjectAcl != null) {
      var predefined =
          predefinedAcl != null ? predefinedAcl : _defaultPredefinedObjectAcl;
      predefinedName = predefined._name;
    }

    // If no ACL is passed use the default (if any).
    if (object.acl == null && _defaultObjectAcl != null) {
      object.acl = _defaultObjectAcl._toObjectAccessControlList();
    }

    // Fill properties not passed in metadata.
    object.name = objectName;

    var sink = new _MediaUploadStreamSink(
        _api, bucketName, objectName, object, predefinedName, length);
    return sink;
  }

  Future<ObjectInfo> writeBytes(String objectName, List<int> bytes,
      {ObjectMetadata metadata,
      Acl acl,
      PredefinedAcl predefinedAcl,
      String contentType}) {
    var sink = write(objectName,
        length: bytes.length,
        metadata: metadata,
        acl: acl,
        predefinedAcl: predefinedAcl,
        contentType: contentType);
    sink.add(bytes);
    return sink.close();
  }

  Stream<List<int>> read(String objectName, {int offset, int length}) async* {
    if (offset == null) {
      offset = 0;
    }

    if (offset != 0 && length == null) {
      throw new ArgumentError(
          'length must have a value if offset is non-zero.');
    }

    var options = storage_api.DownloadOptions.FullMedia;

    if (length != null) {
      if (length <= 0) {
        throw new ArgumentError.value(
            length, 'length', 'If provided, length must greater than zero.');
      }
      // For ByteRange, end is *inclusive*.
      var end = offset + length - 1;
      var range = new storage_api.ByteRange(offset, end);
      assert(range.length == length);
      options = new storage_api.PartialDownloadOptions(range);
    }

    var media = await _api.objects
        .get(bucketName, objectName, downloadOptions: options);

    yield* media.stream;
  }

  Future<ObjectInfo> info(String objectName) {
    return _api.objects
        .get(bucketName, objectName, projection: 'full')
        .then((object) => new _ObjectInfoImpl(object));
  }

  Future delete(String objectName) {
    return _api.objects.delete(bucketName, objectName);
  }

  Stream<BucketEntry> list({String prefix}) {
    Future<_ObjectPageImpl> firstPage(pageSize) {
      return _listObjects(bucketName, prefix, _DIRECTORY_DELIMITER, 50, null)
          .then((response) =>
              new _ObjectPageImpl(this, prefix, pageSize, response));
    }

    return new StreamFromPages<BucketEntry>(firstPage).stream;
  }

  Future<Page<BucketEntry>> page({String prefix, int pageSize: 50}) {
    return _listObjects(
            bucketName, prefix, _DIRECTORY_DELIMITER, pageSize, null)
        .then((response) {
      return new _ObjectPageImpl(this, prefix, pageSize, response);
    });
  }

  Future updateMetadata(String objectName, ObjectMetadata metadata) {
    // TODO: support other ObjectMetadata implementations?
    _ObjectMetadata md = metadata;
    var object = md._object;
    if (md._object.acl == null && _defaultObjectAcl == null) {
      throw new ArgumentError('ACL is required for update');
    }
    if (md.contentType == null) {
      throw new ArgumentError('Content-Type is required for update');
    }
    if (md._object.acl == null) {
      md._object.acl = _defaultObjectAcl._toObjectAccessControlList();
    }
    return _api.objects.update(object, bucketName, objectName);
  }

  Future<storage_api.Objects> _listObjects(String bucketName, String prefix,
      String delimiter, int pageSize, String nextPageToken) {
    return _api.objects.list(bucketName,
        prefix: prefix,
        delimiter: delimiter,
        maxResults: pageSize,
        pageToken: nextPageToken);
  }
}

class _BucketPageImpl implements Page<String> {
  final _StorageImpl _storage;
  final int _pageSize;
  final String _nextPageToken;
  final List<String> items;

  _BucketPageImpl(this._storage, this._pageSize, storage_api.Buckets response)
      : items = new List(response.items != null ? response.items.length : 0),
        _nextPageToken = response.nextPageToken {
    for (int i = 0; i < items.length; i++) {
      items[i] = response.items[i].name;
    }
  }

  bool get isLast => _nextPageToken == null;

  Future<Page<String>> next({int pageSize}) {
    if (isLast) return new Future.value(null);
    if (pageSize == null) pageSize = this._pageSize;

    return _storage._listBuckets(pageSize, _nextPageToken).then((response) {
      return new _BucketPageImpl(_storage, pageSize, response);
    });
  }
}

class _ObjectPageImpl implements Page<BucketEntry> {
  final _BucketImpl _bucket;
  final String _prefix;
  final int _pageSize;
  final String _nextPageToken;
  final List<BucketEntry> items;

  _ObjectPageImpl(
      this._bucket, this._prefix, this._pageSize, storage_api.Objects response)
      : items = new List((response.items != null ? response.items.length : 0) +
            (response.prefixes != null ? response.prefixes.length : 0)),
        _nextPageToken = response.nextPageToken {
    var prefixes = 0;
    if (response.prefixes != null) {
      for (int i = 0; i < response.prefixes.length; i++) {
        items[i] = new BucketEntry._directory(response.prefixes[i]);
      }
      prefixes = response.prefixes.length;
    }
    if (response.items != null) {
      for (int i = 0; i < response.items.length; i++) {
        items[prefixes + i] = new BucketEntry._object(response.items[i].name);
      }
    }
  }

  bool get isLast => _nextPageToken == null;

  Future<Page<BucketEntry>> next({int pageSize}) {
    if (isLast) return new Future.value(null);
    if (pageSize == null) pageSize = this._pageSize;

    return _bucket
        ._listObjects(_bucket.bucketName, _prefix, _DIRECTORY_DELIMITER,
            pageSize, _nextPageToken)
        .then((response) {
      return new _ObjectPageImpl(_bucket, _prefix, pageSize, response);
    });
  }
}

class _ObjectGenerationImpl implements ObjectGeneration {
  final String objectGeneration;
  final int metaGeneration;

  _ObjectGenerationImpl(this.objectGeneration, this.metaGeneration);
}

class _ObjectInfoImpl implements ObjectInfo {
  final storage_api.Object _object;
  final ObjectMetadata _metadata;
  Uri _downloadLink;
  ObjectGeneration _generation;

  _ObjectInfoImpl(storage_api.Object object)
      : _object = object,
        _metadata = new _ObjectMetadata._(object);

  String get name => _object.name;

  int get length => int.parse(_object.size);

  DateTime get updated => _object.updated;

  String get etag => _object.etag;

  List<int> get md5Hash => BASE64.decode(_object.md5Hash);

  int get crc32CChecksum {
    var list = BASE64.decode(_object.crc32c);
    return (list[3] << 24) | (list[2] << 16) | (list[1] << 8) | list[0];
  }

  Uri get downloadLink {
    if (_downloadLink == null) {
      _downloadLink = Uri.parse(_object.mediaLink);
    }
    return _downloadLink;
  }

  ObjectGeneration get generation {
    if (_generation == null) {
      _generation = new _ObjectGenerationImpl(
          _object.generation, int.parse(_object.metageneration));
    }
    return _generation;
  }

  /// Additional metadata.
  ObjectMetadata get metadata => _metadata;
}

class _ObjectMetadata implements ObjectMetadata {
  final storage_api.Object _object;
  Acl _cachedAcl;
  ObjectGeneration _cachedGeneration;
  Map _cachedCustom;

  _ObjectMetadata(
      {Acl acl,
      String contentType,
      String contentEncoding,
      String cacheControl,
      String contentDisposition,
      String contentLanguage,
      Map<String, String> custom})
      : _object = new storage_api.Object() {
    _object.acl = acl != null ? acl._toObjectAccessControlList() : null;
    _object.contentType = contentType;
    _object.contentEncoding = contentEncoding;
    _object.cacheControl = cacheControl;
    _object.contentDisposition = contentDisposition;
    _object.contentLanguage = contentLanguage;
    if (custom != null) _object.metadata = custom;
  }

  _ObjectMetadata._(this._object);

  Acl get acl {
    if (_cachedAcl == null) {
      _cachedAcl = new Acl._fromObjectAcl(_object);
    }
    return _cachedAcl;
  }

  String get contentType => _object.contentType;

  String get contentEncoding => _object.contentEncoding;

  String get cacheControl => _object.cacheControl;

  String get contentDisposition => _object.contentDisposition;

  String get contentLanguage => _object.contentLanguage;

  ObjectGeneration get generation {
    if (_cachedGeneration == null) {
      _cachedGeneration = new ObjectGeneration(
          _object.generation, int.parse(_object.metageneration));
    }
    return _cachedGeneration;
  }

  Map<String, String> get custom {
    if (_object.metadata == null) return null;
    if (_cachedCustom == null) {
      _cachedCustom = new UnmodifiableMapView(_object.metadata);
    }
    return _cachedCustom;
  }

  ObjectMetadata replace(
      {Acl acl,
      String contentType,
      String contentEncoding,
      String cacheControl,
      String contentDisposition,
      String contentLanguage,
      Map<String, String> custom}) {
    return new _ObjectMetadata(
        acl: acl != null ? acl : this.acl,
        contentType: contentType != null ? contentType : this.contentType,
        contentEncoding:
            contentEncoding != null ? contentEncoding : this.contentEncoding,
        cacheControl: cacheControl != null ? cacheControl : this.cacheControl,
        contentDisposition: contentDisposition != null
            ? contentDisposition
            : this.contentEncoding,
        contentLanguage:
            contentLanguage != null ? contentLanguage : this.contentEncoding,
        custom: custom != null ? new Map.from(custom) : this.custom);
  }
}

/// Implementation of StreamSink which handles Google media upload.
/// It provides a StreamSink and logic which selects whether to use normal
/// media upload (multipart mime) or resumable media upload.
class _MediaUploadStreamSink implements StreamSink<List<int>> {
  static const int _DEFAULT_MAX_NORMAL_UPLOAD_LENGTH = 1024 * 1024;
  final storage_api.StorageApi _api;
  final String _bucketName;
  final String _objectName;
  final storage_api.Object _object;
  final String _predefinedAcl;
  final int _length;
  final int _maxNormalUploadLength;
  int _bufferLength = 0;
  final List<List<int>> buffer = new List<List<int>>();
  final _controller = new StreamController<List<int>>(sync: true);
  StreamSubscription _subscription;
  StreamController _resumableController;
  final _doneCompleter = new Completer<_ObjectInfoImpl>();

  static const int _STATE_LENGTH_KNOWN = 0;
  static const int _STATE_PROBING_LENGTH = 1;
  static const int _STATE_DECIDED_RESUMABLE = 2;
  int _state;

  _MediaUploadStreamSink(this._api, this._bucketName, this._objectName,
      this._object, this._predefinedAcl, this._length,
      [this._maxNormalUploadLength = _DEFAULT_MAX_NORMAL_UPLOAD_LENGTH]) {
    if (_length != null) {
      // If the length is known in advance decide on the upload strategy
      // immediately
      _state = _STATE_LENGTH_KNOWN;
      if (_length <= _maxNormalUploadLength) {
        _startNormalUpload(_controller.stream, _length);
      } else {
        _startResumableUpload(_controller.stream, _length);
      }
    } else {
      _state = _STATE_PROBING_LENGTH;
      // If the length is not known in advance decide on the upload strategy
      // later. Start buffering until enough data has been read to decide.
      _subscription = _controller.stream
          .listen(_onData, onDone: _onDone, onError: _onError);
    }
  }

  void add(List<int> event) {
    _controller.add(event);
  }

  void addError(errorEvent, [StackTrace stackTrace]) {
    _controller.addError(errorEvent, stackTrace);
  }

  Future addStream(Stream<List<int>> stream) {
    return _controller.addStream(stream);
  }

  Future close() {
    _controller.close();
    return _doneCompleter.future;
  }

  Future get done => _doneCompleter.future;

  _onData(List<int> data) {
    assert(_state != _STATE_LENGTH_KNOWN);
    if (_state == _STATE_PROBING_LENGTH) {
      buffer.add(data);
      _bufferLength += data.length;
      if (_bufferLength > _maxNormalUploadLength) {
        // Start resumable upload.
        // TODO: Avoid using another stream-controller.
        _resumableController = new StreamController(sync: true);
        buffer.forEach(_resumableController.add);
        _startResumableUpload(_resumableController.stream, _length);
        _state = _STATE_DECIDED_RESUMABLE;
      }
    } else {
      assert(_state == _STATE_DECIDED_RESUMABLE);
      _resumableController.add(data);
    }
  }

  _onDone() {
    if (_state == _STATE_PROBING_LENGTH) {
      // As the data is already cached don't bother to wait on somebody
      // listening on the stream before adding the data.
      _startNormalUpload(new Stream.fromIterable(buffer), _bufferLength);
    } else {
      _resumableController.close();
    }
  }

  _onError(e, s) {
    // If still deciding on the strategy complete with error. Otherwise
    // forward the error for default processing.
    if (_state == _STATE_PROBING_LENGTH) {
      _completeError(e, s);
    } else {
      _resumableController.addError(e, s);
    }
  }

  _completeError(e, s) {
    if (_state != _STATE_LENGTH_KNOWN) {
      // Always cancel subscription on error.
      _subscription.cancel();
    }
    _doneCompleter.completeError(e, s);
  }

  void _startNormalUpload(Stream stream, int length) {
    var contentType = _object.contentType != null
        ? _object.contentType
        : 'application/octet-stream';
    var media = new storage_api.Media(stream, length, contentType: contentType);
    _api.objects
        .insert(_object, _bucketName,
            name: _objectName,
            predefinedAcl: _predefinedAcl,
            uploadMedia: media,
            uploadOptions: storage_api.UploadOptions.Default)
        .then((response) {
      _doneCompleter.complete(new _ObjectInfoImpl(response));
    }, onError: _completeError);
  }

  void _startResumableUpload(Stream stream, int length) {
    var contentType = _object.contentType != null
        ? _object.contentType
        : 'application/octet-stream';
    var media = new storage_api.Media(stream, length, contentType: contentType);
    _api.objects
        .insert(_object, _bucketName,
            name: _objectName,
            predefinedAcl: _predefinedAcl,
            uploadMedia: media,
            uploadOptions: storage_api.UploadOptions.Resumable)
        .then((response) {
      _doneCompleter.complete(new _ObjectInfoImpl(response));
    }, onError: _completeError);
  }
}
