import 'package:doafric/apis/api_client.dart';
import 'package:doafric/utils/appbarforall.dart';
import 'package:flutter/material.dart';
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
                print('desc $desc');

                return Container(
                  margin: const EdgeInsets.all(15),
                  //child: Html(data: desc,),
                  child: const Text(
                    'With Browsewrap, agreement links are displayed in a footer or similarly. However, they don\'t require an active acceptance from the user as in the example above. Browsewrap assumes user\'s acceptance or opt in is assumed by virtue of their using your site. A paragraph somewhere in the legal agreement will say something along the lines of, "By using this website, you\'re agreeing to be bound by our Terms."Here\'s an example of a classic Browsewrap clause in a T&C:',
                    textAlign: TextAlign.justify,
                    style: TextStyle(fontSize: 16),
                  ),
                );
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
