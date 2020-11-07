import 'package:cloud_firestore/cloud_firestore.dart';

class application{
  String title,description,uid,duration,companyName,employerName,applicantName;
  int dailyHours;
  int salary;
  GeoPoint location;
  List<dynamic> reqdSkills;


  application({
    this.title,this.description,this.duration,this.location,this.salary,this.uid,this.reqdSkills,this.companyName,this.dailyHours,this.employerName,this.applicantName
  });

  factory application.fromJson(Map<String,dynamic> json){
    return application(
      title: json['title']??"job title",
      uid: json['uid'],
      description: json['description']??"",
      duration: json['job-span'].toString() ,
      salary: json['salary'],
      location: GeoPoint(json['location'].latitude, json['location'].longitude),
      reqdSkills: json['skills-appreciated'] as List<dynamic>,
      companyName :json['company-name']??" ",
      dailyHours: json['daily-hours']??0,
      employerName: json['employer-name']??" ",
      applicantName:json["applicant-name"],

    );
  }
}