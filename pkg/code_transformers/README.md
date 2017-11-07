# Code Transformers
This package exposes various tools to help in the creation and testing of
barback transformers, as well as an interface for logging messages with
constant ids for documentation purposes.

## Messages and logging

This package exposes a `BuildLogger` class as well as `Message`,
`MessageTemplate`, and `MessageId` classes. These work together to provide
stable error messages with ids that can be referenced in documentation.

### MessageId

A `MessageId` is a constant definition of a message in a package. These are
used to group messages with the same id or link to sections in a document.

    const myId = const MessageId('myPackage', 0);
 
These ids should typically never change or disappear throughout the entire
lifetime of a package.

### Message

A `Message` is a const object which has a `MessageId` and `snippet`.

    const myMessage = const Message(myId, 'my message');

### MessageTemplate

TODO(jakemac): Docs on this, see
https://github.com/dart-lang/code-transformers/blob/master/lib/messages/messages.dart

### BuildLogger

The `BuildLogger` class just wraps a normal `TransformLogger` to provide some
additional functionality. You use it in the same way as a `TransformLogger`
except that the log methods can accept a `String` or a `Message`. This should
usually be created in the first step of your transformers `apply` function:

    apply(Transform transform) {
      // If detailsUri is passed, then a link will be output with each log
      // message that follows this format
      // `$detailsUri#${msg.id.package}_${msg.id.id}`.
      var logger = new BuildLogger(transform, detailsUri: 'http://foo.com');
    }

You can optionally dump out a file containing all the logs found in JSON
format by calling the `writeOutput` method on the logger when you are done.
The output file will have the same file path as the primary input of the
transformer, with an extension matching this pattern `._buildLogs.$i`. The
`i` increments starting at 0 each time that logs are output (if multiple
transformers run on the same file for instance). These can all be combined
into a single file later on by calling the static
`combineLogFiles(Transform transform)` function.

## Testing Transformers

TODO(jakemac): Docs on this, see `testPhases` in
https://github.com/dart-lang/code-transformers/blob/master/lib/tests.dart

## Using the Analyzer in Transformers

This package exposes a `Resolver` class which helps out when using the
analyzer in a transform.

TODO(jakemac): Docs on this, see
https://github.com/dart-lang/code-transformers/blob/master/lib/src/resolver.dart

## Barback AssetIds and Uris

This package also provides some helpers to convert `AssetId`s to and from `Uri`s
relative to a source asset.

TODO(jakemac): Docs on this, see `uriToAssetId` & `assetIdToUri` in
https://github.com/dart-lang/code-transformers/blob/master/lib/assets.dart
