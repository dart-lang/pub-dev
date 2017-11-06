// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

part of protobuf;

/// Client side context.
class ClientContext {
  // TODO: Place client side specific information here.
}

/// Client-side transport for making calls to a service.
///
/// Subclasses implement whatever serialization and networking is needed
/// to make a call. They should serialize the request to binary or JSON as
/// appropriate and merge the response into the supplied emptyResponse
/// before returning it.
///
/// The protoc plugin generates a client-side stub for each service that
/// takes an RpcClient as a constructor parameter.
abstract class RpcClient {
  /// Sends a request to a server and returns the reply.
  ///
  /// The implementation should serialize the request as binary or JSON, as
  /// appropriate. It should merge the reply into [emptyResponse] and
  /// return it.
  Future<GeneratedMessage> invoke(
      ClientContext ctx,
      String serviceName,
      String methodName,
      GeneratedMessage request,
      GeneratedMessage emptyResponse);
}
