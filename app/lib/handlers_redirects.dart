// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library pub_dartlang_org.handlers_redirects;

const Map<String, String> REDIRECT_PATHS = const <String, String>{
    // /doc/ goes to "Getting started".
    '/doc':                              'get-started.html',
    '/doc/':                             'get-started.html',

    // Redirect from the old names for the commands.
    '/doc/pub-install.html':             'cmd/pub-get.html',
    '/doc/pub-update.html':              'cmd/pub-upgrade.html',

    // Most of the moved docs have the same name.
    '/doc/get-started.html':             'get-started.html',
    '/doc/dependencies.html':            'dependencies.html',
    '/doc/pubspec.html':                 'pubspec.html',
    '/doc/package-layout.html':          'package-layout.html',
    '/doc/assets-and-transformers.html': 'assets-and-transformers.html',
    '/doc/faq.html':                     'faq.html',
    '/doc/glossary.html':                'glossary.html',
    '/doc/versioning.html':              'versioning.html',

    // The command references were moved under "cmd".
    '/doc/pub-build.html':               'cmd/pub-build.html',
    '/doc/pub-cache.html':               'cmd/pub-cache.html',
    '/doc/pub-get.html':                 'cmd/pub-get.html',
    '/doc/pub-lish.html':                'cmd/pub-lish.html',
    '/doc/pub-upgrade.html':             'cmd/pub-upgrade.html',
    '/doc/pub-serve.html':               'cmd/pub-serve.html'
};
