class QcartSKU {
  final String sku;
  final int quantity;

  QcartSKU({required this.sku, required this.quantity});

  factory QcartSKU.fromJson(Map<String, dynamic> json) {
    return QcartSKU(
      sku: json['sku'] as String,
      quantity: json['quantity'] as int,
    );
  }

  Map<String, dynamic> toJson() => {
        'sku': sku,
        'quantity': quantity,
      };
}

class QcartResult {
  final String? url;
  final List<String> pathSegments;
  final Map<String, String> queryParameters;
  final Map<String, String> fragmentParameters;
  final bool isQcart;
  final List<QcartSKU> skus;

  QcartResult({
    this.url,
    required this.pathSegments,
    required this.queryParameters,
    required this.fragmentParameters,
    required this.isQcart,
    required this.skus,
  });

  factory QcartResult.fromJson(Map<String, dynamic> json) {
    return QcartResult(
      url: json['url'] as String?,
      pathSegments: List<String>.from(json['pathSegments'] ?? []),
      queryParameters: Map<String, String>.from(json['queryParameters'] ?? {}),
      fragmentParameters:
          Map<String, String>.from(json['fragmentParameters'] ?? {}),
      isQcart: json['isQcart'] as bool? ?? false,
      skus: (json['skus'] as List<dynamic>? ?? [])
          .map((e) => QcartSKU.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'url': url,
        'pathSegments': pathSegments,
        'queryParameters': queryParameters,
        'fragmentParameters': fragmentParameters,
        'isQcart': isQcart,
        'skus': skus.map((e) => e.toJson()).toList(),
      };
}