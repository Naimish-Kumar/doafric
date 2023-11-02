import 'dart:convert';
import 'package:doafric/apis/api.dart';
import 'package:doafric/apis/api_client.dart';
import 'package:doafric/auth/forgot_password.dart';
import 'package:doafric/auth/login_signup_screen.dart';
import 'package:doafric/db_helper/dialog_helper.dart';
import 'package:doafric/utils/app_validator.dart';
import 'package:doafric/utils/button_widget.dart';
import 'package:doafric/utils/button_widgetloader.dart';
import 'package:doafric/utils/style_file.dart';
import 'package:doafric/utils/textform.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:responsive_sizer/responsive_sizer.dart';

// ignore: must_be_immutable
class ResetPassword extends StatefulWidget {
  String email;
  ResetPassword(this.email, {Key? key}) : super(key: key);

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  late ScaffoldMessengerState scaffoldMessenger;

  bool isLoading = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _varifyController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmpasswordController =
      TextEditingController();
  String? email, password, varify, confirmPassword;

  bool _obscureText = true;
  bool _obscureText1 = true;
   String _error = '';
  final _formKey = GlobalKey<FormState>();

  var reg = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  void _trySubmitForm() {
    final bool? isValid = _formKey.currentState?.validate();
    if (isValid == true) {
      resetpassword(_emailController.text, _varifyController.text,
          _newPasswordController.text, _confirmpasswordController.text);
    }
  }

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
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: GestureDetector(
                        onTap: () => Get.off(ForgotPassword()),
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
                      'Reset Password',
                      style: TextStyle(
                        fontFamily: 'Amazon',
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 7.h,
                    ),

                    TextFormScreen(
                      hinttext: 'Email id',
                      icon: Icons.mail,
                      textEditingController: _emailController,
                      validator: AppValidator.emailValidator,
                    ),
                    SizedBox(
                      height: 2.h,
                    ),

                    TextFormScreen(
                      hinttext: 'Enter Varification code',
                      icon: Icons.mail,
                      textEditingController: _varifyController,
                      validator: AppValidator.verifycodeValidator,
                    ),
                    SizedBox(
                      height: 2.h,
                    ),

                    TextFormScreen(
                      hinttext: 'New password',
                      icon: Icons.lock,
                      textEditingController: _newPasswordController,
                      suffixIcon: true,
                      obscure: _obscureText,
                      onPressed: _toggle,
                      validator: AppValidator.passwordValidator,
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    TextFormScreen(
                      hinttext: 'Confirm new password',
                      icon: Icons.lock,
                      textEditingController: _confirmpasswordController,
                      suffixIcon: true,
                      obscure: _obscureText1,
                      onPressed: _toggle1,
                      validator: AppValidator.confirm_passwordValidator,
                    ),

                    SizedBox(
                      height: 2.h,
                    ),
                    Text(
                      _error,
                      style: Style_File.subtitle
                          .copyWith(color: Colors.red, fontSize: 15.sp),
                    ),
                    SizedBox(
                      height: 6.h,
                    ),

                    !isLoading
                        ? ButtonWidget(
                            text: 'Verify',
                            onTap: () {
                              _trySubmitForm();
                            },
                          )
                        : ButtonWidgetLoader(),
                    SizedBox(
                      height: 3.h,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Didn't receive any code?",
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Amazon',
                            fontWeight: FontWeight.bold,
                            color: Colors.black38,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        InkWell(
                          child: const Text(
                            " Resend Again!",
                            style: TextStyle(
                              fontFamily: 'Amazon',
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF113f60),
                            ),
                            textAlign: TextAlign.center,
                          ),
                          onTap: () {
                            var api = ApiClient.resendmail(email: widget.email);
                            api.then((value) {
                              if (value['status'] == 'success') {
                                DialogHelper.showFlutterToast(
                                    strMsg: value['msg']);
                                // Get.back();
                              } else {
                                DialogHelper.showFlutterToast(
                                    strMsg: value['msg']);
                              }
                            }, onError: (error) {
                              throw error.toString();
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _toggle1() {
    setState(() {
      _obscureText1 = !_obscureText;
    });
  }

  resetpassword(String email, String vcode, String newpassword,
      String confirmpassword) async {
    Map data = {
      'email': email,
      'forgot_otp': vcode,
      'new_password': newpassword,
      'confirm_password': confirmpassword
    };
    print(data.toString());

    final response = await http.post(Uri.parse(RESETPASSWORD),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded"
        },
        body: data,
        encoding: Encoding.getByName("utf-8"));

    print(data.toString());

    setState(() {
      isLoading = false;
    });
    if (response.statusCode == 200) {
      setState(() {
        isLoading = false;
      });
      Map<String, dynamic> res = jsonDecode(response.body);

      if (res['status'] == 'success') {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => LoginSignupScreen()));
      } else {
        DialogHelper.showFlutterToast(strMsg: "Something went wrong");
      }
    } else {
      DialogHelper.showFlutterToast(strMsg: "Something went wrong");
    }
  }
}
