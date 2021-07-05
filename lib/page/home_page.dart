import 'package:dictoryapp/database/DBHelper.dart';
import 'package:dictoryapp/page/drawer_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static const routeName = "/";

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  var _searchController = TextEditingController();

  dynamic vinay;

  String seachvalue = "";
  Future getAllData() async {
    return await DBHelper.getAllData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      drawer: DrawerPage(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: TextFormField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  seachvalue = value;
                });
              },
              decoration: InputDecoration(
                hintText: "Search Word",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
          ),
          FutureBuilder(
            future: seachvalue.isEmpty
                ? DBHelper.getAllData()
                : DBHelper.seachByword(seachvalue),
            builder: (_, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                vinay = snapshot.data;
                return snapshot.hasData
                    ? Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.all(10),
                          itemBuilder: (_, index) => Column(
                            children: [
                              Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                elevation: 5,
                                child: ListTile(
                                  title: Text(
                                    vinay[index]["entry"]
                                        .toString()
                                        .replaceAll("<h1>", "")
                                        .replaceAll("</h1>", "")
                                        .replaceAll("</br>", ""),
                                  ),
                                  trailing: vinay[index]['Fav'] == "1"
                                      ? IconButton(
                                          icon: Icon(
                                            Icons.favorite,
                                            color: Colors.red,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              var data = {
                                                "Fav": "0",
                                              };
                                              DBHelper.myfavWord(
                                                  vinay[index]['_id'], data);
                                            });
                                          },
                                        )
                                      : IconButton(
                                          icon: Icon(
                                            Icons.favorite,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              var data = {
                                                "Fav": "1",
                                              };
                                              DBHelper.myfavWord(
                                                  vinay[index]['_id'], data);
                                            });
                                          },
                                        ),
                                ),
                              ),

                              Divider(),

                              // Card(
                              //   elevation: 10,
                              //   child: Padding(
                              //     padding: EdgeInsets.all(10),
                              //     child: Text(
                              //       vinay[index]['entry']
                              //           .toString()
                              //           .replaceAll("<h1>", "")
                              //           .replaceAll("</h1>", "")
                              //           .replaceAll("</br>", ""),
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                          itemCount: vinay.length,
                        ),
                      )
                    : Center(
                        child: Text("Data Not Found"),
                      );
              }
            },
          ),
        ],
      ),
    );
  }
}
