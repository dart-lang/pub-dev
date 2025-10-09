# Image proxy for pub.dev.


Will forward requests to a url, when given a request like:
```
https://external-image.pub.dev/<base64(hmac(url,hmac_kms(date))>/<date>/<urlencode(url)>
```

date is a "microsecond after epoch" timestamp of a specific date's midnight.

hmac_kms is calculated in KMS with the key version at HMAC_KEY_ID.

## Development

To build the docker image (from the repository root):

```
docker build -t image-proxy-server . --file pkg/image_proxy/Dockerfile
```

