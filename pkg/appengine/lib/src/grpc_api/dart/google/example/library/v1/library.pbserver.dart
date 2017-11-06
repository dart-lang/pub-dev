///
//  Generated code. Do not modify.
///
library google.example.library.v1_library_pbserver;

import 'dart:async';

import 'package:protobuf/protobuf.dart';

import 'library.pb.dart';
import '../../../protobuf/empty.pb.dart' as google$protobuf;
import 'library.pbjson.dart';

export 'library.pb.dart';

abstract class LibraryServiceBase extends GeneratedService {
  Future<Shelf> createShelf(ServerContext ctx, CreateShelfRequest request);
  Future<Shelf> getShelf(ServerContext ctx, GetShelfRequest request);
  Future<ListShelvesResponse> listShelves(ServerContext ctx, ListShelvesRequest request);
  Future<google$protobuf.Empty> deleteShelf(ServerContext ctx, DeleteShelfRequest request);
  Future<Shelf> mergeShelves(ServerContext ctx, MergeShelvesRequest request);
  Future<Book> createBook(ServerContext ctx, CreateBookRequest request);
  Future<Book> getBook(ServerContext ctx, GetBookRequest request);
  Future<ListBooksResponse> listBooks(ServerContext ctx, ListBooksRequest request);
  Future<google$protobuf.Empty> deleteBook(ServerContext ctx, DeleteBookRequest request);
  Future<Book> updateBook(ServerContext ctx, UpdateBookRequest request);
  Future<Book> moveBook(ServerContext ctx, MoveBookRequest request);

  GeneratedMessage createRequest(String method) {
    switch (method) {
      case 'CreateShelf': return new CreateShelfRequest();
      case 'GetShelf': return new GetShelfRequest();
      case 'ListShelves': return new ListShelvesRequest();
      case 'DeleteShelf': return new DeleteShelfRequest();
      case 'MergeShelves': return new MergeShelvesRequest();
      case 'CreateBook': return new CreateBookRequest();
      case 'GetBook': return new GetBookRequest();
      case 'ListBooks': return new ListBooksRequest();
      case 'DeleteBook': return new DeleteBookRequest();
      case 'UpdateBook': return new UpdateBookRequest();
      case 'MoveBook': return new MoveBookRequest();
      default: throw new ArgumentError('Unknown method: $method');
    }
  }

  Future<GeneratedMessage> handleCall(ServerContext ctx, String method, GeneratedMessage request) {
    switch (method) {
      case 'CreateShelf': return this.createShelf(ctx, request);
      case 'GetShelf': return this.getShelf(ctx, request);
      case 'ListShelves': return this.listShelves(ctx, request);
      case 'DeleteShelf': return this.deleteShelf(ctx, request);
      case 'MergeShelves': return this.mergeShelves(ctx, request);
      case 'CreateBook': return this.createBook(ctx, request);
      case 'GetBook': return this.getBook(ctx, request);
      case 'ListBooks': return this.listBooks(ctx, request);
      case 'DeleteBook': return this.deleteBook(ctx, request);
      case 'UpdateBook': return this.updateBook(ctx, request);
      case 'MoveBook': return this.moveBook(ctx, request);
      default: throw new ArgumentError('Unknown method: $method');
    }
  }

  Map<String, dynamic> get $json => LibraryService$json;
  Map<String, dynamic> get $messageJson => LibraryService$messageJson;
}

