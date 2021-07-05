import 'package:dictoryapp/database/DBHelper.dart';
import 'package:dictoryapp/page/drawer_page.dart';
import 'package:flutter/material.dart';

class FavroitePage extends StatefulWidget {
  const FavroitePage({Key? key}) : super(key: key);

  static const routeName = "favorite-page";

  @override
  _FavroitePageState createState() => _FavroitePageState();
}

class _FavroitePageState extends State<FavroitePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Favorite"),
      ),
      drawer: DrawerPage(),
      body: FutureBuilder(
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            dynamic vinay = snapshot.data;
            return snapshot.hasData
                ? ListView.builder(
                    itemCount: vinay.length,
                    itemBuilder: (_, index) => Column(
                      children: [
                        ListTile(
                          title: Text(
                            vinay[index]['entry']
                                .toString()
                                .replaceAll("<h1>", "")
                                .replaceAll("</h1>", "")
                                .replaceAll("<br>", "")
                                .replaceAll("</br>", ""),
                          ),
                          trailing: IconButton(
                            icon: Icon(
                              Icons.favorite,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              setState(() {
                                var data = {
                                  "Fav": "0",
                                };
                                DBHelper.myfavWord(vinay[index]['_id'], data);
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                : Center(
                    child: Text("No Favorite Yet"),
                  );
          }
        },
        future: DBHelper.getFavByOne(),
      ),
    );
  }
}
