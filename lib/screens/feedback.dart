import 'package:doafric/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class feedback extends StatelessWidget {
  const feedback({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back_ios)),
                   const  Text(
                      'Feedback',
                      style: TextStyle(
                          color: colorPrimary,
                          fontWeight: FontWeight.w500,
                          fontSize: 18),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                const Text(
                  "* Write your feedback here",
                 style: TextStyle(
                      color: colorPrimary, fontWeight: FontWeight.w500),
                ),
                const Column(
                  children: <Widget>[
                    Card(
                        color: Colors.white,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: TextField(
                            maxLines: 8, //or null
                            decoration: InputDecoration.collapsed(
                                hintText: "Enter your text here"),
                          ),
                        ))
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "* Name",
                  style: TextStyle(color: colorPrimary,fontWeight: FontWeight.w500),
                ),
                Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      Column(
                        children: <Widget>[
                          Container(
                            alignment: Alignment.center,
                            child: TextField(
                              // controller: this.widget._passwordController,
                              //  obscureText: true,
                              cursorColor: Colors.grey,
                              decoration: InputDecoration(
                                hintText: "Name",
                                hintStyle: TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.grey.withOpacity(0.6),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "* Email",
                  style: TextStyle(
                      color: colorPrimary, fontWeight: FontWeight.w500),
                ),
                Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      Column(
                        children: <Widget>[
                          Container(
                            alignment: Alignment.center,
                            child: TextField(
                              // controller: this.widget._passwordController,
                              //  obscureText: true,
                              cursorColor: Colors.grey,
                              decoration: InputDecoration(
                                hintText: "Email",
                                hintStyle: TextStyle(
                                    fontSize: 12.0,
                                    color: Colors.grey.withOpacity(0.6)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Center(
                  child: Container(
                    alignment: Alignment.center,
                    height: 50,
                    width: Get.width/2,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                          colors: [(Color(0xFF113f60)), (Color(0xFF113f60))],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: const [
                        BoxShadow(
                          offset: Offset(0, 20),
                          blurRadius: 50,
                          color: Colors.white,
                        )
                      ],
                    ),
                    child: const Text(
                      "Submit",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
