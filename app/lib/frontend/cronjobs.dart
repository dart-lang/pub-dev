import 'package:shelf/shelf.dart' show Request, Response;
import 'package:logging/logging.dart' show Logger;
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:googleapis/datastore/v1.dart' as datastore;
import 'package:ulid/ulid.dart' show Ulid;

final _log = new Logger('pub.cronjobs');

class CronJobs {
  final String backupBucketName;

  CronJobs({
    this.backupBucketName,
  });

  Future<Response> handler(Request request) async {
    final job = _resolve(request.url.path);
    if (job == null) {
      return Response.notFound('no-such-cron-job');
    }
    _log.finest('### Cron: ${request.url.path}');
    final ok = await job();
    if (!ok) {
      _log.shout('### Cron failed: ${request.url.path}');
      return Response.internalServerError(
        body: 'cron failed ${request.url.path}',
      );
    }
    _log.finest('### Cron successful: ${request.url.path}');
    return Response.ok('cron successful: ${request.url.path}');
  }

  /// Map from path to cronjob.
  Future<bool> Function() _resolve(String path) {
    return <String, Future<bool> Function()>{
      '/cron/datastore-backup': datastoreBackup,
    }[path];
  }

  /// Backup datastore
  Future<bool> datastoreBackup() async {
    if (backupBucketName == null) {
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
      _log.finest('starting datastore backup: $date/job-$id');
      final api = datastore.DatastoreApi(client);
      var op = await api.projects.export(
        datastore.GoogleDatastoreAdminV1ExportEntitiesRequest()
          ..outputUrlPrefix = 'gs://$backupBucketName/$date/job-$id/',
        'dartlang-pub',
      );

      // Refresh long-running operation until it's done
      while (!op.done) {
        op = await api.projects.operations.get(op.name);
        await Future.delayed(Duration(seconds: 30));
      }
      if (op.error != null) {
        _log.shout(
            'datastore backup job $date/job-$id failed: ${op.error.message}');
        return false;
      }
      _log.finest('datastore backup job $date/job-$id completed successfully');
      return true;
    } finally {
      client.close();
    }
  }
}
