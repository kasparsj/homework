cordova.define("cordova-plugin-cpp-bridge.CordovaCppBridge", function(require, exports, module) {
    var exec = require('cordova/exec');

    module.exports = {
        TestCpp: {
            new: function(success, error) {
                exec(function(instanceId) {
                    var jsInstance = new (function(_instanceId) {
                        return {
                            _className: 'TestCpp',
                            _instanceId: _instanceId,
                            delete: function(success, error) {
                                exec(success, error, "CordovaCppBridge", "TestCpp_delete", [instanceId]);
                            }
,
                            testMethod: function(param0, param1, param2, param3, success, error) {
                                exec(function(ret) {success((ret != null && typeof ret == 'object' && ret.ret) ? ret.ret : ret);}, error, "CordovaCppBridge", "TestCpp_mm_testMethod", [instanceId, param0, param1, param2, param3]);
                            }

                        }

                    })(instanceId);

                    success(jsInstance);

                }, error, "CordovaCppBridge", "TestCpp_new", []);
            }

,
            staticTestMethod: function(success, error) {
                exec(function(ret) {success((ret != null && typeof ret == 'object' && ret.ret) ? ret.ret : ret);}, error, "CordovaCppBridge", "TestCpp_sm_staticTestMethod", []);
            }

        }

    };
});
