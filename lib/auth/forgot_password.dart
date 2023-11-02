import 'dart:convert';
import 'package:doafric/apis/api.dart';
import 'package:doafric/auth/reset_password.dart';
import 'package:doafric/db_helper/dialog_helper.dart';
import 'package:doafric/page_routes/routes.dart';
import 'package:doafric/utils/app_validator.dart';
import 'package:doafric/utils/button_widget.dart';
import 'package:doafric/utils/button_widgetloader.dart';
import 'package:doafric/utils/textform.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:responsive_sizer/responsive_sizer.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  late ScaffoldMessengerState scaffoldMessenger;
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  final String _error = '';

  final TextEditingController _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(2.h),
          child: Column(
            children: [
              SizedBox(
                height: 2.h,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: GestureDetector(
                  onTap: () => Get.toNamed(Routes.loginSignupScreen),
                  child: const Icon(
                    Icons.arrow_back_ios,
                    size: 25,
                  ),
                ),
              ),
               SizedBox(
                height: 5.h,
              ),
              const Text(
                'Forgot Password',
                style: TextStyle(
                  fontSize: 22,
                  fontFamily: 'Amazon',
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              Form(
                key: _formKey,
                child: TextFormScreen(
                  hinttext: 'Enter your email id',
                  icon: Icons.mail,
                  textEditingController: _emailController,
                  validator: AppValidator.emailValidator,
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              const Text(
                "Enter Your Email Address And We Will Send You Verification Code To Reset Your Password",
                style: TextStyle(
                  fontFamily: 'Amazon',
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Colors.black38,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                _error,
                style: const TextStyle(color: Colors.red, fontSize: 25),
              ),
              SizedBox(
                height: 8.h,
              ),
              !isLoading
                  ? ButtonWidget(
                      text: 'Verify',
                      onTap: () {
                        _trySubmitForm();
                      },
                    )
                  : const ButtonWidgetLoader(),
              SizedBox(
                height: 4.h,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _trySubmitForm() {
    final bool? isValid = _formKey.currentState?.validate();
    if (isValid == true) {
      forgotPassword(_emailController.text);
      isLoading = true;
    }
  }

  forgotPassword(String email) async {
    Map data = {
      'email': email,
    };
    print(email.toString());

    final response = await http.post(Uri.parse(FORGOTPASSWORD),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded"
        },
        body: data,
        encoding: Encoding.getByName("utf-8"));

    setState(() {
      isLoading = false;
    });
    if (response.statusCode == 200) {
      setState(() {
        isLoading = false;
      });
      Map<String, dynamic> res = jsonDecode(response.body);

      if (res['status'] == 'success') {
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => ResetPassword(email)));
      } else {
        DialogHelper.showFlutterToast(strMsg: res['msg']);
      }
    } else {
      DialogHelper.showFlutterToast(strMsg: "Something went wrong");
    }
  }
}
