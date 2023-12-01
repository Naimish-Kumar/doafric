import 'package:flutter/material.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebViewScreensShow extends StatefulWidget {
  final String url;
  const WebViewScreensShow({super.key, required this.url});

  @override
  State<WebViewScreensShow> createState() => _WebViewScreensShowState();
}

class _WebViewScreensShowState extends State<WebViewScreensShow> {
  // late InAppWebViewController _webViewController;
  var loadingPercentage = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
       
        if (loadingPercentage < 100)
          Center(
            child: Container(
                //  value: loadingPercentage / 100.0,
                ),
          ),
        Center(
          child: CircularProgressIndicator(
            color: Colors.transparent,
            value: loadingPercentage / 100.0,
          ),
        ),
      ],
    );
  }
}
