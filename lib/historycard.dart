import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

//rejected 0
//accepted 1
//waiting rest

class HistoryCard extends StatefulWidget {
  final int case_no;
  HistoryCard(this.case_no);
  @override
  _HistoryCardState createState() => _HistoryCardState();
}

class _HistoryCardState extends State<HistoryCard> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double mediumfont = size.height * 0.035;
    double smallfont = size.height * 0.02;

    TextStyle headingStyle =
        TextStyle(fontSize: mediumfont * 1.25, fontWeight: FontWeight.w600);
    var hspacing = SizedBox(height: size.height * 0.02);
    var wspacing = SizedBox(height: size.height * 0.05);

    var design = CircleAvatar(
      radius: mediumfont,
      backgroundImage: AssetImage('images/demoprof.png'),
    );
    String messege = (widget.case_no == 0)
        ? 'Rejected'
        : (widget.case_no == 1)
            ? 'Accepted'
            : 'Processing';
    Color messegecol = (widget.case_no == 0)
        ? Colors.red[700]
        : (widget.case_no == 1)
            ? Colors.green
            : Colors.blueAccent;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ClipRect(
        child: Banner(
          location: BannerLocation.topEnd,
          message: messege,
          color: messegecol,
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
            width: size.width,
            height: size.height * 0.17,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                child: Center(
                  child: Column(
                    children: [
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
                                      "Company Name",
                                      style: TextStyle(
                                          fontSize: mediumfont * 0.7,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Text(
                                      "Employer name",
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
                      Wrap(
                        spacing: 10,
                        children: [
                          Chip(
                            backgroundColor: Colors.red[100],
                            avatar: CircleAvatar(
                              backgroundColor: Colors.red[400],
                              child: Icon(
                                Icons.format_align_justify,
                                size: smallfont,
                                color: Colors.white,
                              ),
                            ),
                            label: Text(
                              'Details',
                              style: TextStyle(fontSize: smallfont * 0.75),
                            ),
                          ),
                          Chip(
                            backgroundColor: Colors.green[100],
                            avatar: CircleAvatar(
                              backgroundColor: Colors.green[600],
                              child: Icon(
                                Icons.phone,
                                size: smallfont,
                                color: Colors.white,
                              ),
                            ),
                            label: Text(
                              'Contact',
                              style: TextStyle(fontSize: smallfont * 0.75),
                            ),
                          ),
                          Chip(
                            backgroundColor: Colors.blue[200],
                            avatar: CircleAvatar(
                              child: Icon(
                                Icons.location_on,
                                size: smallfont,
                              ),
                            ),
                            label: Text(
                              'Location',
                              style: TextStyle(fontSize: smallfont * 0.75),
                            ),
                          ),
                        ],
                      ),
                      Spacer()
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
