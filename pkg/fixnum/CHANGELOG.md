## 0.10.6

* Fix `Int64([int value])` constructor to avoid rounding error on intermediate
  results for large negative inputs when compiled to JavaScript. `new
  Int64(-1000000000000000000)` used to produce the same value as
  `Int64.parseInt("-1000000000000000001")`

## 0.10.5

* Fix strong mode warning in overridden `compareTo()` methods.

*No changelog entries for previous versions...*
