import 'package:codefury2020/main.dart';
import 'package:codefury2020/screens/myloginpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  //Handles Auth
  handleAuth() {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: ( context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Scaffold(
              body: Center(
                child: CupertinoActivityIndicator(),
              ),
            );
          if (snapshot.hasData) {
            if (snapshot.data != null) return MyHomePage();
          } else {
            return MyLoginPage();
          }
        });
  }

  //Sign out
  signOut() {
    FirebaseAuth.instance.signOut();
  }

  //Save to device
  Future<void> savePhoneNumber(String phno) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('Phone Number', phno);
  }

  //SignIn
 signIn(AuthCredential authCreds,phNo) async {
    await FirebaseAuth.instance.signInWithCredential(authCreds);
  }

signInWithOTP(smsCode, verId,phNo)  {
    AuthCredential authCreds =
        PhoneAuthProvider.credential(verificationId: verId, smsCode: smsCode);
   signIn(authCreds,phNo);
  }
}
