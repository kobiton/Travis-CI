#!/bin/bash
set -ex

printf "\n=====================================================================================\n"
printf "KOBITON APP UPLOAD PLUGIN"
printf "\n=====================================================================================\n\n"

printf "Installing ack...\n"
sudo chmod 755 /usr/local/bin
sudo bash -c "curl -L https://beyondgrep.com/ack-v3.5.0 >/usr/local/bin/ack"
sudo chmod 755 /usr/local/bin/ack

printf "Finish downloading ack\n"

hash ack 2>/dev/null || {
    echo >&2 "ack required, but it's not installed."
    exit 1
}

BASICAUTH=$(echo -n "$KOBI_USERNAME":"$KOBI_API_KEY" | base64)

echo "Using Auth: $BASICAUTH"

if [ -z "$APP_ID" ]; then
    JSON=("{\"filename\":\"${APP_NAME}.${APP_SUFFIX}\"}")
else
    JSON=("{\"filename\":\"${APP_NAME}.${APP_SUFFIX}\",\"appId\":$APP_ID}")
fi

curl --silent -X POST https://api.kobiton.com/v1/apps/uploadUrl \
    -H "Authorization: Basic $BASICAUTH" \
    -H 'Content-Type: application/json' \
    -H 'Accept: application/json' \
    -d "${JSON[@]}" \
    -o ".tmp.upload-url-response.json"

cat ".tmp.upload-url-response.json"

UPLOAD_URL=$(ack -o -h --match '(?<=url\":")([_\%\&=\?\.aA-zZ0-9:/-]*)' ".tmp.upload-url-response.json")
KAPPPATH=$(ack -o -h --match '(?<=appPath\":")([_\%\&=\?\.aA-zZ0-9:/-]*)' ".tmp.upload-url-response.json")

echo "Uploading: ${APP_NAME} (${APP_PATH})"
echo "URL: ${UPLOAD_URL}"

curl --progress-bar -T "${APP_PATH}" \
    -H "Content-Type: application/octet-stream" \
    -H "x-amz-tagging: unsaved=true" \
    -X PUT "${UPLOAD_URL}"
#--verbose

echo "Processing: ${KAPPPATH}"

JSON=("{\"filename\":\"${APP_NAME}.${APP_SUFFIX}\",\"appPath\":\"${KAPPPATH}\"}")
curl -X POST https://api.kobiton.com/v1/apps \
    -H "Authorization: Basic $BASICAUTH" \
    -H 'Content-Type: application/json' \
    -d "${JSON[@]}" \
    -o ".tmp.upload-app-response.json"

echo "Response:"
cat ".tmp.upload-app-response.json"

APP_VERSION_ID=$(ack -o -h --match '(?<=versionId\":)([_\%\&=\?\.aA-zZ0-9:/-]*)' ".tmp.upload-app-response.json")

# Kobiton need some times to update the appId for new appVersion
sleep 30

curl -X GET https://api.kobiton.com/v1/app/versions/"$APP_VERSION_ID" \
    -H "Authorization: Basic $BASICAUTH" \
    -H "Accept: application/json" \
    -o ".tmp.get-appversion-response.json"

APP_ID=$(ack -o -h --match '(?<=appId\":)([_\%\&=\?\.aA-zZ0-9:/-]*)' ".tmp.get-appversion-response.json")

curl -X PUT https://api.kobiton.com/v1/apps/"$APP_ID"/"$APP_ACCESS" \
    -H "Authorization: Basic $BASICAUTH"

echo "Uploaded app to kobiton repo with appId: ${APP_ID} and versionId: ${APP_VERSION_ID}"
echo "Done"
