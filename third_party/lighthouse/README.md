# Lighthouse

To setup and run local lighthouse instance, run:

```bash
npm install
dart run_suite.dart
```

## Results

mobile:                                               light/dark accessibility

/                                                     94/ 90
/help                                                 85/ 89
/packages                                             84/ 80
/packages/retry                                       82/ 82
/packages/retry/versions                              86/ 82
/packages/retry/score                                 79/ 79
/documentation/retry/latest/retry/retry-library.html  86/ 86

desktop:                                              light/dark accessibility

/                                                     98/ 94
/help                                                 88/ 92
/packages                                             87/ 84
/packages/retry                                       84/ 84
/packages/retry/versions                              88/ 84
/packages/retry/score                                 82/ 82
/documentation/retry/latest/retry/retry-library.html  80/ 80

total: 85.4
