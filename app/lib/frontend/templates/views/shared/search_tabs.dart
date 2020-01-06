// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:json_annotation/json_annotation.dart';

part 'search_tabs.g.dart';

@JsonSerializable(createFactory: false, explicitToJson: true)
class SearchTabs {
  final List<SearchTab> tabs;

  SearchTabs({this.tabs});

  Map<String, dynamic> toJson() => _$SearchTabsToJson(this);
}

@JsonSerializable(createFactory: false, explicitToJson: true)
class SearchTab {
  final bool active;
  final String href;
  final String title;
  final String text;

  SearchTab({
    this.active,
    this.href,
    this.title,
    this.text,
  });

  Map<String, dynamic> toJson() => _$SearchTabToJson(this);
}
