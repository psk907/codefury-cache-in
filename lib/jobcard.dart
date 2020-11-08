import 'package:flutter/material.dart';
import 'configurations/app_localizations.dart';
import 'models/job.dart';
import 'package:geocoder/geocoder.dart';
import 'package:url_launcher/url_launcher.dart';

class JobCard extends StatefulWidget {
  Job job;
  JobCard({this.job});
  @override
  _JobCardState createState() => _JobCardState();
}

class _JobCardState extends State<JobCard> {
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
    double mediumfont = size.height * 0.035;
    double smallfont = size.height * 0.02;

    var design = CircleAvatar(
      radius: mediumfont,
      backgroundImage: AssetImage('images/demoprof.png'),
    );

    return Hero(
      tag: widget.job.uid,
          child: Container(
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
                      AppLocalizations.of(context)
                              .translate('Salary/Wages: Rs.') +
                          "${widget.job.salary} \n" +
                          AppLocalizations.of(context)
                              .translate('Contract term:') +
                          widget.job.duration +
                          AppLocalizations.of(context).translate('months'),
                      style: TextStyle(fontSize: smallfont * 0.85),
                    ),
                    FlatButton.icon(
                      label: Text(
                        'Show',
                        style: TextStyle(fontSize: smallfont),
                      ),
                      //TODO:
                      icon: Icon(
                        Icons.location_on,
                        size: mediumfont * 0.8,
                      ),
                      onPressed: () => _launchURL(
                          'https://www.google.com/maps/search/?api=1&query=${widget.job.location.latitude},${widget.job.location.longitude}'),
                    )
                  ],
                ),
                Spacer()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
