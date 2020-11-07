import 'package:codefury2020/historycard.dart';
import 'package:flutter/material.dart';

class ApplicationTab extends StatefulWidget {
  @override
  _ApplicationTabState createState() => _ApplicationTabState();
}

class _ApplicationTabState extends State<ApplicationTab> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double mediumfont = size.height * 0.035;
    double smallfont = size.height * 0.02;

    TextStyle headingStyle = TextStyle(
        color: Colors.white,
        fontSize: mediumfont * 1.4,
        fontWeight: FontWeight.w600);
    var wspacing = SizedBox(height: size.height * 0.02);
    return SafeArea(
        child: Stack(children: [
      Container(
        height: size.height * 0.35,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment
                .bottomCenter, // 10% of the width, so there are ten blinds.
            colors: [
              Colors.blue[600],
              Colors.blue[500],
              Colors.blue[400],
              Colors.blue[300],
              Colors.blue[200],
              Colors.blue[100],
              Colors.white
            ],
            // repeats the gradient over the canvas
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
                          onPressed: () {},
                          child: Text(
                            "Change",
                            style: TextStyle(
                                fontSize: smallfont, color: Colors.grey[200]),
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
