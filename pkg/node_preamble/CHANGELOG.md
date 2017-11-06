## 1.4.0

* Add __dirname and __filename to exposed globals. Adds ability of exposing more
  globals in the preamble by calling `getPreamble(additionalGlobals: ["__dirname", ...])`.

## 1.3.0

* Add minified versions of the preamble accessible as `lib/preamble.min.js` and
  by calling `getPreamble(minified: true)`.

## 1.2.0

* Prevent encapsulation, `global.self = global` (old) vs.
  `var self = Object.create(global)` (new).

## 1.1.0

* Set `global.location` so that `Uri.base()` works properly on Windows in most
  cases.

* Define `global.exports` so that it's visible to the compiled JS.
