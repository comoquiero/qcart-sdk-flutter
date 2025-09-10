import Flutter
import UIKit

public class SwiftQcartSdkFlutterPlugin: NSObject, FlutterPlugin {
    
    private static var channel: FlutterMethodChannel?

    public static func register(with registrar: FlutterPluginRegistrar) {
        channel = FlutterMethodChannel(name: "qcart_sdk_flutter", binaryMessenger: registrar.messenger())
        let instance = SwiftQcartSdkFlutterPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel!)
    }
    
    // Send raw deep link URL to Flutter
    public static func sendDeepLink(_ url: String) {
        channel?.invokeMethod("onDeepLink", arguments: ["url": url])
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if call.method == "handleDeeplink" {
            if let args = call.arguments as? [String: Any],
               let url = args["url"] as? String {
                // Just return raw URL
                result(["url": url])
            } else {
                result(FlutterError(code: "INVALID_ARGS", message: "Missing URL", details: nil))
            }
        } else {
            result(FlutterMethodNotImplemented)
        }
    }
}