// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import 'package:appengine/appengine.dart';
import 'package:shelf/shelf.dart' as shelf;
import 'package:shelf/shelf_io.dart' as shelf_io;

Future runHandler(shelf.Handler handler, {bool shared: false}) =>
    runAppEngine((HttpRequest request) => handleRequest(request, handler),
        shared: shared ?? false);

Future handleRequest(HttpRequest request, shelf.Handler handler) =>
    shelf_io.handleRequest(request, handler);
