document.addEventListener('deviceready', onDeviceReady, false);

function onDeviceReady() {
    // Cordova is now initialized. Have fun!

    console.log('Running cordova-' + cordova.platformId + '@' + cordova.version);
    document.getElementById('deviceready').classList.add('ready');
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
        console.log('success:', message);
    }

    function errorHandler(err) {
        console.log('failed', err);
    }

    var service = 'Homework';
    var action = 'echo';
    var args = [
        'Test Message'
    ];

    cordova.exec(successHandler, errorHandler, service, action, args);
}

function native_alert() {
    function successHandler(message) {
        console.log('success:', message);
    }

    function errorHandler(err) {
        console.log('failed', err);
    }

    var service = 'Homework';
    var action = 'alert';
    var args = [
        'My title', 'My message'
    ];

    cordova.exec(successHandler, errorHandler, service, action, args);
}

function exec_js() {
    function successHandler(message) {
        console.log('success:', message);
    }

    function errorHandler(err) {
        console.log('failed', err);
    }

    var service = 'Homework';
    var action = 'callJS';
    var args = [];

    cordova.exec(successHandler, errorHandler, service, action, args);
}