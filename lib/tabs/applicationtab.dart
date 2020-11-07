import 'package:codefury2020/configurations/app_localizations.dart';
import 'package:codefury2020/historycard.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

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

    TextStyle headingStyle =
        TextStyle(fontSize: mediumfont * 1.25, fontWeight: FontWeight.w600);
    var hspacing = SizedBox(height: size.height * 0.02);
    var wspacing = SizedBox(height: size.height * 0.05);
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.fromLTRB(28, 50, 20, 0),
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
                  Text(
                    // TODO AppLocalizations.of(context).translate('application history'),
                    AppLocalizations.of(context).translate('History'),
                    style: headingStyle,
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
                            size: mediumfont,
                          ),
                          SizedBox(width: size.width * 0.04),
                          Text(
                            AppLocalizations.of(context).translate('Mangalore'),
                            style: TextStyle(fontSize: smallfont * 1.25),
                          )
                        ],
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          AppLocalizations.of(context).translate('Change'),
                          style: TextStyle(
                              fontSize: smallfont, color: Colors.indigo),
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
    ));
  }
}
