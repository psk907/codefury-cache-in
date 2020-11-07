import 'package:flutter/material.dart';
import 'models/job.dart';

class JobCard extends StatefulWidget {
  Job job;
  JobCard({this.job});
  @override
  _JobCardState createState() => _JobCardState();
}

class _JobCardState extends State<JobCard> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double mediumfont = size.height * 0.035;
    double smallfont = size.height * 0.02;

    var design = CircleAvatar(
      radius: mediumfont,
      backgroundImage: AssetImage('images/demoprof.png'),
    );

    return Container(
      height: size.height * 0.2,
      child: Card(
        elevation: 2,
        shadowColor: Colors.grey[400],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              Row(
                children: [
                  design,
                  Spacer(),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.job.companyName,
                              style: TextStyle(
                                  fontSize: mediumfont * 0.7,
                                  fontWeight: FontWeight.w400),
                            ),
                            Text(
                              widget.job.employerName,
                              style: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: smallfont * 0.8,
                                  fontWeight: FontWeight.w400),
                            )
                          ],
                        ))
                      ]),
                  Spacer()
                ],
              ),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Salary/Wages : Rs. " +
                        widget.job.salary.toString() +
                        "\nContract Term : " +
                        widget.job.duration +
                        " months",
                    style: TextStyle(fontSize: smallfont * 0.85),
                  ),
                  FlatButton.icon(
                      label: Text(
                        'Place',
                        style: TextStyle(fontSize: smallfont),
                      ),
                      //TODO:
                      icon: Icon(
                        Icons.location_on,
                        size: mediumfont * 0.8,
                      ),
                      onPressed: () {}),
                ],
              ),
              Spacer()
            ],
          ),
        ),
      ),
    );
  }
}
