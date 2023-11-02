import 'package:flutter/material.dart';

import 'orderdelivered.dart';
import 'orderprogress.dart';
import 'orderreview.dart';

class OrderHome extends StatefulWidget {
  const OrderHome({Key? key}) : super(key: key);

  @override
  State<OrderHome> createState() => _OrderHomeState();
}

class _OrderHomeState extends State<OrderHome> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: AppBar(
            title: const Text(
              "Orders",
            ),
            centerTitle: true,
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            bottom: const TabBar(
              labelColor: Colors.black,
              tabs: [
                Tab(
                  text: "In Progress",
                ),
                Tab(
                  text: "Delivered",
                ),
                Tab(
                  text: "Reviews",
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              OrderProgress(),
              OrderDeliverd(),
              OrderReview(),
            ],
          )),
    );
  }
}
