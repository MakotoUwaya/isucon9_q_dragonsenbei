#!/bin/bash -Ceu

if [ -z "${NEW_RELIC_APP_KEY}" ]; then
    cat >&2 <<EOS
REST API キー (NEW_RELIC_APP_KEY) がないので、デプロイメントマーカーはスキップされました。
EOS
    exit 0
fi
if [ -z "${NEW_RELIC_APP_ID}" ]; then
    cat >&2 <<EOS
App ID (NEW_RELIC_APP_ID) がないので、デプロイメントマーカーはスキップされました。
EOS
    exit 0
fi

curl -Ss -X POST "https://api.newrelic.com/v2/applications/${NEW_RELIC_APP_ID}/deployments.json" \
     -H "X-Api-Key: ${NEW_RELIC_APP_KEY}" \
     -H "Content-Type: application/json" \
     -d \
"{
  \"deployment\": {
    \"revision\": \"$(git rev-parse HEAD)\",
    \"changelog\": \"$(git show -s --format=%s)\",
    \"description\": \"Added a deployments resource to the v2 API\",
    \"user\": \"'$(git show -s --format=%s)' by $(git config user.name)\",
    \"timestamp\": \"$(date -u -Is)\"
  }
}" >/dev/null
