import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qcart_sdk_flutter/qcart_sdk_flutter.dart';

void main() {
  runApp(const MaterialApp(home: QcartTestPage()));
}

class QcartTestPage extends StatefulWidget {
  const QcartTestPage({super.key});

  @override
  State<QcartTestPage> createState() => _QcartTestPageState();
}

class _QcartTestPageState extends State<QcartTestPage> {
  QcartResult? result;
  final TextEditingController _controller =
      TextEditingController(text: "qcart://test.abc/path/name?qcart=true&skus=111,222:3#hashparam=123"); // Preloaded URL

  @override
  void initState() {
    super.initState();

    // Listen for incoming deep links
    QcartSdkFlutter.setDeeplinkListener((res) {
      setState(() {
        result = res;
      });
    });

    // Optionally, handle cold start deep link
    _checkInitialDeepLink();

    // Preload URL: parse it automatically
    _handleUrl(_controller.text);
  }

  Future<void> _checkInitialDeepLink() async {
    // Keep as is or remove if using preloaded URL
  }

  Future<void> _handleUrl(String url) async {
    try {
      final res = await QcartSdkFlutter.handleDeepLink(url);
      setState(() {
        result = res;
      });
    } on PlatformException catch (e) {
      debugPrint('Error handling deep link: ${e.message}');
    } catch (e) {
      debugPrint('Unexpected error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('QCart SDK Example')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Enter Deeplink URL',
              ),
              onSubmitted: _handleUrl,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: result != null
                  ? SingleChildScrollView(
                      child: Text.rich(
                        TextSpan(
                          children: [
                            ...{
                              'url': result!.url,
                              'pathSegments': result!.pathSegments.join(', '),
                              'queryParameters':
                                  result!.queryParameters.toString(),
                              'fragmentParameters':
                                  result!.fragmentParameters.toString(),
                              'isQcart': result!.isQcart.toString(),
                              'skus': result!.skus.toString(),
                            }.entries.expand(
                              (e) => [
                                TextSpan(text: '${e.key}: ', style: labelStyle),
                                TextSpan(
                                  text: '${e.value}\n',
                                  style: valueStyle,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  : const Center(
                      child: Text(
                        'Enter a deeplink or wait for one to arrive',
                        style: TextStyle(fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

const labelStyle = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 16,
  color: Colors.black,
);
const valueStyle = TextStyle(fontSize: 16, color: Colors.blue);