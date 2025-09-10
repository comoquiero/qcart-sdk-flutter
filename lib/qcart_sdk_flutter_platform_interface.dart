import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'qcart_sdk_flutter_method_channel.dart';

abstract class QcartSdkFlutterPlatform extends PlatformInterface {
  /// Constructs a QcartSdkFlutterPlatform.
  QcartSdkFlutterPlatform() : super(token: _token);

  static final Object _token = Object();

  static QcartSdkFlutterPlatform _instance = MethodChannelQcartSdkFlutter();

  /// The default instance of [QcartSdkFlutterPlatform] to use.
  ///
  /// Defaults to [MethodChannelQcartSdkFlutter].
  static QcartSdkFlutterPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [QcartSdkFlutterPlatform] when
  /// they register themselves.
  static set instance(QcartSdkFlutterPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
