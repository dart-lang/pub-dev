#! /bin/bash
for protofile in $(find internal -name "*.proto"); do
  # -I option not needed as these protofiles have no includes.
  protoc --dart_out=. $protofile
done

for protofile in $(find external -name "*.proto"); do
  # -I option not needed as these protofiles have no includes.
  protoc --dart_out=. $protofile
done
