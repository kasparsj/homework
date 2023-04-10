cordova.define('cordova/plugin_list', function(require, exports, module) {
  module.exports = [
    {
      "id": "cordova-plugin-cpp-bridge.CordovaCppBridge",
      "file": "plugins/cordova-plugin-cpp-bridge/www/CDVCppBridge.js",
      "pluginId": "cordova-plugin-cpp-bridge",
      "clobbers": [
        "cpp"
      ]
    }
  ];
  module.exports.metadata = {
    "cordova-plugin-cpp-bridge": "0.0.7",
    "cordova-plugin-homework": "1.0.0",
    "cordova-plugin-add-swift-support": "2.0.2"
  };
});