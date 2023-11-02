import 'package:doafric/apis/api_client.dart';
import 'package:doafric/utils/appbarforall.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

class TermsAndCondition extends StatefulWidget {
  const TermsAndCondition({super.key});

  @override
  State<TermsAndCondition> createState() => _TermsAndConditionState();
}

class _TermsAndConditionState extends State<TermsAndCondition> {
  RxInt quantity = 1.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBarScreens(text: "Terms and conditions"),
      ),
      body: FutureBuilder(
          future: ApiClient.getTermsandConditions(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                final map = snapshot.data as Map;
                final desc = map['terms_condition']['description'];
                print('desc $map');

                return Container(
                    margin: const EdgeInsets.all(15), child: Html(data: desc,),);
              }
            }
            return const Center(
                child: CircularProgressIndicator(
              color: Color.fromARGB(255, 9, 1, 27),
            ));
          }),
    );
  }
}
