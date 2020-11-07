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
                          "Company Name",
                          style: TextStyle(
                              fontSize: mediumfont,
                              fontWeight: FontWeight.w400),
                        ),
                        Text(
                          "Employer name",
                          style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: smallfont,
                              fontWeight: FontWeight.w400),
                        ),
                        FlatButton.icon(
                            label: Text('Place'),
                            icon: Icon(Icons.location_on),
                            onPressed: () {}),
                        hspacing,
                        Text(
                          " Need " + "plumber",
                          style: TextStyle(fontSize: mediumfont * 0.8),
                        )
                      ],
                    ),
                  ),
                  Spacer()
                ],
              ),
              SizedBox(height: size.height * 0.06),
              Text("About", style: headingStyle),
              hspacing,
              Container(
                child: Text(
                    "FJGIERGJEROGJEROrjheiuhrfieufhreiheieheiheriegieuieueiuveivbeivbeivevuG\nljigehgieuhgiug\ntgeihutig\ntbitbti"),
              ),
              wspacing,
              Text("Skills Required", style: headingStyle),
              hspacing,
              Wrap(
                spacing: 10,
                children: [
                  Chip(
                    label: Text('Random'),
                  ),
                  Chip(
                    label: Text('Skills'),
                  ),
                  Chip(
                    label: Text('to '),
                  ),
                  Chip(
                    label: Text('be'),
                  ),
                  Chip(
                    label: Text('put in hereeee'),
                  ),
                ],
              ),
              wspacing,
              Text("Wages/Salary", style: headingStyle),
              hspacing,
              Text("Deets"),
              wspacing,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Photos", style: headingStyle),
                  GestureDetector(onTap: () {}, child: Text("See all"))
                ],
              ),
              hspacing,
              Text("all photos come here in a carosel"),
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
