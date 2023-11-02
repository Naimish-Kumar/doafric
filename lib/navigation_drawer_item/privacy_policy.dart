import 'package:doafric/apis/api_client.dart';
import 'package:doafric/utils/appbarforall.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class PrivacyPolicy extends StatefulWidget {
  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBarScreens(text: "Privacy Policy"),
      ),
      body: FutureBuilder(
          future: ApiClient.getPrivacyPolicy(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                final map = snapshot.data as Map;
                final desc = map['privacy_policy']['description'];
                print('desc $map');

                return Container(
                    margin: const EdgeInsets.all(15), child: Html(data: desc));
              }
            }
            return const Center(
              child: CircularProgressIndicator(
                color: Color.fromARGB(255, 9, 1, 27),
              ),
            );
          }),
    );
  }
}
