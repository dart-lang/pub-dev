import 'dart:async' show scheduleMicrotask, Completer;
import 'dart:convert' show utf8;
import 'package:shelf/shelf.dart' show Request, Response;
import 'package:logging/logging.dart' show Logger;
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:googleapis/datastore/v1.dart' as datastore;
import 'package:ulid/ulid.dart' show Ulid;
import 'package:gcloud/storage.dart' show Bucket;
import 'package:stack_trace/stack_trace.dart' show Trace;

import '../../shared/configuration.dart' show activeConfiguration;

final _log = Logger('pub.cronjobs');

class CronJobs {
  final Bucket backupBucket;

  CronJobs(this.backupBucket);

  /// Handle a request from the AppEngine cron job scheduler.
  ///
  /// Request will succeed if we match it up with a cron-job. This handler
  /// returns 200 OK, before the cron-job is completed to avoid timeouts from
  /// the load-balancer. But it keeps the request open by sending spaces until
  /// the cron-job handler is done, while we won't retry failed jobs, this
  /// ensures that instances won't be cycled while jobs are running.
  ///
  /// Note. it's recommened to configure an alert to fire if a log message from
  /// the cron job doesn't show at a reasonable interval.
  Future<Response> handler(Request request) async {
    final path = request.requestedUri.path;
    final job = _resolve(path);
    if (job == null) {
      _log.shout('### Cron job not found: $path');
      return Response.notFound('no-such-cron-job');
    }

    _log.info('### Cron starting: $path');
    final c = Completer<bool>();
    scheduleMicrotask(() async {
      bool ok = false;
      try {
        ok = await job();
        if (!ok) {
          _log.shout('### Cron failed: $path');
        } else {
          _log.info('### Cron successful: $path');
        }
      } catch (e, st) {
        _log.shout('### Cron failed: $path, ', e, Trace.from(st));
        ok = false;
      } finally {
        c.complete(ok);
      }
    });

    // Stream spaces as response to prevent the load-balancer from breaking
    // the connection.
    return Response.ok(() async* {
      while (!c.isCompleted) {
        // Print a space every second, while we wait for c to be completed
        yield [0x20];
        await Future.delayed(Duration(seconds: 1));
      }
      final ok = await c.future;
      if (!ok) {
        // Sadly, we can't tell the cron-job scheduler if the cron-job failed.
        // It only retries if the response code is not 2xx, but we had to send
        // the response code immediately to avoid a time-out.
        yield utf8.encode('\nfailed cron-job: $path');
        return;
      }
      yield utf8.encode('\nfinished cron-job: $path');
    }());
  }

  /// Map from path to cronjob.
  Future<bool> Function() _resolve(String path) {
    return <String, Future<bool> Function()>{
      '/cron/datastore-backup': datastoreBackup,
    }[path];
  }

  /// Backup datastore
  Future<bool> datastoreBackup() async {
    if (backupBucket == null) {
      _log.shout('datastore backup not configured!!!');
      return false;
    }

    // Get credentials via. metadata service (this only works on GCP/AppEngine)
    final client = await auth.clientViaMetadataServer();
    try {
      // Create a unique job id, in case multiple jobs are trigger concurrently
      final id = Ulid().toString();

      // Get date as: YYYY-MM-DD
      final date = DateTime.now().toUtc().toIso8601String().split('T').first;

      // Start the backup operation
      _log.info('starting datastore backup: $date/job-$id');
      final api = datastore.DatastoreApi(client);
      var op = await api.projects.export(
        datastore.GoogleDatastoreAdminV1ExportEntitiesRequest()
          ..outputUrlPrefix = 'gs://${backupBucket.bucketName}/$date/job-$id/',
        activeConfiguration.projectId,
      );

      // Refresh long-running operation until it's done
      while (op.done != true) {
        await Future.delayed(Duration(seconds: 30));
        _log.info('checking status of backup operation: ${op.name}');
        op = await api.projects.operations.get(op.name);
      }
      if (op.error != null) {
        _log.shout(
            'datastore backup job $date/job-$id failed: ${op.error.message}');
        return false;
      }
      _log.info('datastore backup job $date/job-$id completed successfully');
      return true;
    } finally {
      client.close();
    }
  }
}
