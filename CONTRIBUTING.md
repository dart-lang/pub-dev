Want to contribute? Great! First, read this page (including the small print at
the end).

### Filing issues

In your issue, make sure to include the following items:

- Add a descriptive title, e.g. include package name, search term or the specific error label from the analysis tab.
- URL of the page you are reporting something (using the "Report an issue" link on the page does this).
- Screenshot of the page (if relevant).
- The device you are using (if relevant).

### Before you contribute code

Before you start working on a larger contribution, you should get in touch with
us first through the issue tracker with your idea so that we can help out and
possibly guide you. Coordinating up front makes it much easier to avoid
frustration later on.

Before we can use your code, you must sign the
[Google Individual Contributor License Agreement][CLA] (CLA), which you can do
online. The CLA is necessary mainly because you own the copyright to your
changes, even after your contribution becomes part of our codebase, so we need
your permission to use and distribute your code. We also need to be sure of
various other things—for instance that you'll tell us if you know that your code
infringes on other people's patents. You don't have to sign the CLA until after
you've submitted your code for review and a member has approved it, but you must
do it before we can put your code into our codebase.

[CLA]: https://cla.developers.google.com/about/google-individual

### Code reviews

All submissions, including submissions by project members, require review. We
recommend [forking the repository][fork], making changes in your fork, and
[sending us a pull request][pr] so we can review the changes and merge them into
this repository. Note that this package doesn't use the Dart formatter. The
reviewer will reformat your code themselves if necessary.

[fork]: https://help.github.com/articles/about-forks/
[pr]: https://help.github.com/articles/creating-a-pull-request/

Functional changes will require tests to be added or changed. The tests live in
the `test/` directory, and are run with `dart test`. If you need to create
new tests, use the existing tests as a guideline for what they should look like.

Before you send your pull request, make sure all the tests pass! Just run 
`dart test`.

### File headers

All files in the project must start with the following header.

```
// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
```

### TODO style:
Prefer creating an issue for every TODO, and write it on the form:

```
// TODO(https://github.com/dart-sdk/pub-dev/issues/#123): We should do blah blah...
```

That way the tasks can be triaged and referred.

### The small print

Contributions made by corporations are covered by a different agreement than the
one above, the
[Software Grant and Corporate Contributor License Agreement][CCLA].

[CCLA]: https://developers.google.com/open-source/cla/corporate
