#import "CDVHomework.h"

#define DIALOG_TYPE_ALERT @"alert"
#define DIALOG_TYPE_PROMPT @"prompt"

static NSMutableArray *alertList = nil;
static NSMutableArray *openAlertList = nil;

@implementation CDVHomework

/*
 * showDialogWithMessage - Common method to instantiate the alert view for alert, confirm, and prompt notifications.
 * Parameters:
 *  message       The alert view message.
 *  title         The alert view title.
 *  buttons       The array of customized strings for the buttons.
 *  defaultText   The input text for the textbox (if textbox exists).
 *  callbackId    The commmand callback id.
 *  dialogType    The type of alert view [alert | prompt].
 */
- (void)showDialogWithMessage:(NSString*)message title:(NSString*)title buttons:(NSArray*)buttons defaultText:(NSString*)defaultText callbackId:(NSString*)callbackId dialogType:(NSString*)dialogType
{
    int count = (int)[buttons count];

    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];

    __weak CDVHomework* weakNotif = self;

    for (int n = 0; n < count; n++) {
        [alertController addAction:[UIAlertAction actionWithTitle:[buttons objectAtIndex:n]
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action)
        {
            CDVPluginResult* result;

            if ([dialogType isEqualToString:DIALOG_TYPE_PROMPT])
            {
                NSString* value0 = [[alertController.textFields objectAtIndex:0] text];
                NSDictionary* info = @{
                    @"buttonIndex":@(n + 1),
                    @"input1":(value0 ? value0 : [NSNull null])
                };
                result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:info];
            }
            else
            {
                result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsInt:(int)(n  + 1)];
            }

            [weakNotif.commandDelegate sendPluginResult:result callbackId:callbackId];
            [openAlertList removeObject:alertController];
        }]];
    }
    if ([dialogType isEqualToString:DIALOG_TYPE_PROMPT]) {

        [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
            textField.text = defaultText;
        }];
    }
    if (!alertList) {
        alertList = [[NSMutableArray alloc] init];
    }
    [alertList addObject:alertController];

    if ([alertList count] == 1) {
        [self presentAlertcontroller];
    }
}

- (void)alert:(CDVInvokedUrlCommand*)command
{
    NSString* callbackId = command.callbackId;
    NSString* message = [command argumentAtIndex:0];
    NSString* title = [command argumentAtIndex:1];
    NSString* buttons = [command argumentAtIndex:2];

    [self showDialogWithMessage:message title:title buttons:@[buttons] defaultText:nil callbackId:callbackId dialogType:DIALOG_TYPE_ALERT];
}

- (void)confirm:(CDVInvokedUrlCommand*)command
{
    NSString* callbackId = command.callbackId;
    NSString* message = [command argumentAtIndex:0];
    NSString* title = [command argumentAtIndex:1];
    NSArray* buttons = [command argumentAtIndex:2];

    [self showDialogWithMessage:message title:title buttons:buttons defaultText:nil callbackId:callbackId dialogType:DIALOG_TYPE_ALERT];
}

- (void)prompt:(CDVInvokedUrlCommand*)command
{
    NSString* callbackId = command.callbackId;
    NSString* message = [command argumentAtIndex:0];
    NSString* title = [command argumentAtIndex:1];
    NSArray* buttons = [command argumentAtIndex:2];
    NSString* defaultText = [command argumentAtIndex:3];

    [self showDialogWithMessage:message title:title buttons:buttons defaultText:defaultText callbackId:callbackId dialogType:DIALOG_TYPE_PROMPT];
}

-(UIViewController *)getTopPresentedViewController {
    UIViewController *presentingViewController = self.viewController;
    if (presentingViewController.view.window != [UIApplication sharedApplication].keyWindow){
        presentingViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    }

    while (presentingViewController.presentedViewController != nil && ![presentingViewController.presentedViewController isBeingDismissed]){
        presentingViewController = presentingViewController.presentedViewController;
    }
    return presentingViewController;
}

-(void)presentAlertcontroller {

    __weak CDVHomework* weakNotif = self;
    UIAlertController* alertController = [alertList firstObject];
    [self.getTopPresentedViewController presentViewController:alertController animated:YES completion:^{
        [alertList removeObject:alertController];
        if (!openAlertList) {
            openAlertList = [[NSMutableArray alloc] init];
        }
        [openAlertList addObject:alertController];
        if ([alertList count]>0) {
            [weakNotif presentAlertcontroller];
        }
    }];

}


- (void)dismissPrevious:(CDVInvokedUrlCommand*)command
{
    if(openAlertList != nil && [openAlertList count]>0){
        __weak CDVHomework* weakNotif = self;
        UIAlertController* alertController = [openAlertList lastObject];
        [alertController dismissViewControllerAnimated:NO completion:^{
            [openAlertList removeObject:alertController];
            [weakNotif.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_OK] callbackId:command.callbackId];
        }];
    }else{
        [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"No previously opened dialog to dismiss"] callbackId:command.callbackId];
    }
}

- (void)dismissAll:(CDVInvokedUrlCommand*)command
{
    if(openAlertList != nil && [openAlertList count]>0){
        __weak CDVHomework* weakNotif = self;
        [self dismissUIAlertControllers:^{
            openAlertList = [[NSMutableArray alloc] init];
            [weakNotif.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_OK] callbackId:command.callbackId];
        }];
    }else{
        [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"No previously opened dialogs to dismiss"] callbackId:command.callbackId];
    }
}

- (void)dismissUIAlertControllers:(void (^)(void))completeBlock{
    if([self.getTopPresentedViewController isKindOfClass:[UIAlertController class]]){
        __weak CDVHomework* weakNotif = self;
        [self.getTopPresentedViewController dismissViewControllerAnimated:NO completion:^{
            [weakNotif dismissUIAlertControllers:completeBlock];
        }];
    }else{
        completeBlock();
    }
}


@end
