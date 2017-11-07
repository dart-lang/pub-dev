///
//  Generated code. Do not modify.
///
library google.example.library.v1_library;

import 'dart:async';

import 'package:protobuf/protobuf.dart';

import '../../../protobuf/empty.pb.dart' as google$protobuf;

class Book extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Book')
    ..a/*<String>*/(1, 'name', PbFieldType.OS)
    ..a/*<String>*/(2, 'author', PbFieldType.OS)
    ..a/*<String>*/(3, 'title', PbFieldType.OS)
    ..a/*<bool>*/(4, 'read', PbFieldType.OB)
    ..hasRequiredFields = false
  ;

  Book() : super();
  Book.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Book.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Book clone() => new Book()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Book create() => new Book();
  static PbList<Book> createRepeated() => new PbList<Book>();
  static Book getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyBook();
    return _defaultInstance;
  }
  static Book _defaultInstance;
  static void $checkItem(Book v) {
    if (v is !Book) checkItemFailed(v, 'Book');
  }

  String get name => $_get(0, 1, '');
  void set name(String v) { $_setString(0, 1, v); }
  bool hasName() => $_has(0, 1);
  void clearName() => clearField(1);

  String get author => $_get(1, 2, '');
  void set author(String v) { $_setString(1, 2, v); }
  bool hasAuthor() => $_has(1, 2);
  void clearAuthor() => clearField(2);

  String get title => $_get(2, 3, '');
  void set title(String v) { $_setString(2, 3, v); }
  bool hasTitle() => $_has(2, 3);
  void clearTitle() => clearField(3);

  bool get read => $_get(3, 4, false);
  void set read(bool v) { $_setBool(3, 4, v); }
  bool hasRead() => $_has(3, 4);
  void clearRead() => clearField(4);
}

class _ReadonlyBook extends Book with ReadonlyMessageMixin {}

class Shelf extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Shelf')
    ..a/*<String>*/(1, 'name', PbFieldType.OS)
    ..a/*<String>*/(2, 'theme', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  Shelf() : super();
  Shelf.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Shelf.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Shelf clone() => new Shelf()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Shelf create() => new Shelf();
  static PbList<Shelf> createRepeated() => new PbList<Shelf>();
  static Shelf getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyShelf();
    return _defaultInstance;
  }
  static Shelf _defaultInstance;
  static void $checkItem(Shelf v) {
    if (v is !Shelf) checkItemFailed(v, 'Shelf');
  }

  String get name => $_get(0, 1, '');
  void set name(String v) { $_setString(0, 1, v); }
  bool hasName() => $_has(0, 1);
  void clearName() => clearField(1);

  String get theme => $_get(1, 2, '');
  void set theme(String v) { $_setString(1, 2, v); }
  bool hasTheme() => $_has(1, 2);
  void clearTheme() => clearField(2);
}

class _ReadonlyShelf extends Shelf with ReadonlyMessageMixin {}

class CreateShelfRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('CreateShelfRequest')
    ..a/*<Shelf>*/(1, 'shelf', PbFieldType.OM, Shelf.getDefault, Shelf.create)
    ..hasRequiredFields = false
  ;

  CreateShelfRequest() : super();
  CreateShelfRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  CreateShelfRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  CreateShelfRequest clone() => new CreateShelfRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static CreateShelfRequest create() => new CreateShelfRequest();
  static PbList<CreateShelfRequest> createRepeated() => new PbList<CreateShelfRequest>();
  static CreateShelfRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyCreateShelfRequest();
    return _defaultInstance;
  }
  static CreateShelfRequest _defaultInstance;
  static void $checkItem(CreateShelfRequest v) {
    if (v is !CreateShelfRequest) checkItemFailed(v, 'CreateShelfRequest');
  }

  Shelf get shelf => $_get(0, 1, null);
  void set shelf(Shelf v) { setField(1, v); }
  bool hasShelf() => $_has(0, 1);
  void clearShelf() => clearField(1);
}

class _ReadonlyCreateShelfRequest extends CreateShelfRequest with ReadonlyMessageMixin {}

class GetShelfRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('GetShelfRequest')
    ..a/*<String>*/(1, 'name', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  GetShelfRequest() : super();
  GetShelfRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  GetShelfRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  GetShelfRequest clone() => new GetShelfRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static GetShelfRequest create() => new GetShelfRequest();
  static PbList<GetShelfRequest> createRepeated() => new PbList<GetShelfRequest>();
  static GetShelfRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyGetShelfRequest();
    return _defaultInstance;
  }
  static GetShelfRequest _defaultInstance;
  static void $checkItem(GetShelfRequest v) {
    if (v is !GetShelfRequest) checkItemFailed(v, 'GetShelfRequest');
  }

  String get name => $_get(0, 1, '');
  void set name(String v) { $_setString(0, 1, v); }
  bool hasName() => $_has(0, 1);
  void clearName() => clearField(1);
}

class _ReadonlyGetShelfRequest extends GetShelfRequest with ReadonlyMessageMixin {}

class ListShelvesRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ListShelvesRequest')
    ..a/*<int>*/(1, 'pageSize', PbFieldType.O3)
    ..a/*<String>*/(2, 'pageToken', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  ListShelvesRequest() : super();
  ListShelvesRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ListShelvesRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ListShelvesRequest clone() => new ListShelvesRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ListShelvesRequest create() => new ListShelvesRequest();
  static PbList<ListShelvesRequest> createRepeated() => new PbList<ListShelvesRequest>();
  static ListShelvesRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyListShelvesRequest();
    return _defaultInstance;
  }
  static ListShelvesRequest _defaultInstance;
  static void $checkItem(ListShelvesRequest v) {
    if (v is !ListShelvesRequest) checkItemFailed(v, 'ListShelvesRequest');
  }

  int get pageSize => $_get(0, 1, 0);
  void set pageSize(int v) { $_setUnsignedInt32(0, 1, v); }
  bool hasPageSize() => $_has(0, 1);
  void clearPageSize() => clearField(1);

  String get pageToken => $_get(1, 2, '');
  void set pageToken(String v) { $_setString(1, 2, v); }
  bool hasPageToken() => $_has(1, 2);
  void clearPageToken() => clearField(2);
}

class _ReadonlyListShelvesRequest extends ListShelvesRequest with ReadonlyMessageMixin {}

class ListShelvesResponse extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ListShelvesResponse')
    ..pp/*<Shelf>*/(1, 'shelves', PbFieldType.PM, Shelf.$checkItem, Shelf.create)
    ..a/*<String>*/(2, 'nextPageToken', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  ListShelvesResponse() : super();
  ListShelvesResponse.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ListShelvesResponse.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ListShelvesResponse clone() => new ListShelvesResponse()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ListShelvesResponse create() => new ListShelvesResponse();
  static PbList<ListShelvesResponse> createRepeated() => new PbList<ListShelvesResponse>();
  static ListShelvesResponse getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyListShelvesResponse();
    return _defaultInstance;
  }
  static ListShelvesResponse _defaultInstance;
  static void $checkItem(ListShelvesResponse v) {
    if (v is !ListShelvesResponse) checkItemFailed(v, 'ListShelvesResponse');
  }

  List<Shelf> get shelves => $_get(0, 1, null);

  String get nextPageToken => $_get(1, 2, '');
  void set nextPageToken(String v) { $_setString(1, 2, v); }
  bool hasNextPageToken() => $_has(1, 2);
  void clearNextPageToken() => clearField(2);
}

class _ReadonlyListShelvesResponse extends ListShelvesResponse with ReadonlyMessageMixin {}

class DeleteShelfRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('DeleteShelfRequest')
    ..a/*<String>*/(1, 'name', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  DeleteShelfRequest() : super();
  DeleteShelfRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  DeleteShelfRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  DeleteShelfRequest clone() => new DeleteShelfRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static DeleteShelfRequest create() => new DeleteShelfRequest();
  static PbList<DeleteShelfRequest> createRepeated() => new PbList<DeleteShelfRequest>();
  static DeleteShelfRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyDeleteShelfRequest();
    return _defaultInstance;
  }
  static DeleteShelfRequest _defaultInstance;
  static void $checkItem(DeleteShelfRequest v) {
    if (v is !DeleteShelfRequest) checkItemFailed(v, 'DeleteShelfRequest');
  }

  String get name => $_get(0, 1, '');
  void set name(String v) { $_setString(0, 1, v); }
  bool hasName() => $_has(0, 1);
  void clearName() => clearField(1);
}

class _ReadonlyDeleteShelfRequest extends DeleteShelfRequest with ReadonlyMessageMixin {}

class MergeShelvesRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('MergeShelvesRequest')
    ..a/*<String>*/(1, 'name', PbFieldType.OS)
    ..a/*<String>*/(2, 'otherShelfName', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  MergeShelvesRequest() : super();
  MergeShelvesRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  MergeShelvesRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  MergeShelvesRequest clone() => new MergeShelvesRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static MergeShelvesRequest create() => new MergeShelvesRequest();
  static PbList<MergeShelvesRequest> createRepeated() => new PbList<MergeShelvesRequest>();
  static MergeShelvesRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyMergeShelvesRequest();
    return _defaultInstance;
  }
  static MergeShelvesRequest _defaultInstance;
  static void $checkItem(MergeShelvesRequest v) {
    if (v is !MergeShelvesRequest) checkItemFailed(v, 'MergeShelvesRequest');
  }

  String get name => $_get(0, 1, '');
  void set name(String v) { $_setString(0, 1, v); }
  bool hasName() => $_has(0, 1);
  void clearName() => clearField(1);

  String get otherShelfName => $_get(1, 2, '');
  void set otherShelfName(String v) { $_setString(1, 2, v); }
  bool hasOtherShelfName() => $_has(1, 2);
  void clearOtherShelfName() => clearField(2);
}

class _ReadonlyMergeShelvesRequest extends MergeShelvesRequest with ReadonlyMessageMixin {}

class CreateBookRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('CreateBookRequest')
    ..a/*<String>*/(1, 'name', PbFieldType.OS)
    ..a/*<Book>*/(2, 'book', PbFieldType.OM, Book.getDefault, Book.create)
    ..hasRequiredFields = false
  ;

  CreateBookRequest() : super();
  CreateBookRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  CreateBookRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  CreateBookRequest clone() => new CreateBookRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static CreateBookRequest create() => new CreateBookRequest();
  static PbList<CreateBookRequest> createRepeated() => new PbList<CreateBookRequest>();
  static CreateBookRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyCreateBookRequest();
    return _defaultInstance;
  }
  static CreateBookRequest _defaultInstance;
  static void $checkItem(CreateBookRequest v) {
    if (v is !CreateBookRequest) checkItemFailed(v, 'CreateBookRequest');
  }

  String get name => $_get(0, 1, '');
  void set name(String v) { $_setString(0, 1, v); }
  bool hasName() => $_has(0, 1);
  void clearName() => clearField(1);

  Book get book => $_get(1, 2, null);
  void set book(Book v) { setField(2, v); }
  bool hasBook() => $_has(1, 2);
  void clearBook() => clearField(2);
}

class _ReadonlyCreateBookRequest extends CreateBookRequest with ReadonlyMessageMixin {}

class GetBookRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('GetBookRequest')
    ..a/*<String>*/(1, 'name', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  GetBookRequest() : super();
  GetBookRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  GetBookRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  GetBookRequest clone() => new GetBookRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static GetBookRequest create() => new GetBookRequest();
  static PbList<GetBookRequest> createRepeated() => new PbList<GetBookRequest>();
  static GetBookRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyGetBookRequest();
    return _defaultInstance;
  }
  static GetBookRequest _defaultInstance;
  static void $checkItem(GetBookRequest v) {
    if (v is !GetBookRequest) checkItemFailed(v, 'GetBookRequest');
  }

  String get name => $_get(0, 1, '');
  void set name(String v) { $_setString(0, 1, v); }
  bool hasName() => $_has(0, 1);
  void clearName() => clearField(1);
}

class _ReadonlyGetBookRequest extends GetBookRequest with ReadonlyMessageMixin {}

class ListBooksRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ListBooksRequest')
    ..a/*<String>*/(1, 'name', PbFieldType.OS)
    ..a/*<int>*/(2, 'pageSize', PbFieldType.O3)
    ..a/*<String>*/(3, 'pageToken', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  ListBooksRequest() : super();
  ListBooksRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ListBooksRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ListBooksRequest clone() => new ListBooksRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ListBooksRequest create() => new ListBooksRequest();
  static PbList<ListBooksRequest> createRepeated() => new PbList<ListBooksRequest>();
  static ListBooksRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyListBooksRequest();
    return _defaultInstance;
  }
  static ListBooksRequest _defaultInstance;
  static void $checkItem(ListBooksRequest v) {
    if (v is !ListBooksRequest) checkItemFailed(v, 'ListBooksRequest');
  }

  String get name => $_get(0, 1, '');
  void set name(String v) { $_setString(0, 1, v); }
  bool hasName() => $_has(0, 1);
  void clearName() => clearField(1);

  int get pageSize => $_get(1, 2, 0);
  void set pageSize(int v) { $_setUnsignedInt32(1, 2, v); }
  bool hasPageSize() => $_has(1, 2);
  void clearPageSize() => clearField(2);

  String get pageToken => $_get(2, 3, '');
  void set pageToken(String v) { $_setString(2, 3, v); }
  bool hasPageToken() => $_has(2, 3);
  void clearPageToken() => clearField(3);
}

class _ReadonlyListBooksRequest extends ListBooksRequest with ReadonlyMessageMixin {}

class ListBooksResponse extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ListBooksResponse')
    ..pp/*<Book>*/(1, 'books', PbFieldType.PM, Book.$checkItem, Book.create)
    ..a/*<String>*/(2, 'nextPageToken', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  ListBooksResponse() : super();
  ListBooksResponse.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ListBooksResponse.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ListBooksResponse clone() => new ListBooksResponse()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ListBooksResponse create() => new ListBooksResponse();
  static PbList<ListBooksResponse> createRepeated() => new PbList<ListBooksResponse>();
  static ListBooksResponse getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyListBooksResponse();
    return _defaultInstance;
  }
  static ListBooksResponse _defaultInstance;
  static void $checkItem(ListBooksResponse v) {
    if (v is !ListBooksResponse) checkItemFailed(v, 'ListBooksResponse');
  }

  List<Book> get books => $_get(0, 1, null);

  String get nextPageToken => $_get(1, 2, '');
  void set nextPageToken(String v) { $_setString(1, 2, v); }
  bool hasNextPageToken() => $_has(1, 2);
  void clearNextPageToken() => clearField(2);
}

class _ReadonlyListBooksResponse extends ListBooksResponse with ReadonlyMessageMixin {}

class UpdateBookRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('UpdateBookRequest')
    ..a/*<String>*/(1, 'name', PbFieldType.OS)
    ..a/*<Book>*/(2, 'book', PbFieldType.OM, Book.getDefault, Book.create)
    ..hasRequiredFields = false
  ;

  UpdateBookRequest() : super();
  UpdateBookRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  UpdateBookRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  UpdateBookRequest clone() => new UpdateBookRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static UpdateBookRequest create() => new UpdateBookRequest();
  static PbList<UpdateBookRequest> createRepeated() => new PbList<UpdateBookRequest>();
  static UpdateBookRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyUpdateBookRequest();
    return _defaultInstance;
  }
  static UpdateBookRequest _defaultInstance;
  static void $checkItem(UpdateBookRequest v) {
    if (v is !UpdateBookRequest) checkItemFailed(v, 'UpdateBookRequest');
  }

  String get name => $_get(0, 1, '');
  void set name(String v) { $_setString(0, 1, v); }
  bool hasName() => $_has(0, 1);
  void clearName() => clearField(1);

  Book get book => $_get(1, 2, null);
  void set book(Book v) { setField(2, v); }
  bool hasBook() => $_has(1, 2);
  void clearBook() => clearField(2);
}

class _ReadonlyUpdateBookRequest extends UpdateBookRequest with ReadonlyMessageMixin {}

class DeleteBookRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('DeleteBookRequest')
    ..a/*<String>*/(1, 'name', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  DeleteBookRequest() : super();
  DeleteBookRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  DeleteBookRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  DeleteBookRequest clone() => new DeleteBookRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static DeleteBookRequest create() => new DeleteBookRequest();
  static PbList<DeleteBookRequest> createRepeated() => new PbList<DeleteBookRequest>();
  static DeleteBookRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyDeleteBookRequest();
    return _defaultInstance;
  }
  static DeleteBookRequest _defaultInstance;
  static void $checkItem(DeleteBookRequest v) {
    if (v is !DeleteBookRequest) checkItemFailed(v, 'DeleteBookRequest');
  }

  String get name => $_get(0, 1, '');
  void set name(String v) { $_setString(0, 1, v); }
  bool hasName() => $_has(0, 1);
  void clearName() => clearField(1);
}

class _ReadonlyDeleteBookRequest extends DeleteBookRequest with ReadonlyMessageMixin {}

class MoveBookRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('MoveBookRequest')
    ..a/*<String>*/(1, 'name', PbFieldType.OS)
    ..a/*<String>*/(2, 'otherShelfName', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  MoveBookRequest() : super();
  MoveBookRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  MoveBookRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  MoveBookRequest clone() => new MoveBookRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static MoveBookRequest create() => new MoveBookRequest();
  static PbList<MoveBookRequest> createRepeated() => new PbList<MoveBookRequest>();
  static MoveBookRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyMoveBookRequest();
    return _defaultInstance;
  }
  static MoveBookRequest _defaultInstance;
  static void $checkItem(MoveBookRequest v) {
    if (v is !MoveBookRequest) checkItemFailed(v, 'MoveBookRequest');
  }

  String get name => $_get(0, 1, '');
  void set name(String v) { $_setString(0, 1, v); }
  bool hasName() => $_has(0, 1);
  void clearName() => clearField(1);

  String get otherShelfName => $_get(1, 2, '');
  void set otherShelfName(String v) { $_setString(1, 2, v); }
  bool hasOtherShelfName() => $_has(1, 2);
  void clearOtherShelfName() => clearField(2);
}

class _ReadonlyMoveBookRequest extends MoveBookRequest with ReadonlyMessageMixin {}

class LibraryServiceApi {
  RpcClient _client;
  LibraryServiceApi(this._client);

  Future<Shelf> createShelf(ClientContext ctx, CreateShelfRequest request) {
    var emptyResponse = new Shelf();
    return _client.invoke(ctx, 'LibraryService', 'CreateShelf', request, emptyResponse);
  }
  Future<Shelf> getShelf(ClientContext ctx, GetShelfRequest request) {
    var emptyResponse = new Shelf();
    return _client.invoke(ctx, 'LibraryService', 'GetShelf', request, emptyResponse);
  }
  Future<ListShelvesResponse> listShelves(ClientContext ctx, ListShelvesRequest request) {
    var emptyResponse = new ListShelvesResponse();
    return _client.invoke(ctx, 'LibraryService', 'ListShelves', request, emptyResponse);
  }
  Future<google$protobuf.Empty> deleteShelf(ClientContext ctx, DeleteShelfRequest request) {
    var emptyResponse = new google$protobuf.Empty();
    return _client.invoke(ctx, 'LibraryService', 'DeleteShelf', request, emptyResponse);
  }
  Future<Shelf> mergeShelves(ClientContext ctx, MergeShelvesRequest request) {
    var emptyResponse = new Shelf();
    return _client.invoke(ctx, 'LibraryService', 'MergeShelves', request, emptyResponse);
  }
  Future<Book> createBook(ClientContext ctx, CreateBookRequest request) {
    var emptyResponse = new Book();
    return _client.invoke(ctx, 'LibraryService', 'CreateBook', request, emptyResponse);
  }
  Future<Book> getBook(ClientContext ctx, GetBookRequest request) {
    var emptyResponse = new Book();
    return _client.invoke(ctx, 'LibraryService', 'GetBook', request, emptyResponse);
  }
  Future<ListBooksResponse> listBooks(ClientContext ctx, ListBooksRequest request) {
    var emptyResponse = new ListBooksResponse();
    return _client.invoke(ctx, 'LibraryService', 'ListBooks', request, emptyResponse);
  }
  Future<google$protobuf.Empty> deleteBook(ClientContext ctx, DeleteBookRequest request) {
    var emptyResponse = new google$protobuf.Empty();
    return _client.invoke(ctx, 'LibraryService', 'DeleteBook', request, emptyResponse);
  }
  Future<Book> updateBook(ClientContext ctx, UpdateBookRequest request) {
    var emptyResponse = new Book();
    return _client.invoke(ctx, 'LibraryService', 'UpdateBook', request, emptyResponse);
  }
  Future<Book> moveBook(ClientContext ctx, MoveBookRequest request) {
    var emptyResponse = new Book();
    return _client.invoke(ctx, 'LibraryService', 'MoveBook', request, emptyResponse);
  }
}

