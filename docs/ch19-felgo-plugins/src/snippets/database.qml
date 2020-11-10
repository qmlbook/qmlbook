import Felgo 3.0
import QtQuick 2.0

App {
  FirebaseConfig {
    id: fbConfig

    projectId: "<your project ID, from project_info | project_number, e.g., 82701038584"
    databaseUrl: "<your database URL, from project_info | firebase_url>"

    apiKey: Qt.platform.os === "android"
          ? "<your Android API key, from client | api_key | current_key>"
          : "<your iOS API key>"

    applicationId: Qt.platform.os === "android"
                 ? "<your Android application ID, from client | client_info | mobilesdk_app_id>"
                 : "<your iOS application ID>"
  }
}
