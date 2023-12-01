// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';
import '../apis/api.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  _SignUpState createState() => _SignUpState();
}



class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  late String name, email, password, reppassword, phoneno;
  bool isLoading = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  late ScaffoldMessengerState scaffoldMessenger;
  var reg = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _reppasswordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    scaffoldMessenger = ScaffoldMessenger.of(context);
    return Scaffold(
        key: _scaffoldKey,
        body: SingleChildScrollView(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: <Widget>[
                // Container(
                //   width: double.infinity,
                //   height: double.infinity,
                //   child: Image.asset(
                //     "assets/background.jpg",
                //     fit: BoxFit.fill,
                //   ),
                // ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      // Center(
                      //     child: Image.asset(
                      //   "assets/logo.png",
                      //   height: 30,
                      //   width: 30,
                      //   alignment: Alignment.center,
                      // )),
                      const SizedBox(
                        height: 13,
                      ),
                      const Text(
                        "Learn With Us",
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const SizedBox(
                        width: 180,
                        child: Text(
                          "RRTutors, Hyderabad",
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Sign Up",
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Learn new Technologies 😋",
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Form(
                        key: _formKey,
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 45),
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                style: const TextStyle(
                                  color: Colors.black,
                                ),
                                controller: _nameController,
                                decoration: const InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black)),
                                  hintText: "Name",
                                  hintStyle: TextStyle(
                                      color: Colors.black, fontSize: 15),
                                ),
                                onSaved: (val) {
                                  name = val!;
                                },
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              TextFormField(
                                style: const TextStyle(
                                  color: Colors.black,
                                ),
                                controller: _emailController,
                                decoration: const InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black)),
                                  hintText: "Email",
                                  hintStyle: TextStyle(
                                      color: Colors.black, fontSize: 15),
                                ),
                                onSaved: (val) {
                                  email = val!;
                                },
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              TextFormField(
                                style: const TextStyle(
                                  color: Colors.black,
                                ),
                                controller: _passwordController,
                                decoration: const InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black)),
                                  hintText: "Password",
                                  hintStyle: TextStyle(
                                      color: Colors.black, fontSize: 15),
                                ),
                                onSaved: (val) {
                                  password = val!;
                                },
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              TextFormField(
                                style: const TextStyle(
                                  color: Colors.black,
                                ),
                                controller: _reppasswordController,
                                decoration: const InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black)),
                                  hintText: "Password",
                                  hintStyle: TextStyle(
                                      color: Colors.black, fontSize: 15),
                                ),
                                onSaved: (val) {
                                  reppassword = val!;
                                },
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              TextFormField(
                                style: const TextStyle(
                                  color: Colors.black,
                                ),
                                controller: _phoneController,
                                decoration: const InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black)),
                                  hintText: "Password",
                                  hintStyle: TextStyle(
                                      color: Colors.black, fontSize: 15),
                                ),
                                onSaved: (val) {
                                  phoneno = val!;
                                },
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Stack(
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    width: double.infinity,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 0),
                                    height: 50,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.white),
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        if (isLoading) {
                                          return;
                                        }
                                        if (_nameController.text.isEmpty) {
                                          scaffoldMessenger.showSnackBar(
                                              const SnackBar(
                                                  content: Text(
                                                      "Please Enter Name")));
                                          return;
                                        }
                                        if (!reg
                                            .hasMatch(_emailController.text)) {
                                          scaffoldMessenger.showSnackBar(
                                              const SnackBar(
                                                  content: Text(
                                                      "Enter Valid Email")));
                                          return;
                                        }
                                        if (_passwordController.text.isEmpty ||
                                            _passwordController.text.length <
                                                6) {
                                          scaffoldMessenger.showSnackBar(const SnackBar(
                                              content: Text(
                                                  "Password should be min 6 characters")));
                                          return;
                                        }
                                        if (_reppasswordController
                                                .text.isEmpty ||
                                            _reppasswordController.text.length <
                                                6) {
                                          scaffoldMessenger.showSnackBar(const SnackBar(
                                              content: Text(
                                                  "Password should be min 6 characters")));
                                          return;
                                        }
                                        signup(
                                            _nameController.text,
                                            _emailController.text,
                                            _passwordController.text,
                                            _reppasswordController.text,
                                            _phoneController.text);
                                      },
                                      child: const Text(
                                        "CREATE ACCOUNT",
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    right: 30,
                                    bottom: 0,
                                    top: 0,
                                    child: (isLoading)
                                        ? const Center(
                                            child: SizedBox(
                                                height: 26,
                                                width: 26,
                                                child:
                                                    CircularProgressIndicator(
                                                  backgroundColor: Colors.green,
                                                )))
                                        : Container(),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacementNamed(context, "/signin");
                        },
                        child: const Text(
                          "Already have an account?",
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  signup(name, email, password, reppassword, phone) async {
    setState(() {
      isLoading = false;
    });
    print("Calling");

    Map data = {
      'email': email,
      'password': password,
      'psw_repeat': reppassword,
      'name': name,
      'mobile': phone,
      'role_id': "2"
    };

    print(data.toString());
    final response = await http.post(Uri.parse(REGISTRATION),
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
      print(res);
      if (res['status']  =="success") {
        Map<String, dynamic> user = res['data'];
        print(" User name ${user['data']}");
        savePref(1, user['name'], user['email'], user['id'], user['mobile']);
        Navigator.pushReplacementNamed(context, "/home");
      } else {
        scaffoldMessenger
            .showSnackBar(const SnackBar(content: Text("Something Went Wrong")));
      }

    } else {
      scaffoldMessenger
          .showSnackBar(const SnackBar(content: Text("Please Try again")));
    }
  }

  savePref(int value, String name, String email, int id, String mobile) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    preferences.setInt("value", value);
    preferences.setString("name", name);
    preferences.setString("email", email);
    preferences.setString("mobile", mobile);
    preferences.setString("id", id.toString());
    preferences.commit();
  }
}
