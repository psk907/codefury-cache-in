import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codefury2020/configurations/app_localizations.dart';
import 'package:codefury2020/jobcard.dart';
import 'package:codefury2020/models/job.dart';
import 'package:codefury2020/models/language.dart';
import 'package:codefury2020/screens/jobView.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle.dark.copyWith(statusBarColor: Color(0xffffc45b)));
    var size = MediaQuery.of(context).size;
    double mediumfont = size.height * 0.035;
    // double smallfont = size.height * 0.02;
    TextEditingController _nameController = new TextEditingController();
    TextStyle headingStyle =
        TextStyle(fontSize: mediumfont * 1.5, fontWeight: FontWeight.w600);
    var hspacing = SizedBox(height: size.height * 0.02);
    var wspacing = SizedBox(height: size.height * 0.05);
    return SafeArea(
        child: Stack(children: [
      Container(
        height: size.height * 0.4,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment
                .bottomCenter, // 10% of the width, so there are ten blinds.
            colors: [
              Color(0xffffc45b),
              Color(0xffffcd74),
              Color(0xffffd281),
              Color(0xffffd78f),
              Color(0xffffdc9d),
              Color(0xffffe6b9),
              Colors.white,
              Colors.grey[50],
              Colors.grey[100]
            ],
          ),
        ),
      ),
      Padding(
          padding: const EdgeInsets.fromLTRB(30, 0, 25, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Spacer(flex: 2),
              Expanded(
                flex: 4,
                child: Row(
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
              ),
              // wspacing,
              Spacer(),
              Flexible(
                flex: 2,
                child: TextFormField(
                  controller: _nameController,
                  textInputAction: TextInputAction.done,
                  autocorrect: false,
                  style: TextStyle(
                      fontSize: mediumfont * 0.6, color: Colors.black),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 20),
                    hintText: AppLocalizations.of(context).translate('Search'),
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
              // wspacing,
              Spacer(),
              Align(
                alignment: Alignment.centerRight,
                child: FlatButton.icon(
                    onPressed: () {},
                    icon: Icon(
                      Icons.filter_list_alt,
                      color: Colors.grey[800],
                      size: mediumfont * 0.7,
                    ),
                    label: Text(
                      'Filter by',
                      style: TextStyle(
                          color: Colors.grey[800], fontSize: mediumfont * 0.8),
                    )),
              ),
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('employers')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                      height: size.height * (1 - 12 / 35),
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
                  return CircularProgressIndicator();
                },
              ),
            ],
          ))
    ]));
  }
}
