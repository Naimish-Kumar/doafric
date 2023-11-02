import 'package:doafric/utils/colors.dart';
import 'package:flutter/material.dart';

class AppBarScreens extends StatelessWidget {
  final String? image;
  final String? text;
  final String? icon2;
  final String? icon3;

  final Function()? onPressed;
  const AppBarScreens({
    Key? key,
    this.image,
    this.text,
    this.icon2,
    this.icon3,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData(
        color: Colors.black,
      ),
      centerTitle: true,
      elevation: 5,
      backgroundColor: colorWhite,
      title: Text(
        text ?? '',
        style: const TextStyle(color: Colors.black),
      ),
      actions: const [
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.start,
        //   children: [
        //     IconButton(
        //       onPressed: onPressed,
        //       icon: Icon(Icons.notifications_outlined),
        //       color: colorBlack,
        //     ),
        //   ],
        // ),
      ],
    );
  }
}
