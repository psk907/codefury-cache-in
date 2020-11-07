import 'package:flutter/material.dart';
import 'dart:math' as math;

class JobModel extends StatefulWidget {
  @override
  _JobModelState createState() => _JobModelState();
}

class _JobModelState extends State<JobModel> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double mediumfont = size.height * 0.035;
    double smallfont = size.height * 0.02;

    TextStyle headingStyle =
        TextStyle(fontSize: mediumfont, fontWeight: FontWeight.w600);
    var hspacing = SizedBox(height: size.height * 0.02);
    var wspacing = SizedBox(height: size.height * 0.05);

    return Scaffold(
        body: Stack(
      children: [
        SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(25, mediumfont * 3.2, 20, 0),
          physics: ClampingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Image.asset(
                          'images/demoprof.png',
                          width: size.width * 0.35,
                        ),
                      ),
                      wspacing
                    ],
                  ),
                  Spacer(),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                        AppLocalizations.of(context).translate('Company Name'),
                          style: TextStyle(
                              fontSize: mediumfont,
                              fontWeight: FontWeight.w400),
                        ),
                        Text(
                          AppLocalizations.of(context).translate('Employer name'),
                          style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: smallfont,
                              fontWeight: FontWeight.w400),
                        ),
                        FlatButton.icon(
                            label: Text(AppLocalizations.of(context).translate('Place')),
                            icon: Icon(Icons.location_on),
                            onPressed: () {}),
                        hspacing,
                        Text(
                          AppLocalizations.of(context).translate('Need') + AppLocalizations.of(context).translate('plumber'),
                          style: TextStyle(fontSize: mediumfont * 0.8),
                        )
                      ],
                    ),
                  ),
                  Spacer()
                ],
              ),
              SizedBox(height: size.height * 0.06),
              Text(AppLocalizations.of(context).translate('About'), style: headingStyle),
              hspacing,
              Container(
                child: Text(
                    "FJGIERGJEROGJEROrjheiuhrfieufhreiheieheiheriegieuieueiuveivbeivbeivevuG\nljigehgieuhgiug\ntgeihutig\ntbitbti"),
              ),
              wspacing,
              Text(AppLocalizations.of(context).translate('Skills required'), style: headingStyle),
              hspacing,
              Wrap(
                spacing: 10,
                children: [
                  Chip(
                    label: Text(AppLocalizations.of(context).translate('Random')),
                  ),
                  Chip(
                    label: Text(AppLocalizations.of(context).translate('Skills')),
                  ),
                  Chip(
                    label: Text(AppLocalizations.of(context).translate('to')),
                  ),
                  Chip(
                    label: Text(AppLocalizations.of(context).translate('be')),
                  ),
                  Chip(
                    label: Text(AppLocalizations.of(context).translate('put in here')),
                  ),
                ],
              ),
              wspacing,
              Text(AppLocalizations.of(context).translate('Wages/Salary'), style: headingStyle),
              hspacing,
              Text(AppLocalizations.of(context).translate('Deets')),
              wspacing,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(AppLocalizations.of(context).translate('Photos'), style: headingStyle),
                  GestureDetector(onTap: () {}, child: Text(AppLocalizations.of(context).translate('See all')))
                ],
              ),
              hspacing,
              Text(AppLocalizations.of(context).translate('all photos come here in a Carousel')),
              wspacing,
            ],
          ),
        ),
        Align(
          alignment: Alignment(-1, -0.9),
          child: IconButton(
              icon: Icon(Icons.chevron_left),
              iconSize: mediumfont * 1.5,
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
      ],
    ));
  }
}
