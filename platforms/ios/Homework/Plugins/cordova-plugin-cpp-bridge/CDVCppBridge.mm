#import "CDVCppBridge.h"

@implementation CDVCppBridge

- (void)TestCpp_new:(CDVInvokedUrlCommand*)command {
    if (command.arguments.count != 0) {
        [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"invalid parameters."] callbackId:command.callbackId];
        return;
    }





    TestCpp* ret = new TestCpp();

    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:[[NSNumber numberWithUnsignedLong:(unsigned long)ret] stringValue]];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)TestCpp_delete:(CDVInvokedUrlCommand*)command {
    if (command.arguments.count != 1) {
        [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"invalid parameters."] callbackId:command.callbackId];
        return;
    }

    TestCpp *instance = (TestCpp*)(unsigned long)[[command.arguments objectAtIndex:0] longLongValue];



    delete instance;

    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK ];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)TestCpp_mm_testMethod:(CDVInvokedUrlCommand*)command {
    if (command.arguments.count != 5) {
        [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"invalid parameters."] callbackId:command.callbackId];
        return;
    }

    TestCpp *instance = (TestCpp*)(unsigned long)[[command.arguments objectAtIndex:0] longLongValue];

    NSNumber* param0 = [command.arguments objectAtIndex:1];
    NSString* param1 = [command.arguments objectAtIndex:2];
    NSNumber* param2 = [command.arguments objectAtIndex:3];
    NSNumber* param3 = [command.arguments objectAtIndex:4];

    int ret = instance->testMethod([param0 intValue], [param1 UTF8String], [param2 doubleValue], [param3 boolValue]);

    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsInt:ret];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)TestCpp_sm_staticTestMethod:(CDVInvokedUrlCommand*)command {
    if (command.arguments.count != 0) {
        [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"invalid parameters."] callbackId:command.callbackId];
        return;
    }





    const char* ret = TestCpp::staticTestMethod();

    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:[NSString stringWithUTF8String:ret]];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}


@end
