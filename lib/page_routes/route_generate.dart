import 'package:doafric/auth/forgot_password.dart';
import 'package:doafric/auth/login_screen.dart';
import 'package:doafric/auth/login_signup_screen.dart';
import 'package:doafric/auth/signup_screen.dart';
import 'package:doafric/cart_list.dart';
import 'package:doafric/home/category_screen.dart';
import 'package:doafric/home/dashoard.dart';
import 'package:doafric/home_screen.dart';
import 'package:doafric/navigation_drawer_item/aboutus.dart';
import 'package:doafric/navigation_drawer_item/help_support.dart';
import 'package:doafric/navigation_drawer_item/information.dart';
import 'package:doafric/navigation_drawer_item/myorder.dart';
import 'package:doafric/navigation_drawer_item/privacy_policy.dart';
import 'package:doafric/navigation_drawer_item/product.dart';
import 'package:doafric/navigation_drawer_item/terms_and_condition.dart';
import 'package:doafric/page_routes/routes.dart';
import 'package:doafric/screens/addresslist.dart';
import 'package:doafric/screens/checkout.dart';
import 'package:doafric/screens/notifications.dart';
import 'package:flutter/material.dart';
import '../home/accout_screen.dart';
import '../screens/profile.dart';
import '../splash_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    Widget widgetScreen;
    switch (settings.name) {
      case Routes.splashScreen:
        widgetScreen = SplashScreen();
        break;
      case Routes.dashboard:
        widgetScreen = Dashboard();
        break;
      case Routes.loginSignupScreen:
        widgetScreen = LoginSignupScreen();
        break;
      case Routes.loginScreen:
        widgetScreen = LoginScreen();
        break;
      case Routes.signupScreen:
        widgetScreen = SignUpScreen();
        break;
      case Routes.checkoutStepper:
        widgetScreen = const CheckoutScreen();
        break;
      case Routes.forgotpassword:
        widgetScreen = ForgotPassword();
        break;
      case Routes.privacypolicy:
        widgetScreen = PrivacyPolicy();
        break;
      case Routes.termscondition:
        widgetScreen = TermsAndCondition();
        break;
      case Routes.accountScreen:
        widgetScreen = const AccountScreen();
        break;
      case Routes.information:
        widgetScreen = Information();
        break;
      case Routes.helpSupport:
        widgetScreen = HelpSupport();
        break;
      case Routes.aboutus:
        widgetScreen = const Aboutus();
        break;

      case Routes.homeScreen:
        widgetScreen = const HomeScreen();
        break;
      case Routes.categoriesScreen:
        widgetScreen = Categories();
        break;
      case Routes.cartListScreen:
        widgetScreen = CartList();
        break;
      case Routes.productScreen:
        widgetScreen = Product();
        break;
      case Routes.myorder:
        widgetScreen = MyOrder();
        break;
      case Routes.notification:
        widgetScreen = NotifyScreen();
        break;
      case Routes.addresslist:
        widgetScreen = AddressList();
        break;
      case Routes.profiledetails:
        widgetScreen = profileDetails();
        break;
      // case Routes.cancelorder:
      //   widgetScreen = CancelOrder();
      //   break;

      default:
        widgetScreen = SplashScreen();
    }
    return PageRouteBuilder(
        settings: settings,
        pageBuilder: (_, __, ___) => widgetScreen,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = const Offset(0.0, 1.0);
          var end = Offset.zero;
          var curve = Curves.ease;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        });
  }
}
