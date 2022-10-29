import Foundation
import AVFoundation
import Photos

@objc(Permissions)
class Permissions : CDVPlugin {
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

    @objc(request:)
    public func request(command: CDVInvokedUrlCommand) {
        let permission = command.arguments[0] as! String
        switch permission {
        case "camera":
            requestCamera(command: command)
        case "photos":
            requestPhotos(command: command)
        default:
            failure(command: command, message: "Unknown permission: \(permission)")
        }
    }

    @objc(checkCamera)
    private func checkCamera() -> Bool {
        let status = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
        switch status {
        case .authorized:
            return true
        default:
            return false
        }
    }

    @objc(requestCamera:)
    private func requestCamera(command: CDVInvokedUrlCommand) {
        if checkCamera() {
            success(command: command)
            return
        }

        AVCaptureDevice.requestAccess(for: AVMediaType.video) { (granted) in
            if granted {
                self.success(command: command)
            } else {
                self.failure(command: command, message: "Permission denied")
            }
        }
    }

    @objc(checkPhotos)
    private func checkPhotos() -> Bool {
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .authorized:
            return true
        default:
            return false
        }
    }

    @objc(requestPhotos:)
    private func requestPhotos(command: CDVInvokedUrlCommand) {
        if checkPhotos() {
            success(command: command)
            return
        }

        PHPhotoLibrary.requestAuthorization { (status) in
            if status == .authorized {
                self.success(command: command)
            } else {
                self.failure(command: command, message: "Permission denied")
            }
        }
    }
}

