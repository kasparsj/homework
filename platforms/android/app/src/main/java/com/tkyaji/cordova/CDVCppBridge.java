package com.tkyaji.cordova;

import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.PluginResult;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.HashMap;
import java.util.Map;

public class CDVCppBridge extends CordovaPlugin {

    static {
        System.loadLibrary("cordova-cpp-bridge-lib");
    }

    public static native long TestCpp0new();
    public static native void TestCpp0delete(long param0);
    public static native int TestCpp0mm0testMethod(long param0, int param1, String param2, double param3, boolean param4);
    public static native String TestCpp0sm0staticTestMethod();

    private static Map<String, CppBridgeAction> actionRunnerMap = new HashMap<String, CppBridgeAction>() {
        {
            put("TestCpp_new", new CppBridgeAction() {
                @Override
                public boolean invoke(JSONArray data, CallbackContext callbackContext) {
                    if (data.length() != 0) {
                        callbackContext.error("invalid parameters.");
                        return false;
                    }
                    try {
                        long ret = TestCpp0new();
                        callbackContext.sendPluginResult(new PluginResult(PluginResult.Status.OK, String.valueOf(ret)));
                    } catch (Exception ex) {
                        return false;
                    }
                    return true;
                }
            });

            put("TestCpp_delete", new CppBridgeAction() {
                @Override
                public boolean invoke(JSONArray data, CallbackContext callbackContext) {
                    if (data.length() != 1) {
                        callbackContext.error("invalid parameters.");
                        return false;
                    }
                    try {
                        TestCpp0delete(Long.parseLong(data.getString(0)));
                        callbackContext.sendPluginResult(new PluginResult(PluginResult.Status.OK));
                    } catch (Exception ex) {
                        return false;
                    }
                    return true;
                }
            });

            put("TestCpp_mm_testMethod", new CppBridgeAction() {
                @Override
                public boolean invoke(JSONArray data, CallbackContext callbackContext) {
                    if (data.length() != 5) {
                        callbackContext.error("invalid parameters.");
                        return false;
                    }
                    try {
                        int ret = TestCpp0mm0testMethod(Long.parseLong(data.getString(0)), data.getInt(1), data.getString(2), data.getDouble(3), data.getBoolean(4));
                        callbackContext.sendPluginResult(new PluginResult(PluginResult.Status.OK, ret));
                    } catch (Exception ex) {
                        return false;
                    }
                    return true;
                }
            });

            put("TestCpp_sm_staticTestMethod", new CppBridgeAction() {
                @Override
                public boolean invoke(JSONArray data, CallbackContext callbackContext) {
                    if (data.length() != 0) {
                        callbackContext.error("invalid parameters.");
                        return false;
                    }
                    try {
                        String ret = TestCpp0sm0staticTestMethod();
                        callbackContext.sendPluginResult(new PluginResult(PluginResult.Status.OK, ret));
                    } catch (Exception ex) {
                        return false;
                    }
                    return true;
                }
            });

        }
    };

    @Override
    public boolean execute(String action, JSONArray data, CallbackContext callbackContext) throws JSONException {
        CppBridgeAction bridgeAction = actionRunnerMap.get(action);
        if (bridgeAction == null) {
            return false;
        }
        return bridgeAction.invoke(data, callbackContext);
    }


    private interface CppBridgeAction {
        boolean invoke(JSONArray data, CallbackContext callbackContext);
    }    
}
