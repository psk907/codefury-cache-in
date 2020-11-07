import 'dart:convert';
import 'package:codefury2020/main.dart';
import 'package:codefury2020/services/authservice.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
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
      AuthService().signIn(authResult);
    };

    final PhoneVerificationFailed verificationfailed =
        (FirebaseAuthException authException) {
      print('${authException.message}');
    };

    final PhoneCodeSent smsSent = (String verId, [int forceResend]) {
      this.verificationId = verId;
      setState(() {
        this.codeSent = true;
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


  _saveDetails(String _authToken, String user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth-token', _authToken);
    await prefs.setString('user', user);
  }

  /* _attemptLogin(String _email, _password) async {
    String url = 'https://ecommerce-calculator.herokuapp.com/api/MPC/login';
    Map<String, String> headers = {"Content-type": "application/json"};
    var postobj = jsonEncode({
      "email": _email,
      "password": _password,
    });
    print("POST: " + (postobj));
    String message = '';
    http.Response response;
    var respobj;
    try {
      response = await post(url, headers: headers, body: postobj);
      respobj = json.decode(response.body);
      message = respobj["message"] ?? "Null";
    } catch (e) {
      print("Caught Exception");
    }

    if (message == "loggedIn") {
      var user = json.encode(respobj["user"]);
      String _authToken = response.headers['x-auth'];

      await _saveDetails(_authToken, user);
      print("Logged in Successfully: $user");
      Navigator.pushReplacement(
          context, new MaterialPageRoute(builder: (context) => MyHomePage()));
    } else if (message == "Invalid_Password") {
      showtoast("Incorrect Password");
      print("Invalid password");
    } else if (message == "Invalid_EmailId") {
      isLoading = false;

      showtoast("There is no account with us for this email address");
    } else {
      showtoast("Please try again later !");
    }
    setState(() {
      isLoading = false;
    });
  }
 */
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
                            'assets/shopocus.png',
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
                            Padding(
                              padding: const EdgeInsets.only(left: 20, top: 0),
                              child: Text(
                                "Enter your Credentials",
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
                  padding: EdgeInsets.only(left: 25.0, right: 25.0),
                  child: TextFormField(
                    keyboardType: TextInputType.phone,
                    
                    decoration: InputDecoration(hintText: ' Enter your phone number',prefixText: '+91',prefixIcon: Icon(Icons.phone)),
                    onChanged: (val) {
                      setState(() {
                        this.phoneNo = '+91'+val;
                      });
                    },
                  )),
                  codeSent ? Padding(
                  padding: EdgeInsets.only(left: 25.0, right: 25.0),
                  child: TextFormField(
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(hintText: 'Enter OTP',prefixIcon: Icon(Icons.vpn_key)),
                    onChanged: (val) {
                      setState(() {
                        this.smsCode = val;
                      });
                    },
                  )) : Container(),
              Padding(
                  padding: EdgeInsets.only(left: 25.0, right: 25.0,top: 10),
                  child: RaisedButton(
                      child: Center(child: codeSent ? Text('Login',style: TextStyle(fontSize: 20),):Text('Verify',style: TextStyle(fontSize: 20),)),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0),),
                      
                      onPressed: () {
                        AuthService().savePhoneNumber(this.phoneNo);
                        codeSent ? AuthService().signInWithOTP(smsCode, verificationId):verifyPhone(phoneNo);
                      }))
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
