import 'package:doafric/apis/api.dart';

import 'package:doafric/utils/appbarforall.dart';

import 'package:doafric/utils/webviewscreenshow.dart';
import 'package:flutter/material.dart';


class HelpSupport extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: AppBarScreens(
              text: "Help & Support",
            )),
        body: WebViewScreensShow(
            url: ABOUTUS));
  }
}
