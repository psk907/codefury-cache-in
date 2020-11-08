import 'package:codefury2020/services/authservice.dart';
import 'package:codefury2020/tabs/hometab.dart';
import 'package:codefury2020/tabs/maptab.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'configurations/app_localizations.dart';
import 'tabs/applicationtab.dart';
import 'models/language.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  static void setLocale(BuildContext context, Locale locale) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
    state.setLocale(locale);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale;
  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        // Initialize FlutterFire:
        future: _initialization,
        builder: (context, snapshot) {
          // Once complete, show your application
          if (snapshot.connectionState == ConnectionState.done) {
            return MaterialApp(
              title: 'Nowkri | Jobs for all',
              theme: ThemeData(
                primarySwatch: Colors.lightGreen,
                fontFamily: 'Poppins',
                visualDensity: VisualDensity.adaptivePlatformDensity,
              ),
              locale: _locale,
              debugShowCheckedModeBanner: false,

              supportedLocales: [
                Locale('en', 'US'),
                Locale('hi', 'IN'),
              ],

              localizationsDelegates: [
                AppLocalizations.delegate,

                // Built-in localization of basic text for Material widgets
                GlobalMaterialLocalizations.delegate,
                // Built-in localization for text direction LTR/RTL
                GlobalWidgetsLocalizations.delegate,
              ],
              // Returns a locale which will be used by the app
              localeResolutionCallback: (locale, supportedLocales) {
                // Check if the current device locale is supported
                for (var supportedLocale in supportedLocales) {
                  if (supportedLocale.languageCode == locale.languageCode &&
                      supportedLocale.countryCode == locale.countryCode) {
                    return supportedLocale;
                  }
                }
                // If the locale of the device is not supported, use the first one
                // from the list (English, in this case).
                return supportedLocales.first;
              },

              home: AuthService().handleAuth(),
            );
          }
          // Otherwise, show something whilst waiting for initialization to complete
          return MaterialApp(
              title: 'Loading',
              home: Scaffold(
                body: Center(
                  child: CupertinoActivityIndicator(),
                ),
              ));
        });
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title = "CodeFury"}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 1;
  List<Widget> _children = <Widget>[
    MapTab(),
    HomeTab(),
    // MyLoginPage(),
    ApplicationTab(),
  ];

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

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    double mediumfont = size.height * 0.035;
    return Scaffold(
      backgroundColor: Colors.grey[100],
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: BottomAppBar(
          child: Container(
        color: Colors.grey[50],
        padding: EdgeInsets.fromLTRB(mediumfont, 0, mediumfont, 0),
        height: size.height * 0.065,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(Icons.location_on),
              iconSize: (_selectedIndex == 0) ? mediumfont * 1.1 : mediumfont,
              color:
                  (_selectedIndex == 0) ? Colors.teal[300] : Colors.grey[400],
              tooltip: 'Maps',
              onPressed: () => _onItemTapped(0),
            ),
            IconButton(
                icon: Icon(Icons.home),
                iconSize: (_selectedIndex == 1) ? mediumfont * 1.1 : mediumfont,
                tooltip: 'Home',
                color:
                    (_selectedIndex == 1) ? Colors.teal[300] : Colors.grey[400],
                onPressed: () => _onItemTapped(1)),
            IconButton(
              icon: Icon(Icons.file_present),
              iconSize: (_selectedIndex == 2) ? mediumfont * 1.1 : mediumfont,
              tooltip: 'Applications',
              color:
                  (_selectedIndex == 2) ? Colors.teal[300] : Colors.grey[400],
              onPressed: () => _onItemTapped(2),
            ),
          ],
        ),
      )),
      body: _children[_selectedIndex],
    );
  }
}
