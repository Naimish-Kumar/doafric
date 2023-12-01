import 'package:doafric/apis/api_client.dart';
import 'package:flutter/material.dart';

class CustomSearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.length < 3) {
      return const Center(
        child: Text(
          "Search term must be longer than two letters.",
        ),
      );
    }
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final filteredata = <SuggestedData>[];
    return Column(
      children: <Widget>[
        FutureBuilder(
            future: ApiClient.getAllProductListApi(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                Map map = snapshot.data as Map;
                List data = map['product_list']['data'];
                for (int i = 0; i < data.length; i++) {
                  if (data[i]['title']
                      .toLowerCase()
                      .contains(query.toLowerCase())) {
                    filteredata.add(
                      SuggestedData(
                        title: data[i]['title'],
                        image_url: data[i]['image_url'],
                      ),
                    );
                  }
                }
                return Expanded(
                  child: ListView.builder(
                    itemCount: filteredata.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            title: Text(filteredata[index].title),
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Image.network(
                                filteredata[index].image_url,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              }
              return const Expanded(
                child: Center(
                  child: CircularProgressIndicator(
                    color: Color.fromARGB(255, 9, 1, 27),
                  ),
                ),
              );
            })
      ],
    );
  }
}

class SuggestedData {
  String title;
  String image_url;
  SuggestedData({required this.title, required this.image_url});
}
