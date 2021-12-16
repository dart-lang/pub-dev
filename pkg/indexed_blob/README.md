# Indexed Blob
The `indexed_blob` package provides support for reading and writing
indexed-blobs.

An _indexed blob_ is a blob-file and an index-file pointing into the blob.
The index-file can be used to find _start_ and _end_ offset for a file
stored inside the blob.

This is aimed to work efficiently with Google Cloud Storage, enabling
many small files to be stored as a single blob and index file. While
facilitating individual files to be retrieved by fetching the index file,
finding the _start_ and _end_ offset for use with an HTTP range request.

To goal of this format is to support storing the many small files generated
by `dartdoc` as an indexed-blob.
