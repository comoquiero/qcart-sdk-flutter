package app.qcart.qcart_sdk_flutter

import android.content.Intent
import android.net.Uri
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.Result
import app.qcart.deeplink.QcartDeeplinkSdk

class QcartSdkFlutterPlugin : FlutterPlugin, MethodChannel.MethodCallHandler {

    companion object {
        private var channel: MethodChannel? = null

        /**
         * Sends a deep link (URL string) to Flutter.
         */
        fun sendDeepLink(url: String) {
            try {
                // Use the SDK parser to parse the URL
                val parsed = QcartDeeplinkSdk.parseUrl(url)
                channel?.invokeMethod("onDeepLink", parsed.toMap())
            } catch (e: Exception) {
                channel?.invokeMethod("onDeepLink", mapOf("error" to e.message))
            }
        }
    }

    override fun onAttachedToEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(binding.binaryMessenger, "qcart_sdk_flutter")
        channel?.setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        when (call.method) {
            "handleDeeplink" -> {
                val url = call.argument<String>("url")
                if (url != null) {
                    try {
                        // Parse URL using the updated SDK
                        val parsed = QcartDeeplinkSdk.parseUrl(url)
                        result.success(parsed.toMap())
                    } catch (e: Exception) {
                        result.error("PARSE_ERROR", "Could not parse URL: ${e.message}", null)
                    }
                } else {
                    result.error("INVALID_ARGS", "Missing URL", null)
                }
            }
            else -> result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel?.setMethodCallHandler(null)
        channel = null
    }
}