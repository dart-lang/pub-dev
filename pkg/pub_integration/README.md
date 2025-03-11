# Screenshots

## Tools

The screenshots are created during the `puppeteer` tests, if the `PUB_SCREENSHOT_DIR`
environment variable is set.

The comparison is created by the `odiff` tool using `docker`. To build the `odiff`
container, user the following command:

```
cd tool
docker build . -f Dockerfile.odiff -t odiff
```

## Before/after screenshots

To create before/after screenshot comparisons, use the following workflow:

1. Run `pkg/pub_integration` tests with `PUB_SCREENSHOT_DIR=/path/to/before/dir`.
1. Make the changes.
1. Run `pkg/pub_integration` tests with `PUB_SCREENSHOT_DIR=/path/to/after/dir`.
1. Run `dart tool/compare_screenshots.dart <before-dir> <after-dir> <diff-dir>`

The comparison will put the files into the `<diff-dir>` with the before/after/diff
versions, alongside a summary `index.html` file to have a quick overview of them.

## Missing features

- Create a better side-by-side comparison for images, as right now everything is just a list of images.
