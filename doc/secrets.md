# Secrets

While the application is open-source, we still need to store and access
secrets, for example SMTP credentials.

For that we are using
[secret-manager](https://cloud.google.com/security/products/secret-manager).

Currently used keys are listed in `SecretKey.values`. For example:
- Redis connection string: `redis.connectionString`.
- OAuth `secret_key`: `oauth.secret-[client_id]` (used for the site OAuth flow).
- Announcement banner contains the HTML markup: `announcement`.
- Site-wide upload restrictions: `upload-restriction`.
- Youtube API key: `youtube-api-key`.
