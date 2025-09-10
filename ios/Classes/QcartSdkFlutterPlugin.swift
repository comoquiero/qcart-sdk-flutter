import Flutter
import UIKit
import QcartSDK

public class QcartSdkFlutterPlugin: NSObject, FlutterPlugin, FlutterApplicationLifeCycleDelegate {
    
    private static var channel: FlutterMethodChannel?

    public static func register(with registrar: FlutterPluginRegistrar) {
        channel = FlutterMethodChannel(name: "qcart_sdk_flutter", binaryMessenger: registrar.messenger())
        let instance = QcartSdkFlutterPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel!)
        registrar.addApplicationDelegate(instance) // 🔑 This registers for app lifecycle/deep links
    }
    
    // Handle manual deeplink parsing from Flutter
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if call.method == "handleDeeplink" {
            if let args = call.arguments as? [String: Any],
               let urlString = args["url"] as? String,
               let url = URL(string: urlString) {

                let parsed = QcartParser.handle(url: url)
                if let jsonString = parsed.toJSON(),
                   let data = jsonString.data(using: .utf8),
                   let map = try? JSONSerialization.jsonObject(with: data) as? [String: Any] {
                    result(map)
                } else {
                    result(FlutterError(code: "PARSE_ERROR", message: "Could not parse URL", details: nil))
                }
            } else {
                result(FlutterError(code: "INVALID_ARGS", message: "Missing URL", details: nil))
            }
        } else {
            result(FlutterMethodNotImplemented)
        }
    }
    
    // 🔑 Handle deep links automatically
    public func application(_ application: UIApplication,
                            open url: URL,
                            options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        QcartSdkFlutterPlugin.sendDeepLink(url.absoluteString)
        return true
    }

    // Utility: send parsed link to Flutter
    public static func sendDeepLink(_ urlString: String) {
        guard let url = URL(string: urlString) else { return }
        let result = QcartParser.handle(url: url)
        if let jsonString = result.toJSON(),
           let data = jsonString.data(using: .utf8),
           let map = try? JSONSerialization.jsonObject(with: data) as? [String: Any] {
            channel?.invokeMethod("onDeepLink", arguments: map)
        }
    }
}
