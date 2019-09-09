// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:client_data/page_data.dart';

import '../../publisher/models.dart' show Publisher;
import '../../shared/markdown.dart';

import '_cache.dart';
import 'layout.dart';

/// Renders the `views/publisher/create.mustache` template.
String renderCreatePublisherPage() {
  final String content = templateCache.renderTemplate('publisher/create', {});
  return renderLayoutPage(PageType.standalone, content,
      title: 'Create publisher');
}

/// Renders the `views/publisher/show.mustache` template.
String renderPublisherPage(Publisher publisher) {
  final String content = templateCache.renderTemplate('publisher/show', {
    'publisher_id': publisher.publisherId,
    'description_html': markdownToHtml(publisher.description, null),
  });
  return renderLayoutPage(
    PageType.publisher,
    content,
    title: 'Publisher: ${publisher.publisherId}',
    pageData: PageData(
        publisher: PublisherData(
      publisherId: publisher.publisherId,
    )),
  );
}

/// Renders the `views/publisher/admin_page.mustache` template.
String renderPublisherAdminPage(Publisher publisher) {
  final String content = templateCache.renderTemplate('publisher/admin_page', {
    'publisher_id': publisher.publisherId,
    'description': publisher.description,
    'website_url': publisher.websiteUrl,
    'contact_email': publisher.contactEmail,
  });
  return renderLayoutPage(
    PageType.publisher,
    content,
    title: 'Publisher: ${publisher.publisherId}',
    pageData: PageData(
      publisher: PublisherData(
        publisherId: publisher.publisherId,
      ),
    ),
  );
}
