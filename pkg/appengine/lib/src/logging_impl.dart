import 'logging.dart';

abstract class LoggingImpl extends Logging {
  void finish(int responseStatus, int responseSize);
}
