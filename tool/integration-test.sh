#!/bin/bash -e
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PROJECT_DIR="$( cd ${SCRIPT_DIR}/.. && pwd )"
PUB_INTEGRATION_DIR="$( cd ${PROJECT_DIR}/pkg/pub_integration && pwd )"

cd ${PUB_INTEGRATION_DIR};
pub get

## Runs integration test against staging or prod server.
## Options:
##   --pub-hosted-url (or PUB_HOSTED_URL)
##   --verifier-email (or git config user.email)
##   --invited-email  (account to invite)
##   --credentials-json (or HOME/.pub-cache/credentials.json
dart bin/pub_integration.dart $*
