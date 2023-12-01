import 'package:doafric/checkout/add_address.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

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
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Text("Checkout",style: TextStyle(color: Colors.grey,fontSize: 15),),
                    
                        Text(
                          ' Address Book',
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: (){
                    Get.to(const AddAddress());
                  },
                  child: Container(
                    margin: const EdgeInsets.only(left: 4, right: 4, top: 30),
                    alignment: Alignment.center,
                    height: 85,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: [
                        (Color(0xffe0e0e0)),
                        (Color(0xffe0e0e0))
                      ], begin: Alignment.centerLeft, end: Alignment.centerRight),
                      borderRadius: BorderRadius.circular(1),
                    ),
                    child: const Text(
                      "+  Add A New Address",
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
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
                              height: 25,
                              // width: MediaQuery.of(context).size.width - 5,
                              //  child: Image.network( img, ),
                              child: Image.asset('assets/images/map.png'),
                            ),
                          ],
                        ),
                        const Row(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "         George Floyd",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.black),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "         West Bank",
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.grey),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "         Willow street, taxes 30041",
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.grey),
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
                const SizedBox(
                  height: 20,
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
                              height: 25,
                              // width: MediaQuery.of(context).size.width - 5,
                              //  child: Image.network( img, ),
                              child: Image.asset('assets/images/map.png'),
                            ),
                          ],
                        ),
                        const Row(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "         George Floyd",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.black),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "         South Park",
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.grey),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "         Willow street, taxes 456024",
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.grey),
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
                const SizedBox(
                  height: 20,
                ),
                Container(
                  color: Colors.white,
                  child: const Column(
                    children: [
                      Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [],
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
