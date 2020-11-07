import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';


class FirebaseUserProvider extends ChangeNotifier{
  User user;

  FirebaseUserProvider(){
    _getUser();
      
  }
  
  _getUser()async {
     await Firebase.initializeApp();
    this.user = FirebaseAuth.instance.currentUser;
    notifyListeners();
        print('user active');
  }
}