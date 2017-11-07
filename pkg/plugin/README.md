# plugin

Support for building plugins in Dart.

This project defines a simple framework for defining plugins. A _plugin_ is the
unit of extensibility for a host application.

An _extension point_ represents one way of extending the host application. For
example, a file viewer application might define an extension point to allow
viewers for new file types to be added to the application.

The host application must provide at least one extension point that plugins can
extend. Every extension point must have a unique name associated with it, and
should specify the type of the objects that will be accepted as extensions. In
the example above, the extension point might require that all extensions
implement the interface FileViewer.

Any plugin can define extension points that other plugins can extend. The host
application contributes its own extension point(s) by defining a plugin.

An _extension_ is an object that a plugin associates with a particular extension
point. To continue the example, a plugin that supports the viewing of .gif files
would create an instance of GifFileViewer, a class that implements FileViewer.

The framework in this package then connects the defined extensions with the
defined extension points so that the separately contributed plugins can
coordinate to accomplish the larger goal.

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/dart-lang/plugin/issues