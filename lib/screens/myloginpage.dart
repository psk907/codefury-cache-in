import 'package:codefury2020/configurations/app_localizations.dart';
import 'package:codefury2020/models/language.dart';
import 'package:codefury2020/screens/registration.dart';
import 'package:codefury2020/services/authservice.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';
import './background.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyLoginPage extends StatefulWidget {
  MyLoginPage({Key key}) : super(key: key);

  @override
  _MyLoginPageState createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final formKey = new GlobalKey<FormState>();

  String phoneNo, verificationId, smsCode;

  bool codeSent = false;

  bool loading = false;

  void showSnackbar(String text) {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(text),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> verifyPhone(phoneNo) async {
    final PhoneVerificationCompleted verified = (AuthCredential authResult) {
      AuthService().signIn(authResult, phoneNo);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Registration()));
    };

    final PhoneVerificationFailed verificationfailed =
        (FirebaseAuthException authException) {
      if (authException.code == 'missing-client-identifier')
        showtoast('Captcha verification failed');
      else
        showtoast(authException.code + authException.message);
      print('${authException.code}');
      setState(() {
        loading = false;
      });
    };

    final PhoneCodeSent smsSent = (String verId, [int forceResend]) {
      this.verificationId = verId;
      setState(() {
        this.codeSent = true;
        loading = false;
      });
    };

    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
      this.verificationId = verId;
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNo,
        timeout: const Duration(seconds: 5),
        verificationCompleted: verified,
        verificationFailed: verificationfailed,
        codeSent: smsSent,
        codeAutoRetrievalTimeout: autoTimeout);
  }

  void _changeLanguage(Language language) {
    Locale _temp;
    switch (language.languageCode) {
      case 'en':
        _temp = Locale(language.languageCode, 'US');
        break;
      case 'hi':
        _temp = Locale(language.languageCode, 'IN');
        break;
    }
    MyApp.setLocale(context, _temp);
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
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.teal[600],
    ));

    var size = MediaQuery.of(context).size;
    double headingfont = size.height * 0.075;
    double regularfont = size.height * 0.025;
    double mediumfont = size.height * 0.035;

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
                                AppLocalizations.of(context)
                                    .translate('Hey there,'),
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
                            Padding(
                              padding: const EdgeInsets.only(left: 20, top: 0),
                              child: Text(
                                AppLocalizations.of(context)
                                    .translate('Enter your credentials'),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: regularfont,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey[700]),
                              ),
                            ),
                            SizedBox(
                              height: size.height * 0.04,
                            ),
                            Padding(
                                padding:
                                    EdgeInsets.only(left: 25.0, right: 25.0),
                                child: TextFormField(
                                  style: TextStyle(
                                      color: Colors.grey[900],
                                      fontSize: mediumfont * 0.6),
                                  keyboardType: TextInputType.phone,
                                  decoration: InputDecoration(
                                      hintText: AppLocalizations.of(context)
                                          .translate('Enter your phone number'),
                                      hintStyle: TextStyle(
                                          color: Colors.grey[400],
                                          fontSize: mediumfont * 0.6),
                                      prefixText: '+91 ',
                                      prefixStyle: TextStyle(
                                          color: Colors.grey[800],
                                          fontSize: mediumfont * 0.6),
                                      prefixIcon: Icon(Icons.phone)),
                                  onChanged: (val) {
                                    setState(() {
                                      this.phoneNo = '+91' + val;
                                    });
                                  },
                                )),
                            codeSent
                                ? Padding(
                                    padding: EdgeInsets.only(
                                        left: 25.0, right: 25.0, top: 10),
                                    child: TextFormField(
                                      style: TextStyle(
                                          color: Colors.grey[900],
                                          fontSize: mediumfont * 0.6),
                                      keyboardType: TextInputType.phone,
                                      decoration: InputDecoration(
                                          hintText: AppLocalizations.of(context)
                                              .translate('Enter the OTP'),
                                          prefixIcon: Icon(Icons.vpn_key)),
                                      onChanged: (val) {
                                        setState(() {
                                          this.smsCode = val;
                                        });
                                      },
                                    ))
                                : Container(),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 40),
                              child: Container(
                                  height: size.height * 0.06,
                                  child: RaisedButton(
                                      child: Center(
                                          child: loading
                                              ? CupertinoActivityIndicator()
                                              : codeSent
                                                  ? Text(
                                                      AppLocalizations.of(
                                                              context)
                                                          .translate('Login'),
                                                      style: TextStyle(
                                                          fontSize: 20),
                                                    )
                                                  : Text(
                                                      AppLocalizations.of(
                                                              context)
                                                          .translate('Verify'),
                                                      style: TextStyle(
                                                          fontSize: 20),
                                                    )),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                      ),
                                      onPressed: () {
                                        if (!loading &&
                                            this.phoneNo != null &&
                                            this.phoneNo.contains(new RegExp(
                                                r'^(\+91[\-\s]?)?[0]?(91)?[789]\d{9}$'))) {
                                          setState(() {
                                            loading = true;
                                          });
                                          AuthService()
                                              .savePhoneNumber(this.phoneNo);
                                          if (codeSent) {
                                            if (smsCode != null)
                                              AuthService().signInWithOTP(
                                                  smsCode,
                                                  verificationId,
                                                  this.phoneNo);
                                            else
                                              showtoast(AppLocalizations.of(
                                                      context)
                                                  .translate('Enter the OTP'));
                                          } else
                                            verifyPhone(phoneNo);
                               
                                        } else
                                          showtoast(AppLocalizations.of(context)
                                              .translate(
                                                  'Enter the valid phone number'));
                                      })),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment(0.9, -0.9),
                    child: DropdownButton(
                      underline: SizedBox(),
                      icon: Icon(Icons.language),
                      iconSize: mediumfont,
                      items: Language.languageList()
                          .map<DropdownMenuItem>((lang) => DropdownMenuItem(
                                child: Text(lang.name),
                                value: lang,
                              ))
                          .toList(),
                      onChanged: (language) {
                        _changeLanguage(language);
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment(-0.1, 0.9),
                    child: Image.asset('images/logo.png'),
                  ),
                  Align(
                    alignment: Alignment(0.1, 0.9),
                    child: Text(
                      "Now-kri",
                      style: TextStyle(
                          fontSize: mediumfont, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
