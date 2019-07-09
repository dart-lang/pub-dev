import 'dart:convert';
import 'package:meta/meta.dart' show required;

/// Utility to wrapping a function as a [Converter].
///
/// This class creates a [Converter] that can convert from `S` to `T`.
class _WrapAsConverter<S, T> extends Converter<S, T> {
  final T Function(S) _convert;
  const _WrapAsConverter(this._convert);
  @override
  T convert(S input) => _convert(input);
}

/// Utility for wrapping two functions as a [Codec].
///
/// The [_WrapAsCodec] class creates a [Codec] that can encode `S` as a `T`.
/// And decode an `T` into an `S`.
class _WrapAsCodec<S, T> extends Codec<S, T> {
  final Converter<S, T> _encoder;
  final Converter<T, S> _decoder;

  _WrapAsCodec({
    @required T Function(S) encode,
    @required S Function(T) decode,
  })  : _encoder = _WrapAsConverter(encode),
        _decoder = _WrapAsConverter(decode);

  @override
  Converter<S, T> get encoder => _encoder;
  @override
  Converter<T, S> get decoder => _decoder;
}

/// Wrap [encode] and [decode] functions as [Codec] that can encode `S` as `T`.
Codec<S, T> wrapAsCodec<S, T>({
  @required T Function(S) encode,
  @required S Function(T) decode,
}) =>
    _WrapAsCodec(
      encode: encode,
      decode: decode,
    );
