Simple Cache
============

Abstractions around in-memory caches stores such as redis, with support for
timeouts and automatic reconnects.

## Testing
To test the redis `CacheProvider` a redis instance must be running on
`localhost:6379`, this can be setup with:

 * `docker run --rm -p 127.0.0.1:6379:6379 redis`
