import Flutter
import UIKit

public class QcartSdkFlutterPlugin: NSObject, FlutterPlugin {
    
    private static var channel: FlutterMethodChannel?

    public static func register(with registrar: FlutterPluginRegistrar) {
        channel = FlutterMethodChannel(name: "qcart_sdk_flutter", binaryMessenger: registrar.messenger())
        let instance = QcartSdkFlutterPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel!)
    }
    
    // Send raw deep link URL to Flutter
    public static func sendDeepLink(_ urlString: String) {
        guard let url = URL(string: urlString) else { return }

        // Parse using your existing parser
        let result = QcartParser.handle(url: url)
        
        // Convert to dictionary for Flutter
        if let jsonString = result.toJSON(),
        let data = jsonString.data(using: .utf8),
        let map = try? JSONSerialization.jsonObject(with: data) as? [String: Any] {
            channel?.invokeMethod("onDeepLink", arguments: map)
        }
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