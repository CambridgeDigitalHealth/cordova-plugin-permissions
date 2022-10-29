import Foundation
import AVFoundation
import Photos

@objc(Permissions) class Permissions : CDVPlugin {
    @objc(success:)
    private func success(command: CDVInvokedUrlCommand) {
        let result = CDVPluginResult(status: CDVCommandStatus_OK)
        self.commandDelegate.send(result, callbackId: command.callbackId)
    }
    @objc(wait:)
    private func wait(command: CDVInvokedUrlCommand) {
        let result = CDVPluginResult(status: CDVCommandStatus_NO_RESULT)
        result?.setKeepCallbackAs(true)
    }
    @objc(failure:message:)
    private func failure(command: CDVInvokedUrlCommand, message: String?) {
        let result = CDVPluginResult(status: CDVCommandStatus_ERROR, messageAs: message)
        self.commandDelegate.send(result, callbackId: command.callbackId)
    }

    // @objc(check:)
    // public func check(command: CDVInvokedUrlCommand) {
    //     let permission = command.arguments[0] as! String
    //     var status = ""
    //     switch permission {
    //     case "camera":
    //         status = AVCaptureDevice.authorizationStatus(for: AVMediaType.video).rawValue.description
    //     case "photos":
    //         status = PHPhotoLibrary.authorizationStatus().rawValue.description
    //     default:
    //         status = "unknown"
    //     }
    //     let pluginResult = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: status)
    //     self.commandDelegate!.send(pluginResult, callbackId: command.callbackId)
    // }

    @objc(request:)
    public func request(command: CDVInvokedUrlCommand) {
        self.wait(command: command)
        let permission = command.arguments[0] as! String
        switch permission {
        case "camera":
            AVCaptureDevice.requestAccess(for: AVMediaType.video) { status in
                switch status {
                    case true:
                        self.success(command: command)
                    case false:
                        self.failure(command: command, message: "Permission denied")
                }
            }
        case "photos":
            PHPhotoLibrary.requestAuthorization { status in
                switch status {
                    case .authorized:
                        self.success(command: command)
                    case .denied:
                        self.failure(command: command, message: "Permission denied")
                    case .notDetermined:
                        self.failure(command: command, message: "Permission not determined")
                    default:
                        self.success(command: command)
                }
            }
        default:
            self.failure(command: command, message: "Permission unknown")
        }
    }
}

