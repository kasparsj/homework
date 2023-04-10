#import <Cordova/CDV.h>

#include "TestCpp.h"

@interface CDVCppBridge : CDVPlugin {
}

- (void)TestCpp_new:(CDVInvokedUrlCommand*)command;
- (void)TestCpp_delete:(CDVInvokedUrlCommand*)command;
- (void)TestCpp_mm_testMethod:(CDVInvokedUrlCommand*)command;
- (void)TestCpp_sm_staticTestMethod:(CDVInvokedUrlCommand*)command;

@end
