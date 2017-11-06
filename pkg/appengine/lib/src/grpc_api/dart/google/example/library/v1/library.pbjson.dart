///
//  Generated code. Do not modify.
///
library google.example.library.v1_library_pbjson;

import '../../../protobuf/empty.pbjson.dart' as google$protobuf;

const Book$json = const {
  '1': 'Book',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9},
    const {'1': 'author', '3': 2, '4': 1, '5': 9},
    const {'1': 'title', '3': 3, '4': 1, '5': 9},
    const {'1': 'read', '3': 4, '4': 1, '5': 8},
  ],
};

const Shelf$json = const {
  '1': 'Shelf',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9},
    const {'1': 'theme', '3': 2, '4': 1, '5': 9},
  ],
};

const CreateShelfRequest$json = const {
  '1': 'CreateShelfRequest',
  '2': const [
    const {'1': 'shelf', '3': 1, '4': 1, '5': 11, '6': '.google.example.library.v1.Shelf'},
  ],
};

const GetShelfRequest$json = const {
  '1': 'GetShelfRequest',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9},
  ],
};

const ListShelvesRequest$json = const {
  '1': 'ListShelvesRequest',
  '2': const [
    const {'1': 'page_size', '3': 1, '4': 1, '5': 5},
    const {'1': 'page_token', '3': 2, '4': 1, '5': 9},
  ],
};

const ListShelvesResponse$json = const {
  '1': 'ListShelvesResponse',
  '2': const [
    const {'1': 'shelves', '3': 1, '4': 3, '5': 11, '6': '.google.example.library.v1.Shelf'},
    const {'1': 'next_page_token', '3': 2, '4': 1, '5': 9},
  ],
};

const DeleteShelfRequest$json = const {
  '1': 'DeleteShelfRequest',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9},
  ],
};

const MergeShelvesRequest$json = const {
  '1': 'MergeShelvesRequest',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9},
    const {'1': 'other_shelf_name', '3': 2, '4': 1, '5': 9},
  ],
};

const CreateBookRequest$json = const {
  '1': 'CreateBookRequest',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9},
    const {'1': 'book', '3': 2, '4': 1, '5': 11, '6': '.google.example.library.v1.Book'},
  ],
};

const GetBookRequest$json = const {
  '1': 'GetBookRequest',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9},
  ],
};

const ListBooksRequest$json = const {
  '1': 'ListBooksRequest',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9},
    const {'1': 'page_size', '3': 2, '4': 1, '5': 5},
    const {'1': 'page_token', '3': 3, '4': 1, '5': 9},
  ],
};

const ListBooksResponse$json = const {
  '1': 'ListBooksResponse',
  '2': const [
    const {'1': 'books', '3': 1, '4': 3, '5': 11, '6': '.google.example.library.v1.Book'},
    const {'1': 'next_page_token', '3': 2, '4': 1, '5': 9},
  ],
};

const UpdateBookRequest$json = const {
  '1': 'UpdateBookRequest',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9},
    const {'1': 'book', '3': 2, '4': 1, '5': 11, '6': '.google.example.library.v1.Book'},
  ],
};

const DeleteBookRequest$json = const {
  '1': 'DeleteBookRequest',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9},
  ],
};

const MoveBookRequest$json = const {
  '1': 'MoveBookRequest',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9},
    const {'1': 'other_shelf_name', '3': 2, '4': 1, '5': 9},
  ],
};

const LibraryService$json = const {
  '1': 'LibraryService',
  '2': const [
    const {'1': 'CreateShelf', '2': '.google.example.library.v1.CreateShelfRequest', '3': '.google.example.library.v1.Shelf', '4': const {}},
    const {'1': 'GetShelf', '2': '.google.example.library.v1.GetShelfRequest', '3': '.google.example.library.v1.Shelf', '4': const {}},
    const {'1': 'ListShelves', '2': '.google.example.library.v1.ListShelvesRequest', '3': '.google.example.library.v1.ListShelvesResponse', '4': const {}},
    const {'1': 'DeleteShelf', '2': '.google.example.library.v1.DeleteShelfRequest', '3': '.google.protobuf.Empty', '4': const {}},
    const {'1': 'MergeShelves', '2': '.google.example.library.v1.MergeShelvesRequest', '3': '.google.example.library.v1.Shelf', '4': const {}},
    const {'1': 'CreateBook', '2': '.google.example.library.v1.CreateBookRequest', '3': '.google.example.library.v1.Book', '4': const {}},
    const {'1': 'GetBook', '2': '.google.example.library.v1.GetBookRequest', '3': '.google.example.library.v1.Book', '4': const {}},
    const {'1': 'ListBooks', '2': '.google.example.library.v1.ListBooksRequest', '3': '.google.example.library.v1.ListBooksResponse', '4': const {}},
    const {'1': 'DeleteBook', '2': '.google.example.library.v1.DeleteBookRequest', '3': '.google.protobuf.Empty', '4': const {}},
    const {'1': 'UpdateBook', '2': '.google.example.library.v1.UpdateBookRequest', '3': '.google.example.library.v1.Book', '4': const {}},
    const {'1': 'MoveBook', '2': '.google.example.library.v1.MoveBookRequest', '3': '.google.example.library.v1.Book', '4': const {}},
  ],
};

const LibraryService$messageJson = const {
  '.google.example.library.v1.CreateShelfRequest': CreateShelfRequest$json,
  '.google.example.library.v1.Shelf': Shelf$json,
  '.google.example.library.v1.GetShelfRequest': GetShelfRequest$json,
  '.google.example.library.v1.ListShelvesRequest': ListShelvesRequest$json,
  '.google.example.library.v1.ListShelvesResponse': ListShelvesResponse$json,
  '.google.example.library.v1.DeleteShelfRequest': DeleteShelfRequest$json,
  '.google.protobuf.Empty': google$protobuf.Empty$json,
  '.google.example.library.v1.MergeShelvesRequest': MergeShelvesRequest$json,
  '.google.example.library.v1.CreateBookRequest': CreateBookRequest$json,
  '.google.example.library.v1.Book': Book$json,
  '.google.example.library.v1.GetBookRequest': GetBookRequest$json,
  '.google.example.library.v1.ListBooksRequest': ListBooksRequest$json,
  '.google.example.library.v1.ListBooksResponse': ListBooksResponse$json,
  '.google.example.library.v1.DeleteBookRequest': DeleteBookRequest$json,
  '.google.example.library.v1.UpdateBookRequest': UpdateBookRequest$json,
  '.google.example.library.v1.MoveBookRequest': MoveBookRequest$json,
};

