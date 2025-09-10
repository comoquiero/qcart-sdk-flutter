import 'package:flutter/services.dart';

class QcartSdkFlutter {
  static const MethodChannel _channel = MethodChannel('qcart_sdk_flutter');

  static Future<Map<String, dynamic>?> handleDeeplink(String url) async {
    final result = await _channel.invokeMethod('handleDeeplink', {'url': url});
    return Map<String, dynamic>.from(result);
  }
}