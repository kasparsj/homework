cordova.define('cordova/plugin_list', function(require, exports, module) {
  module.exports = [
    {
      "id": "cordova-plugin-cpp-bridge.CordovaCppBridge",
      "file": "plugins/cordova-plugin-cpp-bridge/www/CDVCppBridge.js",
      "pluginId": "cordova-plugin-cpp-bridge",
      "clobbers": [
        "cpp"
      ]
    },
    {
      "id": "cordova-plugin-dialogs.notification",
      "file": "plugins/cordova-plugin-dialogs/www/notification.js",
      "pluginId": "cordova-plugin-dialogs",
      "merges": [
        "navigator.notification"
      ]
    },
    {
      "id": "cordova-plugin-dialogs.notification_android",
      "file": "plugins/cordova-plugin-dialogs/www/android/notification.js",
      "pluginId": "cordova-plugin-dialogs",
      "merges": [
        "navigator.notification"
      ]
    }
  ];
  module.exports.metadata = {
    "cordova-plugin-cpp-bridge": "0.0.7",
    "cordova-plugin-dialogs": "3.0.0-dev",
    "cordova-plugin-homework": "1.0.0",
    "cordova-plugin-add-swift-support": "2.0.2"
  };
});