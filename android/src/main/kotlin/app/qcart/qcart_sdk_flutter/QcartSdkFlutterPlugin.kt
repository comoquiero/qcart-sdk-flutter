package app.qcart.qcart_sdk_flutter

import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel.Result
import android.content.Intent
import android.net.Uri

class QcartSdkFlutterPlugin: FlutterPlugin, MethodCallHandler {

    companion object {
        private var channel: MethodChannel? = null

        // Send raw deep link URL to Flutter
        fun sendDeepLink(url: String) {
            channel?.invokeMethod("onDeepLink", mapOf("url" to url))
        }
    }

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(binding.binaryMessenger, "qcart_sdk_flutter")
        channel?.setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        if (call.method == "handleDeeplink") {
            // Just return the raw URL back to Flutter
            val url = call.argument<String>("url")
            result.success(mapOf("url" to url))
        } else {
            result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel?.setMethodCallHandler(null)
        channel = null
    }
}