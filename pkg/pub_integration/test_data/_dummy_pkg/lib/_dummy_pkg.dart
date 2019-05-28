import 'package:retry/retry.dart';

/// Say hello
void sayHello() {
  retry(() {
    print('hello world');
  }, retryIf: (e) => true); // retry, if there was an Exception
}
