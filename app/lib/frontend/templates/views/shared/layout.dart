// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import '../../../../admin/models.dart';
import '../../../../shared/configuration.dart';
import '../../../../shared/urls.dart' as urls;
import '../../../dom/dom.dart' as d;
import '../../../request_context.dart';
import '../../../static_files.dart' show staticUrls;

d.Node pageLayoutNode({
  required String title,
  required String description,
  required String? canonicalUrl,
  required String faviconUrl,
  required bool noIndex,
  required String? csrfToken,
  required String? pageDataEncoded,
  required List<String>? bodyClasses,
  required d.Node siteHeader,
  required d.Node? announcementBanner,
  required String announcementBannerHash,
  required d.Node? searchBanner,
  required bool isLanding,
  required d.Node? landingBlurb,
  required List<String> mainClasses,
  required d.Node mainContent,
  required bool includeHighlightJs,
  required Map<String, dynamic>? schemaOrgSearchActionJson,
  required String? moderationUrl,
  required ModerationSubject? moderationSubject,
}) {
  return d.fragment([
    d.unsafeRawHtml('<!DOCTYPE html>\n'),
    d.element(
      'html',
      attributes: {'lang': 'en-us'},
      children: [
        d.element(
          'head',
          children: [
            d.script(
              src: 'https://www.googletagmanager.com/gtm.js?id=GTM-MX6DBN9',
              async: true,
            ),
            d.script(
              src: staticUrls.getAssetUrl('/static/js/gtm.js'),
              async: true,
            ),
            d.meta(charset: 'utf-8'),
            d.meta(httpEquiv: 'x-ua-compatible', content: 'ie=edge'),
            d.meta(
              name: 'viewport',
              content: 'width=device-width, initial-scale=1',
            ),
            if (noIndex) d.meta(name: 'robots', content: 'noindex'),

            // <!-- Twitter tags -->
            d.meta(name: 'twitter:card', content: 'summary'),
            d.meta(name: 'twitter:site', content: '@dart_lang'),
            d.meta(name: 'twitter:description', content: description),
            d.meta(
              name: 'twitter:image',
              content:
                  '${urls.siteRoot}${staticUrls.getAssetUrl('/static/img/pub-dev-icon-cover-image.png')}',
            ),

            // <!-- Facebook OG tags -->
            d.meta(property: 'og:type', content: 'website'),
            d.meta(property: 'og:site_name', content: 'Dart packages'),
            d.meta(property: 'og:title', content: title),
            d.meta(property: 'og:description', content: description),
            d.meta(
              property: 'og:image',
              content:
                  '${urls.siteRoot}${staticUrls.getAssetUrl('/static/img/pub-dev-icon-cover-image.png')}',
            ),
            if (!noIndex && canonicalUrl != null)
              d.meta(property: 'og:url', content: canonicalUrl),

            d.element('title', text: title),
            d.link(
              rel: 'stylesheet',
              href:
                  'https://fonts.googleapis.com/css2?family=Google+Sans:wght@400;500;700&family=Google+Sans+Display:wght@400&family=Google+Sans+Text:wght@400;500;700&family=Google+Sans+Mono:wght@400;700&display=swap',
            ),
            d.link(rel: 'shortcut icon', href: faviconUrl),
            d.link(
                rel: 'stylesheet',
                href: 'https://www.gstatic.com/glue/v25_0/ccb.min.css'),
            d.link(
              rel: 'search',
              type: 'application/opensearchdescription+xml',
              title: 'Dart packages',
              href: '/osd.xml',
            ),
            if (canonicalUrl != null)
              d.link(rel: 'canonical', href: canonicalUrl),

            d.meta(name: 'description', content: description),
            d.link(
              rel: 'alternate',
              type: 'application/atom+xml',
              title: 'Updated Packages Feed for Pub',
              href: '/feed.atom',
            ),
            d.link(
              rel: 'stylesheet',
              type: 'text/css',
              href:
                  staticUrls.getAssetUrl('/static/material/bundle/styles.css'),
            ),
            d.link(
              rel: 'stylesheet',
              type: 'text/css',
              href: staticUrls.getAssetUrl('/static/css/style.css'),
            ),
            d.script(
              src: staticUrls
                  .getAssetUrl('/static/material/bundle/script.min.js'),
              defer: true,
            ),
            d.script(
              src: staticUrls.getAssetUrl('/static/js/script.dart.js'),
              defer: true,
            ),
            d.script(
              src:
                  'https://www.gstatic.com/brandstudio/kato/cookie_choice_component/cookie_consent_bar.v3.js',
              defer: true,
              attributes: {'data-autoload-cookie-consent-bar': 'true'},
            ),
            if (csrfToken != null && csrfToken.isNotEmpty)
              d.meta(name: 'csrf-token', content: csrfToken),
            if (pageDataEncoded != null)
              d.meta(name: 'pub-page-data', content: pageDataEncoded),
            if (isLanding) ...[
              d.link(
                rel: 'preload',
                href: staticUrls.getAssetUrl('/static/img/hero-bg-static.svg'),
                as: 'image',
              ),
              d.link(
                rel: 'preload',
                href: staticUrls
                    .getAssetUrl('/static/img/square-bg-full-2x.webp'),
                as: 'image',
              ),
            ],
            if (includeHighlightJs)
              d.link(
                rel: 'preload',
                href: staticUrls
                    .getAssetUrl('/static/highlight/highlight-with-init.js'),
                as: 'script',
              ),
          ],
        ),
        d.element(
          'body',
          classes: [
            ...?bodyClasses,
            if (requestContext.experimentalFlags.isDarkModeEnabled)
              '-experimental-dark-mode',
            requestContext.experimentalFlags.isDarkModeDefault
                ? 'dark-theme'
                : 'light-theme',
            if (activeConfiguration.isStaging) 'staging-banner',
          ],
          children: [
            // The initialization of dark theme must be in a synchronous, blocking
            // script execution, as otherwise users may see flash of unstyled content
            // (usually white background instead of a dark theme).
            d.script(src: staticUrls.getAssetUrl('/static/js/dark-init.js')),
            if (activeConfiguration.isStaging)
              d.div(classes: ['staging-ribbon'], text: 'staging'),
            // <!-- Google Tag Manager (noscript) -->
            d.element(
              'noscript',
              child: d.element(
                'iframe',
                attributes: {
                  'src':
                      'https://www.googletagmanager.com/ns.html?id=GTM-MX6DBN9',
                  'height': '0',
                  'width': '0',
                  'style': 'display:none;visibility:hidden',
                },
              ),
            ),
            siteHeader,
            d.div(
              id: 'banner-container',
              children: [
                if (announcementBanner != null)
                  d.div(
                    classes: ['announcement-banner', 'dismissed'],
                    children: [
                      announcementBanner,
                      d.div(
                        classes: ['dismisser'],
                        attributes: {
                          'data-widget': 'switch',
                          'data-switch-target': '.announcement-banner',
                          'data-switch-enabled': 'dismissed',
                          'data-switch-initial-state': 'false',
                          'data-switch-state-id': announcementBannerHash,
                        },
                        text: 'x',
                      ),
                    ],
                  ),
              ],
            ),
            if (searchBanner != null)
              d.div(
                classes: ['_banner-bg'],
                child: d.div(
                  classes: ['container', if (isLanding) 'home-banner'],
                  children: [
                    if (isLanding)
                      d.fragment([
                        d.h2(
                          classes: ['_visuallyhidden'],
                          text: 'pub.dev package manager',
                        ),
                        d.img(
                          classes: ['logo'],
                          image: d.Image.decorative(
                            src: staticUrls.pubDevLogoSvg,
                            width: 328,
                            height: 70,
                          ),
                        ),
                      ]),
                    searchBanner,
                    if (isLanding)
                      d.fragment([
                        landingBlurb!,
                        d.img(
                          image: d.Image(
                            src: staticUrls.getAssetUrl(
                                '/static/img/supported-by-google-2x.png'),
                            alt: 'Supported by Google',
                            width: 218,
                            height: 36,
                          ),
                        ),
                      ]),
                  ],
                ),
              ),

            d.element('main', classes: mainClasses, child: mainContent),
            _siteFooterNode(
              moderationUrl: moderationUrl,
              moderationSubject: moderationSubject,
            ),
            if (includeHighlightJs)
              d.fragment([
                d.script(
                  src: staticUrls
                      .getAssetUrl('/static/highlight/highlight-with-init.js'),
                  defer: true,
                ),
              ]),
            if (schemaOrgSearchActionJson != null)
              d.ldJson(schemaOrgSearchActionJson),
          ],
        )
      ],
    ),
  ]);
}

/// Renders the footer content.
///
/// The [moderationUrl] must be the canonical URL for the current page
/// (note: may not be displayed as canonical URL in case of admin pages).
d.Node _siteFooterNode({
  required String? moderationUrl,
  required ModerationSubject? moderationSubject,
}) {
  d.Node link(String href, String label, {bool sep = true}) =>
      d.a(classes: ['link', if (sep) 'sep'], href: href, text: label);

  d.Node icon(
          String linkHref, List<String> classes, d.Image icon, String title) =>
      d.a(
        classes: ['link', 'icon', ...classes],
        href: linkHref,
        child: d.img(
          classes: ['inline-icon'],
          title: title,
          image: icon,
        ),
      );

  final moderationNode = () {
    if (moderationSubject == null || moderationUrl == null) {
      return null;
    }
    if (moderationSubject.package != null) {
      return link(
        urls.reportPage(
          subject: moderationSubject.fqn,
          url: moderationUrl,
        ),
        'Report package',
      );
    }
    if (moderationSubject.publisherId != null) {
      return link(
        urls.reportPage(
          subject: moderationSubject.fqn,
          url: moderationUrl,
        ),
        'Report publisher',
      );
    }
    throw ArgumentError('Unknown subject: ${moderationSubject.fqn}');
  }();

  return d.element(
    'footer',
    classes: ['site-footer'],
    children: [
      link('${urls.dartSiteRoot}/', 'Dart language', sep: false),
      if (moderationNode != null) moderationNode,
      link('/policy', 'Policy'),
      link('https://www.google.com/intl/en/policies/terms/', 'Terms'),
      link('https://developers.google.com/terms/', 'API Terms'),
      link('/security', 'Security'),
      link('https://www.google.com/intl/en/policies/privacy/', 'Privacy'),
      link('/help', 'Help'),
      icon(
        '/feed.atom',
        ['sep'],
        d.Image(
          src: staticUrls.getAssetUrl('/static/img/rss-feed-icon.svg'),
          alt: 'RSS',
          width: 20,
          height: 20,
        ),
        'RSS/atom feed',
      ),
      icon(
        'https://github.com/dart-lang/pub-dev/issues/new',
        ['github_issue'],
        d.Image(
          src: staticUrls.getAssetUrl('/static/img/bug-report-white-96px.png'),
          alt: 'bug report',
          width: 20,
          height: 20,
        ),
        'Report an issue with this site',
      ),
    ],
  );
}
