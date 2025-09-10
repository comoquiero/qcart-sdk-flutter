import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';

class QcartResult {
  final String? url;
  final List<String> pathSegments;
  final Map<String, String?> queryParameters;
  final Map<String, String?> fragmentParameters;
  final bool isQcart;
  final List<Map<String, dynamic>> skus;

  QcartResult({
    this.url,
    required this.pathSegments,
    required this.queryParameters,
    required this.fragmentParameters,
    required this.isQcart,
    required this.skus,
  });

  factory QcartResult.fromMap(Map<dynamic, dynamic> map) {
    try {
      return QcartResult(
        url: map['url'] as String?,
        pathSegments: List<String>.from(map['pathSegments'] ?? []),
        queryParameters: Map<String, String?>.from(map['queryParameters'] ?? {}),
        fragmentParameters: Map<String, String?>.from(map['fragmentParameters'] ?? {}),
        isQcart: map['isQcart'] ?? false,
        skus: (map['skus'] as List<dynamic>? ?? []).map((e) {
          final m = e as Map<dynamic, dynamic>;
          return {
            'sku': m['sku'],
            'quantity': m['quantity'],
          };
        }).toList(),
      );
    } catch (e, st) {
      debugPrint('Error parsing QcartResult: $e\n$st');
      return QcartResult(
        url: null,
        pathSegments: [],
        queryParameters: {},
        fragmentParameters: {},
        isQcart: false,
        skus: [],
      );
    }
  }
}

typedef DeeplinkListener = void Function(QcartResult);

class QcartSdkFlutter {
  static const MethodChannel _channel = MethodChannel('qcart_sdk_flutter');

  /// Handle a deep link URL immediately
  static Future<QcartResult> handleDeepLink(String url) async {
    final Map<dynamic, dynamic> result =
        await _channel.invokeMethod('handleDeeplink', {'url': url});
    return QcartResult.fromMap(result);
  }

  /// Listen for incoming deep links (cold start or resumed)
  static void setDeeplinkListener(DeeplinkListener listener) {
    _channel.setMethodCallHandler((call) async {
      if (call.method == "onDeepLink") { // must match Kotlin plugin
        final res = QcartResult.fromMap(call.arguments);
        listener(res);
      }
    });
  }
}