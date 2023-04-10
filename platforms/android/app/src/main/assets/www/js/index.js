/*
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */

// Wait for the deviceready event before using any of Cordova's device APIs.
// See https://cordova.apache.org/docs/en/latest/cordova/events/events.html#deviceready
document.addEventListener('deviceready', onDeviceReady, false);

function onDeviceReady() {
    // Cordova is now initialized. Have fun!

    console.log('Running cordova-' + cordova.platformId + '@' + cordova.version);
    document.getElementById('deviceready').classList.add('ready');
}

function native_alert() {
    navigator.notification.alert('native alert');
}

function cpp_member() {
    cpp.TestCpp.new(function(testCpp) {
        testCpp.testMethod(999, "message", 1.111, true, function(ret) {
            alert('TestCpp#testMethod : ' + ret);
        });
    });
}
function cpp_static() {
    cpp.TestCpp.staticTestMethod(function(ret) {
        alert('TestCpp#staticTestMethod : ' + ret);
    });
}

function my_plugin() {
    function successHandler(message) {
        alert('success:', message);
    }

    function errorHandler(err) {
        alert('failed', err);
    }

    var service = 'Homework';
    var action = 'echo';
    var args = [
        'Test Message'
    ];

    cordova.exec(successHandler, errorHandler, service, action, args);
}