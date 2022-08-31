// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:_pub_shared/search/search_form.dart';
import 'package:_pub_shared/search/tags.dart';

import '../../../../package/models.dart';
import '../../../../service/youtube/backend.dart';
import '../../../../shared/urls.dart' as urls;
import '../../../dom/dom.dart' as d;
import '../../../static_files.dart';

import 'mini_list.dart';
import 'pow_video_list.dart';

/// Renders the landing page content.
d.Node landingPageNode({
  List<PackageView>? ffPackages,
  List<PackageView>? mostPopularPackages,
  List<PackageView>? topFlutterPackages,
  List<PackageView>? topDartPackages,
  List<PkgOfWeekVideo>? topPoWVideos,
}) {
  return d.fragment([
    if (_isNotEmptyList(ffPackages))
      _block(
        shortId: 'ff',
        title: 'Flutter Favorites',
        info: _ffInfo,
        content: miniListNode('flutter-favorites', ffPackages!),
        viewAllUrl:
            SearchForm(query: PackageTags.isFlutterFavorite).toSearchLink(),
        viewAllEvent: 'landing-flutter-favorites-view-all',
      ),
    if (_isNotEmptyList(mostPopularPackages))
      _block(
        shortId: 'mp',
        image: d.Image(
          src: staticUrls.getAssetUrl('/static/img/landing-01.webp'),
          alt: 'decoration image for package section',
          width: 351,
          height: 240,
        ),
        title: 'Most popular packages',
        info: d
            .text('Some of the most downloaded packages over the past 60 days'),
        content: miniListNode('most-popular', mostPopularPackages!),
        viewAllUrl: urls.listingByPopularity(),
        viewAllEvent: 'landing-most-popular-view-all',
      ),
    if (_isNotEmptyList(topFlutterPackages))
      _block(
        shortId: 'tf',
        image: d.Image(
          src: staticUrls.getAssetUrl('/static/img/landing-02.webp'),
          alt: 'decoration image for package section',
          width: 306,
          height: 240,
        ),
        imageGoesAfterContent: true,
        title: 'Top Flutter packages',
        info: d.text(
            'Some of the top packages that extend Flutter with new features'),
        content: miniListNode('top-flutter', topFlutterPackages!),
        viewAllUrl: SearchForm(query: SdkTag.sdkFlutter).toSearchLink(),
        viewAllEvent: 'landing-top-flutter-view-all',
      ),
    if (_isNotEmptyList(topDartPackages))
      _block(
        shortId: 'td',
        image: d.Image(
          src: staticUrls.getAssetUrl('/static/img/landing-03.webp'),
          alt: 'decoration image for package section',
          width: 370,
          height: 240,
        ),
        title: 'Top Dart packages',
        info: d
            .text('Some of the top packages for any Dart-based app or program'),
        content: miniListNode('top-dart', topDartPackages!),
        viewAllUrl: SearchForm(query: SdkTag.sdkDart).toSearchLink(),
        viewAllEvent: 'landing-top-dart-view-all',
      ),
    if (_isNotEmptyList(topPoWVideos))
      _block(
        shortId: 'pow',
        title: 'Package of the Week',
        info: d.text('Package of the Week is a series of quick, '
            'animated videos, each of which covers a particular package'),
        content: videoListNode(topPoWVideos!),
        viewAllUrl:
            'https://www.youtube.com/playlist?list=PLjxrf2q8roU1quF6ny8oFHJ2gBdrYN_AK',
        viewAllLabel: 'View playlist',
        viewAllEvent: 'package-of-the-week-playlist',
      ),
  ]);
}

bool _isNotEmptyList(List? l) => l != null && l.isNotEmpty;

d.Node _block({
  required String shortId,
  d.Image? image,
  bool imageGoesAfterContent = false,
  required String title,
  required d.Node info,
  required d.Node content,
  required String viewAllUrl,
  required String viewAllEvent,
  String viewAllLabel = 'View all',
}) {
  final isExternalUrl = !viewAllUrl.startsWith('/');
  return d.div(
    classes: ['home-block', 'home-block-$shortId'],
    children: [
      // image: before content
      if (image != null && !imageGoesAfterContent)
        d.div(
          classes: ['home-block-image'],
          child: d.img(image: image, lazy: true),
        ),
      // content
      d.div(
        classes: ['home-block-content'],
        children: [
          d.h1(classes: ['home-block-title'], text: title),
          d.p(classes: ['home-block-context-info'], child: info),
          content,
          d.div(
            classes: ['home-block-view-all'],
            child: d.a(
              classes: ['home-block-view-all-link'],
              href: viewAllUrl,
              target: isExternalUrl ? '_blank' : null,
              rel: isExternalUrl ? 'noopener nofollow' : 'nofollow',
              text: viewAllLabel,
              attributes: {'data-ga-click-event': viewAllEvent},
            ),
          ),
        ],
      ),
      // image: after content
      if (image != null && imageGoesAfterContent)
        d.div(
          classes: ['home-block-image'],
          child: d.img(image: image),
        ),
    ],
  );
}

final _ffInfo = d.fragment([
  d.text('Some of the packages that demonstrate the '),
  d.a(
    href: 'https://flutter.dev/docs/development/packages-and-plugins/favorites',
    target: '_blank',
    rel: 'noopener',
    text: 'highest levels of quality',
  ),
  d.text(', selected by the Flutter Ecosystem Committee'),
]);
