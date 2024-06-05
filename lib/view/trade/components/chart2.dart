import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class Chart2 extends StatefulWidget {
  final String name;
  const Chart2({super.key, required this.name});

  @override
  State<Chart2> createState() => _Chart2State();
}

class _Chart2State extends State<Chart2> {
  late final WebViewController controller;

  String cryptoNameAndSource(String name) {
    return '''
      <!DOCTYPE html>
      <html lang="en">
      <head>
      <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no">
      <title>Load file or HTML string example</title>
      </head>
      <body>
      <div class="tradingview-widget-container" style="height:100%;width:100%">
  <div class="tradingview-widget-container__widget" style="height:calc(100% - 32px);width:100%"></div>
  <div class="tradingview-widget-copyright"><a href="https://www.tradingview.com/" rel="noopener nofollow" target="_blank"><span class="blue-text">Track all markets on TradingView</span></a></div>
  <script type="text/javascript" src="https://s3.tradingview.com/external-embedding/embed-widget-advanced-chart.js" async>
      {
        "height": "800",
        "symbol": "CRYPTOCAP:$name",
        "interval": "D",
        "timezone": "Etc/UTC",
        "theme": "dark",
        "style": "1",
        "locale": "en",
        "toolbar_bg": "#151515",
        "backgroundColor": "#151515",
        "enable_publishing": false,
        "save_image": false,
        "support_host": "https://www.tradingview.com"
      }
      </script>
      </div>
      </body>
      </html>''';
  }

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            debugPrint('progress');
          },
          onPageStarted: (String url) {
            debugPrint('started');
          },
          onPageFinished: (String url) {
            debugPrint('finished');
          },
        ),
      )
      ..enableZoom(true)
      ..loadHtmlString(cryptoNameAndSource(widget.name));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 800,
      child: WebViewWidget(
          controller: controller,
        ),
    );
  }
}
