@objc(Homework) class Homework : CDVPlugin {
  func alert(command: CDVInvokedUrlCommand) {
    var pluginResult = CDVPluginResult(
      status: CDVCommandStatus_ERROR
    )

    let msg = command.arguments[0] as? String ?? ""

    if msg.characters.count > 0 {
      /* UIAlertController is iOS 8 or newer only. */
      let toastController: UIAlertController =
        UIAlertController(
          title: "Custom native alert",
          message: msg,
          preferredStyle: .alert
        )

        self.viewController?.present(
        toastController,
        animated: true,
        completion: nil
      )

//      let duration = Double(NSEC_PER_SEC) * 3.0
//
//       dispatch_after(
//         dispatch_time(
//           DISPATCH_TIME_NOW,
//           Int64(duration)
//         ),
//         dispatch_get_main_queue(),
//         {
//           toastController.dismissViewControllerAnimated(
//             true,
//             completion: nil
//           )
//         }
//       )
//
      pluginResult = CDVPluginResult(
        status: CDVCommandStatus_OK,
        messageAs: msg
      )
    }

      self.commandDelegate!.send(
      pluginResult,
      callbackId: command.callbackId
    )
  }
}
