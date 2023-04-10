package homework.plugin

import org.apache.cordova.CordovaPlugin
import org.apache.cordova.CallbackContext
import org.json.JSONArray
import org.json.JSONException
import org.json.JSONObject

class Homework : CordovaPlugin() {

  override fun execute(
    action: String,
    args: JSONArray,
    callbackContext: CallbackContext
  ): Boolean {
    if (action == "echo") {
      val message: String = args.getString(0)

      echo(message, callbackContext)

      return true
    }

    return false
  }

  private fun echo(
    message: String,
    callbackContext: CallbackContext
  ) {
    if (message.isNotEmpty()) {
      callbackContext.success(message);
    } else {
      callbackContext.error("Expected one non-empty string argument.");
    }
  }
}