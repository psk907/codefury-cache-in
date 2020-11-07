import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codefury2020/configurations/app_localizations.dart';
import 'package:codefury2020/models/language.dart';
import 'package:flutter/material.dart';
import '../jobmodel.dart';
import '../main.dart';

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  void _changeLanguage(Language language) {
    Locale _temp;
    switch (language.languageCode) {
      case 'en':
        _temp = Locale(language.languageCode, 'US');
        break;
      case 'hi':
        _temp = Locale(language.languageCode, 'IN');
        break;
    }
    MyApp.setLocale(context, _temp);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double mediumfont = size.height * 0.035;
    double smallfont = size.height * 0.02;

    TextStyle headingStyle =
        TextStyle(fontSize: mediumfont * 1.25, fontWeight: FontWeight.w600);
    var hspacing = SizedBox(height: size.height * 0.02);
    var wspacing = SizedBox(height: size.height * 0.05);
    return SafeArea(
        child: Padding(
            padding: const EdgeInsets.fromLTRB(30, 50, 25, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context).translate('welcome'),
                      style: headingStyle,
                    ),
                    DropdownButton(
                      underline: SizedBox(),
                      icon: Icon(Icons.language),
                      iconSize: mediumfont,
                      items: Language.languageList()
                          .map<DropdownMenuItem>((lang) => DropdownMenuItem(
                                child: Text(lang.name),
                                value: lang,
                              ))
                          .toList(),
                      onChanged: (language) {
                        _changeLanguage(language);
                      },
                    ),
                  ],
                ),
                Container(child: Text("Search bar")),
                StreamBuilder<QuerySnapshot>(
                  stream:
                      FirebaseFirestore.instance.collection('jobs').snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Container(
                        height: MediaQuery.of(context).size.height * 0.5,
                        child: ListView.builder(
                          itemBuilder: (BuildContext context, int index) {
                            return RaisedButton(
                                child: Text(snapshot.data.docs[index]
                                    .data()
                                    .toString()),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => JobModel()),
                                  );
                                });
                          },
                          itemCount: snapshot.data.size,
                        ),
                      );
                    }
                  },
                ),
              ],
            )));
  }
}
