import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codefury2020/configurations/app_localizations.dart';
import 'package:codefury2020/models/job.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geocoder/model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class JobViewPage extends StatefulWidget {
  Job job;
  JobViewPage({this.job});
  @override
  _JobModelState createState() => _JobModelState();
}

class _JobModelState extends State<JobViewPage> {
  Address storeaddress = new Address();
  @override
  void initState() {
    super.initState();
    _getAddress([widget.job.location.latitude, widget.job.location.longitude]);
  }

  _getAddress(List<dynamic> coordinates) async {
    var addresses = await Geocoder.local.findAddressesFromCoordinates(
        Coordinates(coordinates[0], coordinates[1]));
    var firstresult = addresses.first;
    setState(() {
      storeaddress = firstresult;
    });
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double mediumfont = size.height * 0.033;
    double smallfont = size.height * 0.02;

    TextStyle headingStyle =
        TextStyle(fontSize: mediumfont, fontWeight: FontWeight.w600);
    var hspacing = SizedBox(height: size.height * 0.02);
    // var wspacing = SizedBox(height: size.height * 0.05);
    var wspacing = Divider(
      height: size.height * 0.05,
      thickness: 1,
    );

    void submitApplication() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      Map<String, dynamic> data = {
        "title": widget.job.title,
        "uid": widget.job.uid,
        "description": widget.job.description,
        "job-span": widget.job.duration,
        "salary": widget.job.salary,
        "location": widget.job.location,
        "skills-appreciated": widget.job.reqdSkills,
        "company-name": widget.job.companyName,
        "daily-hours": widget.job.dailyHours,
        "employer-name": widget.job.employerName,
        "applicant-name": prefs.getString('name'),
        "applicant-skills": prefs.getString('description'),
        "applicant-dob":
            Timestamp.fromDate(DateTime.parse(prefs.getString('dob'))),
        "applicant-bio": prefs.getString('bio'),
      };
      FirebaseFirestore.instance
          .collection('users')
          .doc(prefs.getString('Phone Number'))
          .collection('applications')
          .add(data);
    }

    return Scaffold(
        body: Stack(
      children: [
        Container(
          color: Colors.amber[100],
          height: size.height * 0.3,
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(30, mediumfont * 3.4, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                // color: Colors.amber[50],
                child: Row(
                  children: [
                    Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Image.asset(
                            'images/job-icon.png',
                            width: size.width * 0.25,
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
                          Container(
                            child: AutoSizeText(
                              // 'frfrnenenek rjfherfj bjrfbhejr fjrhf',
                              widget.job.companyName,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              minFontSize: 20,
                              // maxFontSize: mediumfont * 0.95,

                              style: TextStyle(
                                  // fontSize: mediumfont * 0.95,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          Text(
                            widget.job.employerName,
                            style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: smallfont,
                                fontWeight: FontWeight.w400),
                          ),
                          FlatButton.icon(
                            label: Text(AppLocalizations.of(context)
                                .translate('Place')),
                            icon: Icon(Icons.location_on),
                            onPressed: () => _launchURL(
                                'https://www.google.com/maps/search/?api=1&query=${widget.job.location.latitude},${widget.job.location.longitude}'),
                          ),
                          hspacing,
                          Text(
                            AppLocalizations.of(context).translate('Need') +
                                " : " +
                                widget.job.title,
                            style: TextStyle(fontSize: mediumfont * 0.7),
                          )
                        ],
                      ),
                    ),
                    Spacer()
                  ],
                ),
              ),
              Divider(
                  color: Colors.grey[800],
                  thickness: 1.5,
                  height: size.height * 0.06),
              Container(
                height: size.height * 0.65,
                child: SingleChildScrollView(
                  physics: ClampingScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(AppLocalizations.of(context).translate('About'),
                          style: headingStyle),
                      hspacing,
                      Container(
                        child: Text(
                          widget.job.description,
                          style: TextStyle(fontSize: smallfont * 0.9),
                        ),
                      ),
                      wspacing,
                      Text(
                          AppLocalizations.of(context)
                              .translate('Skills required'),
                          style: headingStyle),
                      hspacing,
                      Wrap(
                        spacing: 10,
                        children: widget.job.reqdSkills
                            .map((skill) => Chip(
                                    label: Text(
                                  skill.toString(),
                                )))
                            .toList(),
                      ),
                      wspacing,
                      Text(
                          AppLocalizations.of(context)
                              .translate('Wages/Salary'),
                          style: headingStyle),
                      hspacing,
                      Text(
                        " Rs.${widget.job.salary}",
                        style: TextStyle(
                          fontSize: smallfont,
                        ),
                      ),
                      wspacing,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(AppLocalizations.of(context).translate('Photos'),
                              style: headingStyle),
                          GestureDetector(
                              onTap: () {},
                              child: Text(AppLocalizations.of(context)
                                  .translate('See all')))
                        ],
                      ),
                      hspacing,
                      Text(AppLocalizations.of(context)
                          .translate('all photos come here in a Carousel')),
                      wspacing,
                      Text(
                          // AppLocalizations.of(context.translate(
                          'Contract Term',
                          style: headingStyle),
                      hspacing,
                      Text(
                        widget.job.duration +
                            " " +
                            AppLocalizations.of(context).translate('months'),
                        style: TextStyle(
                          fontSize: smallfont,
                        ),
                      ),
                      wspacing,
                      Text(
                          // AppLocalizations.of(context.translate(
                          'Daily Hours',
                          style: headingStyle),
                      hspacing,
                      Text(
                        widget.job.dailyHours.toString() + " hours",
                        style: TextStyle(
                          fontSize: smallfont,
                        ),
                      ),
                      wspacing,
                    ],
                  ),
                ),
              ),
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
        Align(
          alignment: Alignment(0.94, -0.89),
          child: Container(
            height: size.height * 0.045,
            width: size.width * 0.34,
            child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                color: Colors.green[300],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "APPLY",
                      style: TextStyle(
                          fontSize: mediumfont * 0.9,
                          fontWeight: FontWeight.w600),
                    ),
                    Icon(
                      Icons.send_and_archive,
                      size: mediumfont * 0.8,
                    ),
                  ],
                ),
                onPressed: () {
                  submitApplication();
                  Navigator.pop(context);
                }),
          ),
        ),
      ],
    ));
  }
}
