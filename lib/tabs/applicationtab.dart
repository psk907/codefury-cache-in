import 'package:codefury2020/historycard.dart';
import 'package:codefury2020/services/authservice.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ApplicationTab extends StatefulWidget {
  @override
  _ApplicationTabState createState() => _ApplicationTabState();
}

class _ApplicationTabState extends State<ApplicationTab> {
  @override
  Widget build(BuildContext context) {
    SystemUiOverlayStyle.dark.copyWith(statusBarColor: Color(0xffffc45b));

    var size = MediaQuery.of(context).size;
    double mediumfont = size.height * 0.035;
    double smallfont = size.height * 0.02;

    TextStyle headingStyle = TextStyle(
        color: Colors.black,
        fontSize: mediumfont * 1.4,
        fontWeight: FontWeight.w600);
    var wspacing = SizedBox(height: size.height * 0.02);
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
        padding: const EdgeInsets.fromLTRB(20, 50, 20, 0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Flexible(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(
                        // TODO AppLocalizations.of(context).translate('application history'),
                        "History",
                        style: headingStyle,
                      ),
                    ),
                    wspacing,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              Icons.location_on,
                              color: Colors.black54,
                              size: mediumfont,
                            ),
                            SizedBox(width: size.width * 0.04),
                            Text(
                              "Mangalore",
                              //TODO CHANGE LOCATION
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: smallfont * 1.25),
                            )
                          ],
                        ),
                        FlatButton(
                          onPressed: () {
                            AuthService().signOut();
                          },
                          child: Text(
                            "Change",
                            style: TextStyle(
                                fontSize: smallfont, color: Colors.grey[900]),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 9,
                child: Container(
                  child: ListView(
                    // padding: const EdgeInsets.all(8),
                    children: <Widget>[
                      HistoryCard(1),
                      HistoryCard(0),
                      HistoryCard(2), //dummy
                    ],
                  ),
                ),
              ),
            ]),
      )
    ]));
  }
}
