import 'package:doafric/utils/appbarforall.dart';
import 'package:doafric/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

// ignore: must_be_immutable
class NotifyScreen extends StatefulWidget {
  NotifyScreen({Key? key}) : super(key: key);

  @override
  State<NotifyScreen> createState() => _NotifyScreenState();
}

class _NotifyScreenState extends State<NotifyScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: const PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: AppBarScreens(
              text: "Notifications",
            )),
        body: ListView.builder(
          itemCount: notification().length,
          padding: const EdgeInsets.symmetric(vertical: 16),
          itemBuilder: ( context,index) {
            return Dismissible(
              // background: Container(
              //   color: Colors.red,
              // ),
              key: ValueKey(notification()[index]),
              onDismissed: (DismissDirection direction) {
                setState(() {
                  notification().removeAt(index);
                });
              },
              child: ListTile(
                title:notification()[index]
                ),
            );
          },
        ));
  }
}

 List<Widget> notification() {
  return List.generate(5, (index) => Container(
    height: 9.h,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(1.h),
      boxShadow: const [
        BoxShadow(
          color: Colors.grey,
          spreadRadius: 2,
          blurRadius: 2,
          offset: Offset(1, 2), // changes position of shadow
        ),
      ],
    ),
    child: Padding(
      padding: EdgeInsets.all(1.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Center(
            child: SizedBox(
              height: 40,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: Image.asset(
                  "assets/images/product.png",
                ),
              ),
            ),
          ),
          SizedBox(
            width: 2.w,
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Facebook Gillar notification center',
                  style: TextStyle(color: colorBlack, fontSize: 12),
                ),
                SizedBox(
                  height: 1.h,
                ),
                const Text(
                  'The base use cases for GetSocial Notifications API is to build notify',
                  style: TextStyle(color: colorGrey, fontSize: 10),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  ));
}
