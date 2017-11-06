// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import 'package:crypto/crypto.dart';

final _usage = 'Usage: dart hash.dart <md5|sha1|sha256> <input_filename>';

Future main(List<String> args) async {
  if (args == null || args.length != 2) {
    print(_usage);
    exit(1);
  }

  Hash hasher;

  switch (args[0]) {
    case 'md5':
      hasher = md5;
      break;
    case 'sha1':
      hasher = sha1;
      break;
    case 'sha256':
      hasher = sha256;
      break;
    default:
      print(_usage);
      exit(1);
  }

  var filename = args[1];
  var input = new File(filename);

  if (!input.existsSync()) {
    print('File "$filename" does not exist.');
    exit(1);
  }

  var value = await hasher.bind(input.openRead()).first;

  print(value);
}
