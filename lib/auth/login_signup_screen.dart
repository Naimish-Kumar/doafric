import 'package:doafric/auth/login_screen.dart';
import 'package:doafric/auth/signup_screen.dart';
import 'package:doafric/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LoginSignupScreen extends StatefulWidget {
  const LoginSignupScreen({super.key});

  @override
  _LoginSignupScreenState createState() => _LoginSignupScreenState();
}

class _LoginSignupScreenState extends State<LoginSignupScreen> {
  bool isSignupScreen = true;
  bool isRememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50.0),
        child: SafeArea(
          child: Container(
            alignment: Alignment.topLeft,
            height: 50,
            color: Colors.white,
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              tooltip: 'Back',
              onPressed: () {
                Get.back();
              }, // null disables the button
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Positioned(
                top: 0,
                right: 0,
                left: 0,
                child: Container(
                  child: Container(
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        RichText(
                          text: TextSpan(
                              text: isSignupScreen ? "" : "Welcome",
                              style: const TextStyle(
                                fontSize: 16,
                                letterSpacing: 2,
                                fontFamily: 'Amazon',
                                color: Colors.black,
                              ),
                              children: [
                                TextSpan(
                                  text: isSignupScreen
                                      ? " Create a new Account"
                                      : "",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Amazon',
                                    color: Colors.black,
                                  ),
                                )
                              ]),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: isSignupScreen ? 100 : 100,
                child: Container(
                  padding: EdgeInsets.all(2.h),
                  width: MediaQuery.of(context).size.width,
                  //  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isSignupScreen = true;
                                });
                              },
                              child: Column(
                                children: [
                                  Text(
                                    "Sign Up",
                                    style: TextStyle(
                                        fontFamily: 'Amazon',
                                        fontSize: 14,
                                        color: isSignupScreen
                                            ? const Color(0xFF113f60)
                                            : Colors.grey),
                                  ),
                                  if (isSignupScreen)
                                    Container(
                                      margin: const EdgeInsets.only(top: 3),
                                      height: 2,
                                      width: 55,
                                      color: colorPrimary,
                                    )
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isSignupScreen = false;
                                });
                              },
                              child: Column(
                                children: [
                                  Text(
                                    "Sign In",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'Amazon',
                                        fontWeight: FontWeight.bold,
                                        color: !isSignupScreen
                                            ? colorPrimary
                                            : Colors.grey),
                                  ),
                                  if (!isSignupScreen)
                                    Container(
                                      margin: const EdgeInsets.only(top: 3),
                                      height: 2,
                                      width: 55,
                                      color: const Color(0xFF113f60),
                                    )
                                ],
                              ),
                            ),
                          ],
                        ),
                        if (!isSignupScreen) buildSigninSection(),
                        if (isSignupScreen) buildSignupSection(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container buildSigninSection() {
    return Container(
        color: Colors.white,
        margin: EdgeInsets.only(top: 1.h),
        height: MediaQuery.of(context).size.height - 40,
        child: const LoginScreen());
  }

  Container buildSignupSection() {
    return Container(
        margin: EdgeInsets.only(top: 1.h),
        height: MediaQuery.of(context).size.height,
        child: SignUpScreen());
  }
}
