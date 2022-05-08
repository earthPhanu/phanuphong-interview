import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:iterview_phanuphong/model/model.dart';
import 'package:iterview_phanuphong/screen/detail.dart';

class CampaignPage extends StatefulWidget {
  const CampaignPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<CampaignPage> createState() => _CampaignPageState();
}

class _CampaignPageState extends State<CampaignPage> {
  List<dynamic> campaignsArr = [];
  late Campaigns campaignsData;
  List<Map<String, dynamic>> map = [];

  getCampaigns() async {
    setState(() {
      campaignsArr = [];
    });

    final response = await http.get(Uri.parse(
        'https://firebasestorage.googleapis.com/v0/b/android-interview-test.appspot.com/o/campaigns.json?alt=media&token=2c4ae9ee-79f1-429e-8e68-47a176ec9348'));

    if (response.statusCode == 200) {
      map = List<Map<String, dynamic>>.from(jsonDecode(response.body));

      setState(() {
        map = map;
      });
    } else {
      AlertDialog alertDialog = AlertDialog(
        content: Text(
          'Fail to load Data.!!!',
          textAlign: TextAlign.center,
        ),
        actions: <Widget>[
          TextButton(
            child: Text('OK'),
            style: TextButton.styleFrom(primary: Colors.blue),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
      showDialog(context: context, builder: (_) => alertDialog);
    }
  }

  @override
  void initState() {
    super.initState();
    getCampaigns();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          widget.title,
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GridView.builder(
                  shrinkWrap: true,
                  primary: false,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: MediaQuery.of(context).size.width /
                        (MediaQuery.of(context).size.height / 1.25),
                  ),
                  itemCount: map == null ? 0 : map.length,
                  itemBuilder: (BuildContext context, int index) {
                    Campaigns mapSS1 = Campaigns.fromJson(map[index]);
                    return Card(
                      child: InkWell(
                        child: ListView(
                          shrinkWrap: true,
                          primary: false,
                          children: <Widget>[
                            Stack(
                              children: <Widget>[
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height / 3.6,
                                  width:
                                      MediaQuery.of(context).size.width / 2.2,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.network(
                                      mapSS1.imageUrl ?? '',
                                      fit: BoxFit.fitWidth,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 2.0, top: 8.0),
                              child: Text(
                                mapSS1.name ?? '',
                                style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w600,
                                ),
                                maxLines: 2,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 2.0, top: 8.0),
                              child: Text(
                                mapSS1.price ?? '',
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w900,
                                    color: Color.fromARGB(255, 245, 214, 62)),
                                maxLines: 2,
                              ),
                            ),
                          ],
                        ),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (BuildContext context) {
                                return Detail(
                                  name: mapSS1.name ?? '',
                                  img: mapSS1.imageUrl ?? '',
                                  price: mapSS1.price ?? '',
                                  desc: mapSS1.description ?? '',
                                );
                              },
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
