import 'package:flutter/material.dart';

class CheckoutPay extends StatelessWidget {
  const CheckoutPay({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: const Color.fromARGB(255, 237, 240, 244)),
          ),
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
                    Container(
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Text("Checkout",style: TextStyle(color: Colors.grey,fontSize: 15),),

                          Text(
                            '                         Checkout',
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(left: 4, right: 4, top: 40),
                  alignment: Alignment.center,
                  height: 45,
                  child: const Text(
                    "Payment Method",
                    style: TextStyle(color: Colors.black, fontSize: 19),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                      color: Color(0xFF113f60),
                      gradient: LinearGradient(
                          colors: [
                            (Color(0xFF113f60)),
                            (Color(0xFF113f60))
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter)),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 4, right: 4, top: 10),
                  alignment: Alignment.center,
                  height: 90,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [
                      (Color(0xffe0e0e0)),
                      (Color(0xffe0e0e0))
                    ], begin: Alignment.centerLeft, end: Alignment.centerRight),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    "Credit Card",
                    style: TextStyle(color: Colors.black, fontSize: 25),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 4, right: 4, top: 10),
                  alignment: Alignment.centerLeft,
                  height: 45,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [
                      (Color(0xffe0e0e0)),
                      (Color(0xffe0e0e0))
                    ], begin: Alignment.centerLeft, end: Alignment.centerRight),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Row(
                            children: [
                              Container(
                                alignment: Alignment.topLeft,
                                height: 43,
                                // width: MediaQuery.of(context).size.width - 5,
                                //  child: Image.network( img, ),
                                child: Image.asset('assets/images/paypal.png'),
                              ),
                            ],
                          ),
                          const Row(
                            children: [
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        " Pay Pal",
                                        style: TextStyle(
                                          fontSize: 15.0,
                                        ),
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
                Container(
                  margin: const EdgeInsets.only(left: 4, right: 4, top: 10),
                  alignment: Alignment.centerLeft,
                  height: 45,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [
                      (Color(0xffe0e0e0)),
                      (Color(0xffe0e0e0))
                    ], begin: Alignment.centerLeft, end: Alignment.centerRight),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Row(
                            children: [
                              Container(
                                alignment: Alignment.topLeft,
                                height: 43,
                                // width: MediaQuery.of(context).size.width - 5,
                                //  child: Image.network( img, ),
                                child: Image.asset('assets/images/gpay.png'),
                              ),
                            ],
                          ),
                          const Row(
                            children: [
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,

                                //mainAxisAlignment: MainAxisAlignment.start,
                                //crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "    Google Pay",
                                        style: TextStyle(
                                          fontSize: 15.0,
                                        ),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
