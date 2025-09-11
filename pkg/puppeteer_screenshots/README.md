# Screenshots

This tool helps create and compare screenshots before/after changes that affect visual styles.

## Creating screenshots

The screenshots are created during the `puppeteer` tests, if the `SCREENSHOT_DIR`
environment variable is set.

The tests are instrumented with calls to take screenshots on selected parts of
the screens. During the method call, it will change the viewport and the main
theme of the page, taking 6 screenshots for each call.

## Before/after screenshots

To create before/after screenshot comparisons, use the following workflow:

1. Generate screenshots by running tests with `SCREENSHOT_DIR=/path/to/before/dir`.
1. Make the changes.
1. Generate screenshots by running tests with `SCREENSHOT_DIR=/path/to/after/dir`.
1. Run `dart bin/compare_screenshots.dart <before-dir> <after-dir> <diff-dir>`

The comparison will put the files into the `<diff-dir>` with the before/after/diff
versions, alongside a summary `index.html` file to have a quick overview of them.

### Required tool for comparisons

The comparison is created by the `odiff` tool running in a container using `docker`.
To build the `odiff` container, user the following command:

```
cd tool
docker build . -f Dockerfile.odiff -t odiff
```

## Missing features

- Create a better side-by-side comparison for images, as right now everything is only a list of images.
