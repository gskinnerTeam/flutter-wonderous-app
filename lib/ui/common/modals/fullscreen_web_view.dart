import 'package:webview_flutter/webview_flutter.dart';
import 'package:wonders/common_libs.dart';

class FullscreenWebView extends StatefulWidget {
  const FullscreenWebView(this.url, {super.key});
  final String url;

  @override
  State<FullscreenWebView> createState() => _FullscreenWebViewState();
}

class _FullscreenWebViewState extends State<FullscreenWebView> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: WebViewWidget(controller: _controller),
      ),
    );
  }
}
