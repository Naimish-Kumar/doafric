// ignore_for_file: must_be_immutable, library_private_types_in_public_api, non_constant_identifier_names, use_build_context_synchronously

import 'dart:convert';
import 'package:doafric/apis/api.dart';
import 'package:doafric/db_helper/dialog_helper.dart';
import 'package:doafric/navigation_drawer_item/myorder.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class CancelOrder extends StatefulWidget {
  int id;
  CancelOrder({super.key, 
    required this.id,
  });
  @override
  _CancelOrderState createState() => _CancelOrderState();
}

class _CancelOrderState extends State<CancelOrder> {
  bool isLoading = false;

  final TextEditingController _CancellationreasonController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    print(widget.id);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xfff7f6fb),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 32),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(
                    Icons.arrow_back,
                    size: 32,
                    color: Colors.black54,
                  ),
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              const SizedBox(
                height: 24,
              ),
              const Text(
                'Cancel Order',
                style: TextStyle(
                  fontFamily: 'Amazon',
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Comments for Cancel order ",
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Amazon',
                  fontWeight: FontWeight.bold,
                  color: Colors.black38,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 25,
              ),
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.zero),
                ),
                alignment: Alignment.center,
                child: TextFormField(
                    maxLines: 7,
                    controller: _CancellationreasonController,
                    cursorColor: Colors.grey,
                    decoration: InputDecoration(
                        hintText: "Cancellation Reason",
                        hintStyle: TextStyle(
                            fontFamily: 'Amazon',
                            fontSize: 12.0,
                            color: Colors.grey.withOpacity(0.6)),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: const BorderSide(color: Colors.black12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: const BorderSide(color: Colors.black12),
                        ))),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.all(28),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 22,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (isLoading) {
                            return;
                          }

                          cancelorder(
                            _CancellationreasonController.text,
                          );
                        },
                        style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              const Color(0xFF113f60)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24.0),
                            ),
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(14.0),
                          child: Text(
                            'Submit',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Amazon',
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }

  cancelorder(String cancelreason) async {
    Map data = {
      'id': widget.id.toString(),
      'cancellation_reason': cancelreason
    };
    print(data.toString());

    final response = await http.post(Uri.parse(CANCELORDER),
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
      print(res);

      if (res['status'] == 'success') {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const MyOrder()));
        DialogHelper.showFlutterToast(strMsg: "Your Order Cancel Successfully");
      } else {
        DialogHelper.showFlutterToast(strMsg: "Something went wrong");
      }
    } else {
      DialogHelper.showFlutterToast(strMsg: "Something went wrong");
    }
  }
}
