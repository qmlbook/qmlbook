
curl --include \
      --request POST \
      --header "Content-Type: application/json" \
      --header "Authorization: Basic <ONESIGNAL-REST-API-KEY>" \
      --data-binary '{
         "app_id": "<ONESIGNAL-APP-ID>",
         "contents": { "en": "Message" },
         "tags": [{"key": "my_key", "relation": "=", "value": "my_value"}]
      }' \
      https://onesignal.com/api/v1/notifications
