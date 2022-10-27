# `pub.dev` API for developers

## Stay informed

This document describes the officially supported API of the `pub.dev` site.
`pub.dev` may expose API endpoints that are available publicly, but unless
they are documented here, we don't consider them as officially
supported, and may change or remove them without notice.

Changes to the officially supported `pub.dev` API will be announced at [Dart announce][announce].

## Hosted Pub Repository API

`pub.dev` implements the [Hosted Pub Repository Specification V2][repo-v2],
used by the `pub` command line client application.

## Additional APIs

### Package names for name completion

**GET** `https://pub.dev/api/package-name-completion-data`

**Headers:**
* `accept-encoding: gzip`

**Response**
* `cache-control: public, max-age=28800`
* `content-encoding: gzip`
* `content-type: application/json; charset="utf-8"`

```js
{
  "packages": [
    "http",
    "provider",
    /* further package names */
  ]
}
```

The API returns the top package names on `pub.dev`. To reduce payload size the
result may not include all package names. The size limitation is subject to change.

The response is always a gzip-ed JSON content, and should be cached
on the client side  for at least 8 hours between requests (as indicated
by the `cache-control` header).

Notes:
 * Not all package names are included in this response.
 * The order of the packages reflects their overall ranking on `pub.dev`.
 * The inclusion criteria used by `pub.dev` may change without notice.

### Package names for archiving and mirrors

**GET** `https://pub.dev/api/package-names`

**Headers:**
* `accept-encoding: gzip`

**Response**
* `cache-control: public, max-age=28800`
* `content-encoding: gzip`
* `content-type: application/json; charset="utf-8"`

```js
{
  "packages": [
    "http",
    "provider",
    /* further package names */
  ],
  "nextUrl": null /* a client should call this full URL for the next page */
}
```

The API returns all package names on `pub.dev`. The package names are
paginated, clients should call `"nextUrl"` for the next page if it is
present in the response.

Notes:
 * The order of the packages, the number of packages on a response page,
   or the URL structure of `"nextUrl"` may change without notice.
 * Clients should always use `gzip` content encoding, as it will be mandatory
   for this API in the near future.


## FAQ

### I'd like to implement search, what API can I use?

Please use the above [package names for name completion data](#package-names-for-name-completion)
to fetch the list of package names, and implement search in your app based on that list.

### I'd like to request a new API. What should I do?

Please check if there is already a similar request or open a [new issue][pub-dev-issues].
The following requirements are must have for an API endpoint to be considered as official:
 * The data must be public.
 * The API must be without side effects (e.g. read-only).
 * The response must be cacheable (e.g. we should be able to offload it to a CDN).

[announce]: https://groups.google.com/a/dartlang.org/g/announce
[repo-v2]: https://github.com/dart-lang/pub/blob/master/doc/repository-spec-v2.md
[pub-dev-issues]: https://github.com/dart-lang/pub-dev/issues
