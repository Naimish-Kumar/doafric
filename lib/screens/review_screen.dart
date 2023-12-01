import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({super.key});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: Get.height,
          width: Get.width,
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
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
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Add a New Card',
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 60,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 4, right: 4, top: 30),
                  alignment: Alignment.center,
                  height: 85,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                        colors: [(Color(0xffe0e0e0)), (Color(0xffe0e0e0))],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight),
                    borderRadius: BorderRadius.circular(1),
                  ),
                  child: const Text(
                    "Shipping Address",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        alignment: Alignment.topLeft,
                                        height: 33,
                                        // width: MediaQuery.of(context).size.width - 5,
                                        //  child: Image.network( img, ),
                                        child: Image.asset(
                                            'assets/images/flag.png'),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2),
                              color: Colors.white,
                            ),
                            alignment: Alignment.center,
                            child: TextField(
                              cursorColor: Colors.grey,
                              decoration: InputDecoration(
                                hintText: "Name on Card",
                                hintStyle: TextStyle(
                                    fontSize: 12.0,
                                    color: Colors.grey.withOpacity(0.6)),
                                /*
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none

                                 */
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: TextField(
                              // controller: this.widget._passwordController,
                              //  obscureText: true,
                              cursorColor: Colors.grey,
                              decoration: InputDecoration(
                                hintText: "Card Number",
                                hintStyle: TextStyle(
                                    fontSize: 12.0,
                                    color: Colors.grey.withOpacity(0.6)),
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: TextField(
                              // controller: this.widget._passwordController,
                              //  obscureText: true,
                              cursorColor: Colors.grey,
                              decoration: InputDecoration(
                                hintText: "Expires   MM/YY   cvv  _ ",
                                hintStyle: TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.grey.withOpacity(0.6)),
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: const TextField(
                                // controller: this.widget._passwordController,
                                //  obscureText: true,
                                cursorColor: Colors.black,
                                decoration: InputDecoration(
                                  hintText:
                                      "Billing Address same as Shipping Address?",
                                  hintStyle: TextStyle(
                                    fontSize: 15.0,
                                    // color: Colors.grey.withOpacity(0.6)
                                  ),
                                )),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        alignment: Alignment.topLeft,
                                        height: 30,
                                        // width: MediaQuery.of(context).size.width - 5,
                                        //  child: Image.network( img, ),
                                        child: Image.asset(
                                            'assets/images/map.png'),
                                      ),
                                    ],
                                  ),
                                  const Row(
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "       George Floyd",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.black),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "       West Bank",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.grey),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "       Willow street, Georgia 30041",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.grey),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 170,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 4, right: 4, top: 30),
                  alignment: Alignment.center,
                  height: 35,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [
                      (Color(0xFF113f60)),
                      (Color(0xFF113f60))
                    ], begin: Alignment.centerLeft, end: Alignment.centerRight),
                    borderRadius: BorderRadius.circular(2),
                    boxShadow: const [
                      BoxShadow(
                        offset: Offset(0, 20),
                        blurRadius: 50,
                        color: Colors.white,
                      )
                    ],
                  ),
                  child: const Text(
                    "Save & Continue",
                    style: TextStyle(color: Colors.white),
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
