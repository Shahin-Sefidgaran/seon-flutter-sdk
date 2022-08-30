import Flutter
import UIKit
import SeonSDK

public class SwiftSeonPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "seon_plugin", binaryMessenger: registrar.messenger())
    let instance = SwiftSeonPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
    registrar.addApplicationDelegate(instance)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    if call.method == "getFingerPrint" {
            guard let args = call.arguments as? [String : Any] else {return}
            let sessionId = args["sessionId"] as! String?
            let isLoggingEnabled = args["isLoggingEnabled"] as! Bool
            if sessionId == nil || sessionId == "" {
                result(false)
                return
            }
            result(getSeonFingerPrint(session_id: sessionId!, isLoggingEnabled: isLoggingEnabled!))
        }
  }

  public func getSeonFingerPrint(session_id: String, isLoggingEnabled: Bool) {

    let seonfp = SeonFingerprint()

    // Enable logging
    seonfp.setLoggingEnabled(isLoggingEnabled)

    // Set session_id
    seonfp.sessionId = session_id

    // Compute fingerprint
    return seonfp.fingerprintBase64
  }
}
