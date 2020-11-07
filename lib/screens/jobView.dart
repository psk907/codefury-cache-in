import 'package:auto_size_text/auto_size_text.dart';
import 'package:codefury2020/configurations/app_localizations.dart';
import 'package:codefury2020/models/job.dart';
import 'package:flutter/material.dart';

class JobViewPage extends StatefulWidget {
  Job job;
  JobViewPage({this.job});
  @override
  _JobModelState createState() => _JobModelState();
}

class _JobModelState extends State<JobViewPage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double mediumfont = size.height * 0.034;
    double smallfont = size.height * 0.02;

    TextStyle headingStyle =
        TextStyle(fontSize: mediumfont, fontWeight: FontWeight.w600);
    var hspacing = SizedBox(height: size.height * 0.02);
    var wspacing = SizedBox(height: size.height * 0.05);

    return Scaffold(
        body: Stack(
      children: [
        SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(mediumfont, mediumfont * 3.2, 20, 0),
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
                          width: size.width * 0.28,
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
                        AutoSizeText(
                          widget.job.companyName,
                          maxLines: 1,
                          style: TextStyle(
                              fontSize: mediumfont * 0.9,
                              fontWeight: FontWeight.w400),
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
                            onPressed: () {}),
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
              SizedBox(height: size.height * 0.06),
              Text(AppLocalizations.of(context).translate('About'),
                  style: headingStyle),
              hspacing,
              Container(
                child: Text(widget.job.description),
              ),
              wspacing,
              Text(AppLocalizations.of(context).translate('Skills required'),
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
              Text(AppLocalizations.of(context).translate('Wages/Salary'),
                  style: headingStyle),
              hspacing,
              Text("Rs.${widget.job.salary}"),
              wspacing,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(AppLocalizations.of(context).translate('Photos'),
                      style: headingStyle),
                  GestureDetector(
                      onTap: () {},
                      child: Text(
                          AppLocalizations.of(context).translate('See all')))
                ],
              ),
              hspacing,
              Text(AppLocalizations.of(context)
                  .translate('all photos come here in a Carousel')),
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
