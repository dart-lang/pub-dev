// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:test/test.dart';

import 'package:pub_dev/search/index_simple.dart';
import 'package:pub_dev/search/search_service.dart';
import 'package:pub_dev/search/text_utils.dart';

void main() {
  group('haversine', () {
    SimplePackageIndex index;

    setUpAll(() async {
      index = SimplePackageIndex();
      await index.addPackages([
        PackageDocument(
          package: 'haversine',
          version: '0.0.2',
          description: compactDescription(
              'Calculate geographic distance on earth having a pair of '
              'Latitude/Longitude points using the Haversine formula.'),
          readme: compactReadme(r'''# haversine.dart

Simple [Haversine formula](https://en.wikipedia.org/wiki/Haversine_formula) implementation to calculate geographic distance on earth having a pair of Latitude/Longitude points.

> The haversine formula determines the great-circle distance between two points on a sphere given their longitudes and latitudes.
The formula in this library works on the basis of a spherical earth, which is accurate enough for most purposes.

`Disclaimer`: The earth is not quite a sphere. This means that errors from assuming spherical geometry might be considerable depending on the points, so: `don't trust your life on this value`.

Check [this](https://gis.stackexchange.com/questions/25494/how-accurate-is-approximating-the-earth-as-a-sphere#25580) detailed information.'''),
        ),
        PackageDocument(
            package: 'latlong',
            version: '0.3.4',
            description: compactDescription(
                'Lightweight library for common latitude and longitude calculation'),
            readme: compactReadme(
                '''# LatLong provides a lightweight library for common latitude and longitude calculation.

This library supports both, the "Haversine" and the "Vincenty" algorithm.

"Haversine" is a bit faster but "Vincenty" is far more accurate!
 
<p align="center"> 
    <img alt="LatLong" src="https://github.com/MikeMitterer/dart-latlong/raw/master/doc/images/latlong.jpg"> 
</p>

[Catmull-Rom algorithm](http://hawkesy.blogspot.co.at/2010/05/catmull-rom-spline-curve-implementation.html) is used for smoothing out the path.
 
## Basic usage 

### Distance
```dart
    final Distance distance = new Distance();
    
    // km = 423
    final int km = distance.as(LengthUnit.Kilometer,
     new LatLng(52.518611,13.408056),new LatLng(51.519475,7.46694444));
    
    // meter = 422591.551
    final int meter = distance(
        new LatLng(52.518611,13.408056),
        new LatLng(51.519475,7.46694444)
        );

```

## Offset
```dart
    final Distance distance = const Distance();
    final num distanceInMeter = (EARTH_RADIUS * math.PI / 4).round();
    
    final p1 = new LatLng(0.0, 0.0);
    final p2 = distance.offset(p1, distanceInMeter, 180);
    
    // LatLng(latitude:-45.219848, longitude:0.0)
    print(p2.round());
    
    // 45° 13' 11.45" S, 0° 0' 0.00" O
    print(p2.toSexagesimal());
            
```

## Path smoothing
```dart
    // zigzag is a list of coordinates
    final Path path = new Path.from(zigzag);
    
    // Result is below
    final Path steps = path.equalize(8,smoothPath: true);
```
<p align="center"> 
    <img alt="Smooth path" src="https://github.com/MikeMitterer/dart-latlong/raw/master/doc/images/smooth-path.jpg">
</p>

## Features and bugs
Please file feature requests and bugs at the [issue tracker](https://github.com/MikeMitterer/dart-latlong/issues).

## License

    Copyright 2015 Michael Mitterer (office@mikemitterer.at),
    IT-Consulting and Development Limited, Austrian Branch

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing,
    software distributed under the License is distributed on an
    "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND,
    either express or implied. See the License for the specific language
    governing permissions and limitations under the License.


If this plugin is helpful for you - please [(Circle)](http://gplus.mikemitterer.at/) me
or **star** this repo here on GitHub
''')),
        PackageDocument(
          package: 'great_circle_distance',
          version: '0.0.3',
          description: compactDescription(
              'Calculate the great-circle distance on the Earth having a pair of Latitude/Longitude points.'),
          readme: compactReadme(r'''# Great-circle distance

Calculate the great-circle distance on the Earth having a pair of Latitude/Longitude points

The *great-circle distance* is the shortest distance between two points on the surface of a sphere, measured along the surface of the sphere (as opposed to a straight line through the sphere's interior)

Included in this library:

- Spherical law of cosines
- Haversine formula
- Vincenty` formula (por from the Android implementation)

`Disclaimer`: The earth is not quite a sphere. This means that errors([0.3%](https://gis.stackexchange.com/questions/25494/how-accurate-is-approximating-the-earth-as-a-sphere#25580),[0.5%](https://en.wikipedia.org/wiki/Great-circle_distance#cite_note-1) errors) from assuming spherical geometry might be considerable depending on the points; so: `don't trust your life on this value`

Usage example:

````dart
final lat1 = 41.139129;
final lon1 = 1.402244;

final lat2 = 41.139074;
final lon2 = 1.402315;

var gcd = new GreatCircleDistance.fromDegrees(latitude1: lat1, longitude1: lon1, latitude2: lat2, longitude2: lon2);

print('Distance from location 1 to 2 using the Haversine formula is: ${gcd.haversineDistance()}');
print('Distance from location 1 to 2 using the Spherical Law of Cosines is: ${gcd.sphericalLawOfCosinesDistance()}');
print('Distance from location 1 to 2 using the Vicenty`s formula is: ${gcd.vincentyDistance()}');
```

Check Wikipedia for detailed description on [Great-circle distance](https://en.wikipedia.org/wiki/Great-circle_distance)
          '''),
        ),
        PackageDocument(
          package: 'version',
          version: '1.0.2',
          description: compactDescription(
              'Provides a simple class for parsing and comparing semantic versions as defined by http://semver.org/'),
          readme: compactReadme('''# version
[![version 1.0.2](https://img.shields.io/badge/pub-1.0.2-brightgreen.svg)](https://pub.dartlang.org/packages/version)
[![build status](https://api.travis-ci.org/dartalog/version_dart.svg)](https://travis-ci.org/dartalog/version_dart)

A dart library providing a Version object for comparing and incrementing version numbers in compliance with the Semantic Versioning spec at http://semver.org/

# Installation
In your `pubspec.yaml`:

```yaml
dependencies:
  version: ^1.0.0
```

## Usage

A simple usage example:

    import 'package:version/version.dart';
    
    void main() {
      Version currentVersion = new Version(1, 0, 3);
      Version latestVersion = Version.parse("2.1.0");
    
      if (latestVersion > currentVersion) {
        print("Update is available");
      }
    
      Version betaVersion = new Version(2, 1, 0, preRelease: ["beta"]);
      // Note: this test will return false, as pre-release versions are considered
      // lesser then a non-pre-release version that otherwise has the same numbers.
      if (betaVersion > latestVersion) {
        print("More recent beta available");
      }
    }

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/dartalog/version_dart/issues'''),
        ),
        PackageDocument(
          package: 'reversi',
          version: '0.1.1',
          description: compactDescription(
              'This package implements the core algorithm for Reversi (Othello). You have to code your own UI to program a Reversi game. This package bundles with a Reversi console program for demo purpose.'),
          readme: compactReadme(r'''# Reversi in Dart

This repo implements the core algorithm for Reversi. No UI part.

## Install

Install the console program:

```
pub global activate reversi
```

You may install the package locally as a library:

```
dependencies:
  reversi: "^0.2.0"
```

## Usage

Play our console program:

```
$ reversi
Please choose your side (B/b) Black, (W/w) White: b
  |a |b |c |d |e |f |g |h |  
1 |  |  |  |  |  |  |  |  |1 
2 |  |  |  |  |  |  |  |  |2 
3 |  |  |  |  |  |  |  |  |3 
4 |  |  |  |W |B |  |  |  |4 
5 |  |  |  |B |W |  |  |  |5 
6 |  |  |  |  |  |  |  |  |6 
7 |  |  |  |  |  |  |  |  |7 
8 |  |  |  |  |  |  |  |  |8 
  |a |b |c |d |e |f |g |h |  
Please move your disc (a1-h8): c4
  |a |b |c |d |e |f |g |h |  
1 |  |  |  |  |  |  |  |  |1 
2 |  |  |  |  |  |  |  |  |2 
3 |  |  |W |  |  |  |  |  |3 
4 |  |  |B |W |B |  |  |  |4 
5 |  |  |  |B |W |  |  |  |5 
6 |  |  |  |  |  |  |  |  |6 
7 |  |  |  |  |  |  |  |  |7 
8 |  |  |  |  |  |  |  |  |8 
  |a |b |c |d |e |f |g |h |  
Please move your disc (a1-h8): ...
```

## Intro

Dart is a cross-platform programming language capable of web frontend, web backend, mobile, and console applications. The package implemented the core business logic for Reversi. You may utilize this package for diverse applications.

A sample code for classical Reversi:

```
// Default to classical Reversi.
Board b = new Board();

// Default to bot for classical Reversi.
Bot bot = new EasyBot(Disc.White);

// The game loop.
while (true) {
  // You have to implement your own drawBoard function.
  drawBoard(b);
  var isBlackMoved = false;
  var isWhiteMoved = false;

  // The round of black player, who is a man.
  var mbs = b.validMoves(Disc.Black);
  if (!mbs.isEmpty) {
    var mb;
    while (mb == null) {
      stdout.write('Please move your disc (a1-h8): ');
      String p = stdin.readLineSync();
      if (checkMove(p)) {
        var mb = str2Move(p);
        var s = new Set.from(mbs);

        if (s.contains(mb)) {
          b[mb] = Disc.Black;
        } else {
          stderr.writeln('Wrong move');
          continue;
        }

        break;
      } else {
        stderr.writeln('Invalid move');
      }
    }

    isBlackMoved = true;
  } else {
    stderr.writeln('No avaiable Black move');
  }

  // The round of white player, which is bot.
  var mws = b.validMoves(Disc.White);
  if (!mws.isEmpty) {
    var mw = bot.moveBy(b);
    b[mw] = Disc.White;
    isWhiteMoved = true;
  } else {
    stderr.writeln('No avaliable White move');
  }

  if (!isBlackMoved && !isWhiteMoved) {
    break;
  }
}

// Show the final result.
drawBoard(b);
stdout.writeln('Black: ' + b.black().toString());
stdout.writeln('White: ' + b.white().toString());

final w = b.win();
if (w == Win.Black) {
  stdout.writeln('Black player win');
} else if (w == Win.White) {
  stdout.writeln('White player win');
} else {
  stdout.writeln('Tie');
}
```

We shipped a console Reversi program for demo purpose. Currently, there is only one level of bot. See the source of our console program for more details. More bots and applicaions are on the way.

You may implement your own Reversi bot. You only need to fulfill this interface:

```
// Interface
abstract class Bot {
  Move moveBy(Board b) {
    // No implementation.
  }
}

// Implement your own bot.
class MyBot implements Bot {
  // Some fields and methods.

  @override
  Move moveBy(Board b) {
    // Implement it here.
  }
}
```

## Copyright

2017, Michael Chen

## License

MIT'''),
        ),
      ]);
      await index.markReady();
    });

    test('haversine', () async {
      final PackageSearchResult result = await index.search(
          SearchQuery.parse(query: 'haversine', order: SearchOrder.text));
      expect(json.decode(json.encode(result)), {
        'indexUpdated': isNotNull,
        'totalCount': 4,
        'packages': [
          {
            // should be the top
            'package': 'haversine',
            'score': 1.0,
          },
          {
            // should be present
            'package': 'great_circle_distance',
            'score': closeTo(0.72, 0.01),
          },
          {
            // should be present
            'package': 'latlong',
            'score': closeTo(0.71, 0.01),
          },
          {
            // not relevant result, should have low score
            'package': 'reversi',
            'score': closeTo(0.39, 0.01),
          },
        ]
      });
    });

    test('type: hoversine', () async {
      final PackageSearchResult result = await index.search(
          SearchQuery.parse(query: 'hoversine', order: SearchOrder.text));
      expect(json.decode(json.encode(result)), {
        'indexUpdated': isNotNull,
        'totalCount': 3,
        'packages': [
          {
            'package': 'haversine',
            'score': closeTo(0.99, 0.01),
          },
          {
            'package': 'great_circle_distance',
            'score': closeTo(0.72, 0.01),
          },
          {
            'package': 'latlong',
            'score': closeTo(0.71, 0.01),
          },
        ]
      });
    });
  });
}
