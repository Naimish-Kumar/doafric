import 'dart:async';
import 'package:doafric/page_routes/routes.dart';
import 'package:doafric/utils/colors.dart';
import 'package:doafric/utils/image_file.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => InitState();
}

class InitState extends State<SplashScreen> {
  @override
  void initState() {
   
    super.initState();
    startTimer();
  }

  startTimer() async 
  {
    print("kljjfdhgkjfdkg");
    var duration = const Duration(seconds: 3);
    return  Timer(duration, homePageRoute);
  }

  homePageRoute()
   {
    Get.offAllNamed(Routes.dashboard);
  }

  @override
  Widget build(BuildContext context) {
    return initWidget();
  }

  Widget initWidget() {
    return Scaffold(
      body: Stack(children: [
        Center(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Image.asset(
              ImageFile.splash,
              fit: BoxFit.fill,
            ),
          ),
        ),
        const Padding(
            padding: EdgeInsets.only(top: 450),
            child: Center(
              child: CircularProgressIndicator(
                color: colorWhite,
              ),
            ))
      ]),
    );
  }
}
