curl --include \
      --request POST \
      --header "Content-Type: application/json" \
      --header "Authorization: Basic <ONESIGNAL-REST-API-KEY>" \
      --data-binary '{
         "app_id": "<ONESIGNAL-APP-ID>",
         "contents": { "en": "Message" }
      }' \
      https://onesignal.com/api/v1/notifications
