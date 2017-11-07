// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// Utility functions to create fixed-length lists.
library isolate.lists;

/// Create a single-element fixed-length list.
List list1(v1) => new List(1)..[0] = v1;

/// Create a two-element fixed-length list.
List list2(v1, v2) => new List(2)
  ..[0] = v1
  ..[1] = v2;

/// Create a three-element fixed-length list.
List list3(v1, v2, v3) => new List(3)
  ..[0] = v1
  ..[1] = v2
  ..[2] = v3;

/// Create a four-element fixed-length list.
List list4(v1, v2, v3, v4) => new List(4)
  ..[0] = v1
  ..[1] = v2
  ..[2] = v3
  ..[3] = v4;

/// Create a five-element fixed-length list.
List list5(v1, v2, v3, v4, v5) => new List(5)
  ..[0] = v1
  ..[1] = v2
  ..[2] = v3
  ..[3] = v4
  ..[4] = v5;
