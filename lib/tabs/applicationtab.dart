import 'package:codefury2020/configurations/app_localizations.dart';
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

    TextStyle headingStyle =
        TextStyle(fontSize: mediumfont * 1.25, fontWeight: FontWeight.w600);
    var hspacing = SizedBox(height: size.height * 0.02);
    var wspacing = SizedBox(height: size.height * 0.05);
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.fromLTRB(30, 50, 25, 0),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              // TODO AppLocalizations.of(context).translate('application history'),
              "History",
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
                      "Mangalore",
                      style: TextStyle(fontSize: smallfont * 1.25),
                    )
                  ],
                ),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    "Change",
                    style: TextStyle(fontSize: smallfont, color: Colors.indigo),
                  ),
                )
              ],
            ),
            wspacing,
            Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(30)),
                width: size.width,
                height: size.height * 0.15,
                child: Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const ListTile(
                        leading: Icon(Icons.grass_sharp),
                        title: Text('Famring'),
                        subtitle: Text('Shetty'),
                      ),
                      const Text('Salary : 5000', textAlign: TextAlign.left),
                      const Text('Location : Udupi', textAlign: TextAlign.left),
                    ],
                  ),
                ))
          ]),
    ));
  }
}
