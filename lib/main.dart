import 'package:doafric/page_routes/route_generate.dart';
import 'package:doafric/page_routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  const MyApp({super.key});

  static String? userid;
  static String? AUTH_TOKEN_VALUE;
  static String? email_VALUE;

  // static logout() async {
  //   // googleSignIn.disconnect();
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   sharedPreferences.clear();
  //   sharedPreferences.setString(StringFile.onBoard, "0");
  //   userid = null;
  //   //   platform.PlatformState.firebaseMessaging.unsubscribeFromTopic(MyApp.LOGIN_ID_VALUE);
  // }

  static logout() async {
    //LoginApi registerresponse = LoginApi(data);
    //  await registerresponse.fcmlogout();
    // googleSignIn.disconnect();

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();

    userid = null;
    AUTH_TOKEN_VALUE = null;
    email_VALUE = null;
  }
  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, screenType) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
      return GetMaterialApp(
        theme: ThemeData(useMaterial3: true),
        debugShowCheckedModeBanner: false,
        initialRoute: Routes.splashScreen,
        onGenerateRoute: RouteGenerator.generateRoute,
      );
    });
  }
}
