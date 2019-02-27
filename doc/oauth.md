# OAuth

## Audiences

The site uses two oauth audiences to communicate with two separate oauth flows:

- The *client* audience is used by the `pub` command-line client, to get an
  offline token to use with the pub site.

- The *site* audience is used by the pub site to re-authenticate the user for
  narrow, targeted goals, e.g. confirming adding oneself to the uploaders of a
  package, or logging in to the site.

These audiences are set and configured in the `app/lib/shared/configuration.dart`
file: `pubClientAudience` is fixed to the same audience the `pub` client is using,
while `pubSiteAudience` is changed based on the environment we are using.

The pub site audience's secret is stored as a `Secret` entity in Datastore, see
[secrets.md](secrets.md) for further details.

## OAuth administration

Register a new OAuth client ID:

- Visit the gcloud [Credentials page of the project](https://console.cloud.google.com/apis/credentials).
- Click "Create credentials" / "OAuth client ID".
- Select "Web application".
- Set the restrictions as below.

URL restrictions:

On the create flow above, or by editing the client make sure the following
URLs are added under the *Authorized redirect URIs* section:

- `http://localhost:8080/oauth/callback` (for development only)
- `https://pub.dartlang.org/oauth/callback` (for prod only)
