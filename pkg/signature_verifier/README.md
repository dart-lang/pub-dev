This is a simple command line tool to verify the signature of a file.

It is written to mirror the functionality of the OpenSSL command:

```
openssl dgst -sha256 -verify <pubKey> -signature <sig> <input>
```