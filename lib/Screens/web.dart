import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewContainer extends StatefulWidget {
  final String websiteURL;
  WebViewContainer({super.key, required this.websiteURL});

  @override
  State<StatefulWidget> createState() => _WebViewContainerState();
}

class _WebViewContainerState extends State<WebViewContainer> {
  final controller = WebViewController();

  @override
  Widget build(BuildContext context) {
    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(widget.websiteURL));

    return Scaffold(
      body: WebViewWidget(controller: controller),
    );
  }
}
