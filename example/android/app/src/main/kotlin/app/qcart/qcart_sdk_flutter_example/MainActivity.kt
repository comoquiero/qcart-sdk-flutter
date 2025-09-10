package app.qcart.qcart_sdk_flutter_example

import io.flutter.embedding.android.FlutterActivity
import android.os.Bundle
import android.content.Intent
import app.qcart.qcart_sdk_flutter.QcartSdkFlutterPlugin
import android.net.Uri
import android.util.Log

class MainActivity: FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        handleIntent(intent)
    }

    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        handleIntent(intent)
    }

    private fun handleIntent(intent: Intent) {
        val data = intent.dataString
        if (data != null) {
            // Decode the URL to handle %26, %23, etc.
            val decodedData = Uri.decode(data)

            // Log both raw and decoded URL
            Log.d("QCartDeepLink", "Raw URL from Intent: $data")
            Log.d("QCartDeepLink", "Decoded URL: $decodedData")

            // Send to Flutter
            QcartSdkFlutterPlugin.sendDeepLink(decodedData)
        } else {
            Log.d("QCartDeepLink", "Intent has no dataString")
        }
    }
}