import 'package:codefury2020/models/language.dart';
import 'package:codefury2020/services/authservice.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../historycard.dart';
import '../main.dart';
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

  bool isLoading = false;
  bool showLoading = true;
  TextEditingController _namecontroller,
      _skillscontroller,
      _jobpostscontroller,
      _biocontroller,
     _slotpreferencescontroller;
  final _formKey = GlobalKey<FormState>();

  DateTime pickeddate;
  DateTime dayandtime;

  void callDatePicker() async {
    var order = await getDate();
    if (order != null)
      setState(() {
        pickeddate = order;
      });
  }

  Future<DateTime> getDate() {
    return showDatePicker(
      context: context,
      initialDate: DateTime(1995),
      firstDate: DateTime(1947),
      lastDate: DateTime(
          DateTime.now().subtract(const Duration(days: 365 * 18)).year),
      initialEntryMode: DatePickerEntryMode.calendar,
    );
  }

  String _formatDate(DateTime date) {
    final format = DateFormat.Hm('en_US').add_MMMMEEEEd();
    return format.format(date);
  }

  @override
  void initState() {
    super.initState();
    this.pickeddate = DateTime.now();
    this._namecontroller = new TextEditingController();
    this._skillscontroller = new TextEditingController();
    this._biocontroller = new TextEditingController();
    this._jobpostscontroller = new TextEditingController();
    this._slotpreferencescontroller = new TextEditingController();
  }

  void addDetailsToSP(String name, List<String> jobPosts, String description,
      DateTime dob, String submissionLink, String bio) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await Future.wait([
      prefs.setString('name', name),
      prefs.setString('description', description),
      prefs.setString('dob', dob.toString()),
      prefs.setString('bio', name),
      prefs.setString('jobPosts', jobPosts.toString())
    ]);
  }

  onPressRegister() {
    if (!_formKey.currentState.validate()) {
      showtoast("Fill in the required fields !",Colors.red);
    } else {
      setState(() {
        this.isLoading = true;

        this.dayandtime = new DateTime(
          this.pickeddate.year,
          this.pickeddate.month,
          this.pickeddate.day,
        );
      });
      addDetailsToSP(
        _namecontroller?.text ?? "none",
        _jobpostscontroller?.text.split('\n').toList() ?? "none",
        _skillscontroller?.text ?? "none",
        dayandtime ?? DateTime.now(),
       _slotpreferencescontroller?.text ?? "none",
        _biocontroller?.text ?? "none",
      );
      Navigator.pop(context);
      showtoast("SAVED ! Tap on APPLY to proceed !",Colors.red);
    }
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

  Widget _entryField(String title,
      {TextEditingController controllervar, bool isRequired = true}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
              validator: (value) {
                if (isRequired && value.isEmpty) {
                  return 'Please fill in this field';
                }
                return null;
              },
              // obscureText: isPassword,
              controller: controllervar,
              decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  // fillColor: Color(0xfff3f3f4),
                  filled: false))
        ],
      ),
    );
  }

  Widget _deadlineSelector() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'Date of Birth ${(dayandtime == null) ? '' : ' - ${_formatDate(dayandtime)} '}',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
        ],
      ),
    );
  }

  Widget _descriptionField(String title,
      {TextEditingController controllervar,int maxlines=8}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please fill in this field';
                }
                return null;
              },
              keyboardType: TextInputType.multiline,
              maxLines: maxlines,
              controller: controllervar,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  // fillColor: Color(0xfff3f3f4),
                  filled: true))
        ],
      ),
    );
  }

  Widget _formfieldswidgets() {
    return Form(
      key: _formKey,
      child: ListView(
        children: <Widget>[
          _entryField("Name", controllervar: _namecontroller),
          _deadlineSelector(),
          ListTile(
            title: Text(
                "${DateFormat.EEEE("en_US").add_yMMMMd().format(pickeddate)}"),
            trailing: Icon(Icons.calendar_today),
            onTap: callDatePicker,
          ),
          _entryField("Looking to be a?",
              controllervar: _jobpostscontroller, isRequired: true),
          _descriptionField("Bio", controllervar: _biocontroller,),
          _descriptionField("Skills", controllervar: _skillscontroller,maxlines: 5),
         
          _entryField("Working Hour PReferences",
              controllervar:_slotpreferencescontroller, isRequired: false),
        ],
        physics: BouncingScrollPhysics(),
      ),
    );
  }

  void showSnackbar(String text) {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(text),
      ),
    );
  }

  showtoast(String text,Color color) => _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text(text),
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(30),
            ),
          ),
          backgroundColor:color,
          behavior: SnackBarBehavior.floating,
        ),
      );

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double mediumfont = size.height * 0.035;
    double smallfont = size.height * 0.02;

    TextStyle headingStyle = TextStyle(
        color: Colors.black,
        fontSize: mediumfont * 1.4,
        fontWeight: FontWeight.w600);
    var wspacing = SizedBox(height: size.height * 0.02);
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        body: Stack(children: [
          Container(
            height: size.height * 0.21,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment
                    .bottomCenter, // 10% of the width, so there are ten blinds.
                colors: [
                  Color(0xffffc45b),
                  Color(0xffffcd74),
                  Color(0xffffd281),
                  Color(0xffffd78f),
                  Color(0xffffdc9d),
                  Color(0xffffe6b9),
                  Colors.white
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text(
                            // TODO AppLocalizations.of(context).translate('application history'),
                            "Tell us about yourself",
                            style: headingStyle,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 9,
                    child: Container(
                      child: _formfieldswidgets(),
                    ),
                  ),
                ]),
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
        ]),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            onPressRegister();
            
          },
          icon: Icon(Icons.navigate_next),
          label: Text("Submit"),
        ),
      ),
    );
  }
}
