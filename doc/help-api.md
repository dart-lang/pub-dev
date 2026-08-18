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

The response is always a gzip-ed JSON content, and should be cached
on the client side  for at least 2 hours between requests (as indicated
by the `cache-control` header).

Notes:
 * The order of the packages, the number of packages on a response page,
   or the URL structure of `"nextUrl"` may change without notice.


### Package metadata: publisher

**GET** `https://pub.dev/api/packages/<package>/publisher`

**Response**
* `cache-control: public,  max-age=120`
* `content-type: application/json; charset="utf-8"`

```js
{
  "publisherId": "dart.dev"
}
```

The API returns the publisher of the requested `<package>`, or `null` if the
package is not under a publisher.


### Package metadata: score

**GET** `https://pub.dev/api/packages/<package>/score`

**Response**
* `cache-control: public,  max-age=120`
* `content-type: application/json; charset="utf-8"`

```js
{
  "grantedPoints": 160,
  "maxPoints": 160,
  "likeCount": 8297,
  "downloadCount30Days": 11831655,
  "tags": [
    "sdk:dart",
    "sdk:flutter",
    "platform:android",
    /* further tags */
  ],
}
```

The API returns the current scores and score-related metadata for the package:
- `likeCount`: the number of likes on the package
- `downloadCount30Days`: the 30-days download count of the package
- `grantedPoints` / `maxPoints`: the current values of `pana` scores
- `tags`: the tags assigned by `pana` or by `pub.dev`

If a value has not been calculated yet (e.g. for newly created packages) it will be `null`.


### Package daily downloads

**GET** `https://pub.dev/api/packages/<package>/daily-downloads`

**Response**
* `cache-control: public, max-age=120`
* `content-type: application/json; charset="utf-8"`

```js
{
  "newestDate": "2026-08-10T00:00:00.000Z",
  "totalDailyDownloads": [
    150,
    120,
    95,
    -1,
    /* daily download totals for up to 731 days (2 years) */
  ],
  "majorRangeDailyDownloads": [
    {
      "versionRange": ">=1.0.0-0 <2.0.0",
      "counts": [100, 80, 60, /* ... */]
    }
  ],
  "minorRangeDailyDownloads": [
    {
      "versionRange": ">=1.2.0-0 <1.3.0",
      "counts": [70, 50, 40, /* ... */]
    }
  ],
  "patchRangeDailyDownloads": [
    {
      "versionRange": "1.2.3",
      "counts": [30, 20, 15, /* ... */]
    }
  ],
  "versionDailyDownloads": [
    {
      "version": "1.2.3",
      "counts": [30, 20, 15, /* ... */]
    },
    {
      "version": "1.2.0",
      "counts": [40, 30, 25, /* ... */]
    }
  ]
}
```

The API returns daily download totals and version breakdowns for `<package>` going back up to 2 years (731 days):
- `newestDate`: the most recent UTC date for which download data is available.
- `totalDailyDownloads`: list of daily downloads across all versions. The first entry is for `newestDate`, followed by `newestDate - 1 day`, `newestDate - 2 days`, etc. `-1` represents missing or uncollected telemetry on that day.
- `majorRangeDailyDownloads`, `minorRangeDailyDownloads`, `patchRangeDailyDownloads`: lists of version ranges (up to 5 per range level) with daily downloads aligned to the same date indices.
- `versionDailyDownloads`: list of specific package versions and their daily download counts aligned to the same date indices.

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
