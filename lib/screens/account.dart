// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  bool isSignUpScreen = true;

  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(children: <Widget>[
        Container(
          height: 150,

          width: MediaQuery.of(context).size.width,
          color: const Color(0xFF113f60),
          // Color.fromARGB(255, 3, 16, 37),
          // child:  Image(image: AssetImage("assets/images/ban1.png",),)

          child: Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      // Image(image: AssetImage("assets/images/settings.png",
                      Icon(Icons.settings, color: Colors.white),
                    ],
                  ),
                  Column(
                    children: [
                      Icon(Icons.shopping_bag_outlined, color: Colors.white),
                    ],
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.only(left: 32, right: 32, top: 32),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SizedBox(
                      height: 60,
                      width: 60,
                      child: ClipOval(
                        child: Image.asset(
                          'assets/images/cat1.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "George Floyd",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ))
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 70,
          width: 350,
          color: Colors.black,
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  Text('New Member Gift \n 5% OFF',
                      style: TextStyle(fontSize: 15, color: Colors.yellow)),
                  VerticalDivider(),
                  Text('Birthday Gift Item \n 5% OFF',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.yellow,
                      )),
                ],
              ),
            ],
          ),
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                SizedBox(
                  height: 35,
                ),
                Center(
                  child: Text(
                    "My Orders",
                    style: TextStyle(fontSize: 15, color: Colors.black),
                  ),
                ),
                SizedBox(
                  height: 35,
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  "View All >",
                  style: TextStyle(fontSize: 15, color: Colors.black),
                ),
              ],
            ),
          ],
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Image(
                    image: AssetImage(
                      "assets/images/progress.png",
                    ),
                    width: 30,
                    height: 30,
                    fit: BoxFit.fill),
                Text(
                  "In Progress",
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                )
              ],
            ),
            Column(
              children: [
                Image(
                    image: AssetImage(
                      "assets/images/ship.png",
                    ),
                    width: 30,
                    height: 30,
                    fit: BoxFit.fill),
                Text(
                  "Deliverd",
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                )
              ],
            ),
            Column(
              children: [
                Image(
                    image: AssetImage(
                      "assets/images/reviews.png",
                    ),
                    width: 30,
                    height: 30,
                    fit: BoxFit.fill),
                Text(
                  "Reviews",
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                )
              ],
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //  crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              //  mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton.icon(
                      // <-- TextButton
                      onPressed: () {},
                      icon: const Icon(
                        Icons.notifications,
                        size: 20.0,
                        color: Colors.grey,
                      ),
                      label: const Text(
                        "Address Book",
                        style: TextStyle(fontSize: 12, color: Colors.black),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.arrow_forward_ios,
                              size: 20.0,
                              color: Colors.grey,
                            )),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton.icon(
                      // <-- TextButton
                      onPressed: () {},
                      icon: const Icon(
                        Icons.credit_card,
                        size: 20.0,
                        color: Colors.grey,
                      ),
                      label: const Text(
                        "Payment",
                        style: TextStyle(fontSize: 12, color: Colors.black),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_forward_ios,
                          size: 20.0,
                          color: Colors.grey,
                        )),
                  ],
                ),
                Row(
                  children: [
                    TextButton.icon(
                      // <-- TextButton
                      onPressed: () {},
                      icon: const Icon(
                        Icons.person,
                        size: 20.0,
                        color: Colors.grey,
                      ),
                      label: const Text(
                        "Profile",
                        style: TextStyle(fontSize: 12, color: Colors.black),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          //  Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_forward_ios,
                          size: 20.0,
                          color: Colors.grey,
                        )),
                  ],
                ),
                Row(
                  children: [
                    TextButton.icon(
                        // <-- TextButton
                        onPressed: () {},
                        icon: const Icon(
                          Icons.notifications,
                          size: 20.0,
                          color: Colors.grey,
                        ),
                        label: const Text("Help Center",
                            style:
                                TextStyle(fontSize: 12, color: Colors.black))),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.arrow_forward_ios,
                          size: 20.0,
                          color: Colors.grey,
                        )),
                  ],
                ),
                Row(
                  children: [
                    TextButton.icon(
                      // <-- TextButton
                      onPressed: () {},
                      icon: const Icon(
                        Icons.notifications,
                        size: 20.0,
                        color: Colors.grey,
                      ),
                      label: const Text(
                        "Give Us Your Feedback",
                        style: TextStyle(fontSize: 12, color: Colors.black),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_forward_ios,
                          size: 20.0, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ]),
    ));
  }
}
