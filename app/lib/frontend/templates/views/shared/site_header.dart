// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import '../../../../account/models.dart' show SessionData;
import '../../../../shared/urls.dart' as urls;
import '../../../dom/dom.dart' as d;
import '../../../static_files.dart' show staticUrls;
import '../../_consts.dart';
import '../../layout.dart' show PageType, showSearchBanner;

/// Creates the site header and navigation node.
d.Node siteHeaderNode({
  required PageType pageType,
  SessionData? userSession,
}) {
  return d.div(
    classes: ['site-header'],
    children: [
      d.button(classes: ['hamburger'], ariaLabel: 'menu toggle'),
      if (pageType != PageType.landing)
        d.a(
          classes: ['logo'],
          href: '/',
          child: d.img(
            classes: ['site-logo'],
            image: d.Image.decorative(
              src: staticUrls.pubDevLogoSvg,
              width: 140,
              height: 30,
            ),
          ),
        ),
      d.div(classes: ['site-header-space']),
      d.div(classes: ['site-header-mask']),
      if (!showSearchBanner(pageType))
        d.div(
          classes: ['site-header-search'],
          child: d.form(
            action: '/packages',
            method: 'GET',
            child: d.input(
              classes: ['site-header-search-input'],
              name: 'q',
              placeholder: 'New search...',
              autocomplete: 'on',
              attributes: {
                'title': 'Search',
              },
            ),
          ),
        ),
      d.nav(
        classes: [
          'site-header-nav',
          'scroll-container',
        ],
        children: [
          if (userSession == null || !userSession.isAuthenticated)
            d.div(
              classes: ['nav-login-container'],
              child: d.button(
                id: '-account-login',
                classes: ['nav-main-button', 'link'],
                text: 'Sign in',
              ),
            )
          else
            d.div(
              id: '-account-profile',
              classes: ['nav-container', 'nav-my-container', 'hoverable'],
              children: [
                d.button(classes: ['nav-main-button'], text: 'My pub.dev'),
                d.div(
                  classes: ['nav-hover-popup'],
                  child: d.div(
                    classes: ['nav-table-column'],
                    children: [
                      _navLink(urls.myPublishersUrl(), myPublishersTabTitle),
                      _navLink(urls.myPackagesUrl(), myPackagesTabTitle),
                      _navLink(
                          urls.myLikedPackagesUrl(), myLikedPackagesTabTitle),
                      _navLink(urls.myActivityLogUrl(), myActivityLogTabTitle),
                      _navLink(urls.createPublisherUrl(), 'Create publisher'),
                    ],
                  ),
                ),
              ],
            ),
          d.div(
            classes: ['nav-container', 'nav-help-container', 'hoverable'],
            children: [
              d.button(classes: ['nav-main-button'], text: 'Help'),
              d.div(
                classes: ['nav-hover-popup'],
                child: d.div(
                  classes: ['nav-table-columns'],
                  children: [
                    _desktopLinksColumn('Pub.dev', _pubDevLinks),
                    _desktopLinksColumn('Flutter', _flutterLinks),
                    _desktopLinksColumn('Dart', _dartLinks),
                  ],
                ),
              ),
            ],
          ),
          _foldableMobileLinks('Pub.dev', _pubDevLinks),
          _foldableMobileLinks('Flutter', _flutterLinks),
          _foldableMobileLinks('Dart', _dartLinks),
          if (userSession != null && userSession.isAuthenticated)
            _userBlock(userSession),
        ],
      ),
    ],
  );
}

d.Node _userBlock(SessionData userSession) {
  return d.div(
    classes: ['nav-container', 'nav-profile-container', 'hoverable'],
    children: [
      // `<input>` here is used to allow keyboard navigation on the page.
      // TODO: consider using a different semantic markup with an inside `<img>` element
      d.input(
        type: 'image',
        classes: ['nav-profile-img', 'nav-profile-image-desktop'],
        attributes: {
          'src': userSession.imageUrl ?? '',
          'alt': 'Profile Image',
        },
      ),
      d.div(
        classes: ['nav-hover-popup'],
        child: d.div(
          classes: ['nav-table-column'],
          children: [
            d.div(
              classes: ['nav-account-title-mobile'],
              children: [
                d.img(
                  classes: ['nav-profile-img', 'nav-profile-img-mobile'],
                  image: d.Image(
                    src: userSession.imageUrl ?? '',
                    alt: 'Profile Image',
                    width: 30,
                    height: 30,
                  ),
                ),
                d.div(
                  classes: ['nav-account-title'],
                  children: [
                    if (userSession.hasName)
                      d.div(
                        classes: ['nav-account-name'],
                        text: userSession.name,
                      ),
                    d.div(
                      classes: ['nav-account-email'],
                      text: userSession.email,
                    ),
                  ],
                ),
              ],
            ),
            d.div(classes: ['nav-separator']),
            d.button(
              id: '-account-switch',
              classes: ['nav-button', 'link'],
              text: 'Switch account',
            ),
            d.button(
              classes: ['nav-button'],
              // DO NOT CHANGE: id=-account-logout
              // Integration tests and auth_helper in post-deployment tests relies on this element
              // being identifiable as #-account-logout when the user is signed-in.
              id: '-account-logout', // DO NOT CHANGE!
              text: 'Sign out',
            ),
          ],
        ),
      ),
    ],
  );
}

final _pubDevLinks = [
  _navNewPage('/help/search', 'Searching for packages'),
  _navNewPage('/help/scoring', 'Package scoring and pub points'),
];

final _flutterLinks = [
  _navNewPage('https://flutter.dev/using-packages/', 'Using packages'),
  _navNewPage('https://flutter.dev/developing-packages/',
      'Developing packages and plugins'),
  _navNewPage(
      '${urls.dartSiteRoot}/tools/pub/publishing', 'Publishing a package'),
];

final _dartLinks = [
  _navNewPage('${urls.dartSiteRoot}/guides/packages', 'Using packages'),
  _navNewPage(
      '${urls.dartSiteRoot}/tools/pub/publishing', 'Publishing a package'),
];

d.Node _navLink(String href, String text) {
  return d.a(classes: ['nav-link'], href: href, text: text);
}

d.Node _navNewPage(String href, String text) {
  return d.a(
    classes: ['nav-link'],
    href: href,
    text: text,
    target: '_blank',
    rel: 'noopener',
  );
}

d.Node _desktopLinksColumn(String label, Iterable<d.Node> children) {
  return d.div(
    classes: ['nav-table-column'],
    children: [
      d.h3(text: label),
      ...children,
    ],
  );
}

d.Node _foldableMobileLinks(String label, Iterable<d.Node> children) {
  return d.div(
    classes: ['nav-container', 'nav-help-container-mobile', 'foldable'],
    children: [
      d.h3(
        classes: ['foldable-button'],
        children: [
          d.text('$label '),
          d.img(
            classes: ['foldable-icon'],
            image: d.Image(
              src: staticUrls
                  .getAssetUrl('/static/img/nav-mobile-foldable-icon.svg'),
              alt: 'toggle folding of the section',
              width: 13,
              height: 6,
            ),
          ),
        ],
      ),
      d.div(
        classes: ['foldable-content'],
        children: children,
      ),
    ],
  );
}
