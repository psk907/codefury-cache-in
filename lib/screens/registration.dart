import 'package:codefury2020/services/authservice.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './background.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Registration extends StatefulWidget {
  Registration({Key key}) : super(key: key);

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<Registration> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final formKey = new GlobalKey<FormState>();

  bool loading = false;

  List<Widget> questionnaire = new List();
  @override
  void initState() {
    super.initState();
    buildQuestionnaire();
  }

  void showSnackbar(String text) {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(text),
      ),
    );
  }

  void buildQuestionnaire() {
    questionnaire = [
      Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 0),
            child: Text(
              "What's your name?",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w600, color: Colors.grey[700]),
            ),
          ),
          SizedBox(
            height: 20, //TODO: Make responsive
          ),
          Padding(
              padding: EdgeInsets.only(left: 25.0, right: 25.0),
              child: TextFormField(
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: ' Enter your full name',
                ),
                onChanged: (val) {
                  setState(() {});
                },
              )),
        ],
      ),
    ];
  }

  showtoast(String text) => _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text(text),
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(30),
            ),
          ),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double headingfont = size.height * 0.075;
    double regularfont = size.height * 0.025;
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        body: Form(
          key: formKey,
          child: Container(
              height: size.height,
              child: Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  Positioned(
                    bottom: 1,
                    child: MediaQuery.of(context).viewInsets.bottom > 20
                        ? Container()
                        : Image.asset(
                            'assets/logo.png',
                            height: size.height * 0.1,
                          ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: SingleChildScrollView(
                      physics: ScrollPhysics(),
                      child: CustomPaint(
                        painter: MyPainter(size: size),
                        size: size,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: size.height * 0.0825,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 25),
                              child: Text(
                                "Hey\nthere,",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: headingfont,
                                  fontWeight: FontWeight.w800,
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ),
                            SizedBox(
                              height: size.height * 0.145,
                            ),
                            // Container(height: size.height*0.4,child: ListView(children:questionnaire,scrollDirection: Axis.horizontal,)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
