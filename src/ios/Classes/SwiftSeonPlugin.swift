import Flutter
import UIKit
import SeonSDK

public class SwiftSeonPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "seon_plugin", binaryMessenger: registrar.messenger())
    let instance = SwiftSeonPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    if call.method == "getFingerPrint" {
            guard let args = call.arguments as? [String : Any] else {return}
            let sessionId = args["sessionId"] as? String?
            let isLoggingEnabled = args["isLoggingEnabled"] as? Bool
            if sessionId == nil || sessionId == "" {
                result(false)
                return
            }
        getSeonFingerPrint(session_id: sessionId!, isLoggingEnabled: isLoggingEnabled!, completionHandler: {(seonFingerprint) in result(seonFingerprint)}
        )
    }
  }

    func getSeonFingerPrint(session_id: String?, isLoggingEnabled: Bool, completionHandler: @escaping (String?) -> Void) -> Void {
    let seonfp = SEONFingerprint()
      
    // Enable logging
    seonfp.setLoggingEnabled(loggingEnabled: isLoggingEnabled)

    // Set session_id
    seonfp.sessionId = session_id

    // Compute fingerprint asynchronously
    seonfp.getFingerprintBase64 { seonFingerprint, error in
        if let error{
            print(error.localizedDescription)
        } else{
            completionHandler(seonFingerprint);
        }
    }
  }
}
