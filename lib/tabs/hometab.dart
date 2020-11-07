import 'package:flutter/material.dart';
import '../jobmodel.dart';

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(child: Text("main")),
        RaisedButton(onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => JobModel()),
          );
        })
      ],
    );
  }
}
