# [![Build Status](https://travis-ci.org/dart-lang/build.svg?branch=master)](https://travis-ci.org/dart-lang/build)

# `build_barback`

Allows wrapping up a `Builder` as a `Transformer` so that it can be run in `pub`
or vice-versa.

## Using a `Builder` from Pub

Wrap the `Builder` instance with `new BuilderTransformer(builder)` and use it
like any other Transformer. The Builder used this way must follow the rules of
other Transformers, it cannot use inputs from outside the package where the
Transformer is specified in pubspec.yaml

## Using an exisiting `Transformer` with `package:build`

Wrap the `Transformer` instance with `new TransformerBuilder(transformer)` and
run as any other `Builder`. The Transformer instance used this way must follow
the rules of other Builders:
- It cannot overwrite files it uses as inputs.
- It must know before building what the outputs will be (it must be a
  `DeclaringTransformer`).

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/dart-lang/build/issues
