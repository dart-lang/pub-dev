Lighthouse
==========

To setup and run local lighthouse instance, run:

```bash
npm install
dart run_suite.dart
```

Example output:

```
mobile:                                               avg [per, acc, bps, seo, pwa]

/                                                      72 [ 83,  67,  92,  91,  30]
/packages                                              71 [ 82,  78, 100,  75,  20]
/packages/retry                                        73 [ 78,  79, 100,  82,  30]
/packages/retry/versions                               75 [ 81,  82, 100,  82,  30]
/documentation/retry/latest/retry/retry-library.html   77 [ 92,  67, 100, 100,  30]

desktop:                                              avg [per, acc, bps, seo, pwa]

/                                                      74 [ 92,  67, 100,  92,  22]
/packages                                              73 [ 96,  75, 100,  75,  22]
/packages/retry                                        77 [ 95,  88, 100,  83,  22]
/packages/retry/versions                               79 [ 99,  91, 100,  83,  22]
/documentation/retry/latest/retry/retry-library.html   75 [ 98,  64, 100,  92,  22]

total: 74.6
```
