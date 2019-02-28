# Secrets

While the application is open-source, we still need to store and access
secrets, for example SMTP credentials. For that we are using the `Secret`
entity in Datastore, where the `id` is the key of the secret, while the
`value` contains the current credential value.

There is a command-line tool to change the secret value in Datastore:

````bash
bin/tools/set_secret.dart [key] [value]
````

Currently used keys are listed in `SecretKey.values`. For example:
- SMTP account username: `smtp.username`
- SMTP account password: `smtp.password`
- Redis connection string: `redis.connectionString`
- OAuth `secret_key`: `oauth.secret-[client_id]` (used for the site OAuth flow)
