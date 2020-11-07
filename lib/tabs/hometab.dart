import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codefury2020/configurations/app_localizations.dart';
import 'package:codefury2020/jobcard.dart';
import 'package:codefury2020/models/job.dart';
import 'package:codefury2020/models/language.dart';
import 'package:codefury2020/screens/jobView.dart';
import 'package:flutter/material.dart';
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
    // double smallfont = size.height * 0.02;
    TextEditingController _nameController = new TextEditingController();
    TextStyle headingStyle =
        TextStyle(fontSize: mediumfont * 1.5, fontWeight: FontWeight.w600);
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
                wspacing,
                Container(
                  height: size.height * 0.055,
                  child: TextFormField(
                    controller: _nameController,
                    textInputAction: TextInputAction.done,
                    autocorrect: false,
                    style: TextStyle(
                        fontSize: mediumfont * 0.6, color: Colors.black),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 20),
                      hintText: 'Search',
                      suffixIcon: Icon(Icons.search),
                      hintStyle: TextStyle(
                          color: Colors.grey, fontSize: mediumfont * 0.5),
                      filled: true,
                      fillColor: Colors.green[50],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                    ),
                  ),
                ),
                wspacing,
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('employers')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Container(
                        height: MediaQuery.of(context).size.height * 0.6,
                        child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            Job jobData =
                                Job.fromJson(snapshot.data.docs[index].data());
                            // TODO : Use this data in the card
                            return InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            JobViewPage(job: jobData),
                                      ));
                                },
                                // child: Card(
                                //   child: Text(jobData.toString()),
                                // ));
                                child: JobCard(job: jobData));
                          },
                          itemCount: snapshot.data.size,
                        ),
                      );
                    }
                    return Center(child: CircularProgressIndicator());
                  },
                ),
              ],
            )));
  }
}
