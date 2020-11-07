import 'package:cloud_firestore/cloud_firestore.dart';

class Job{
  String title,description,uid;
  int duration;
  double salary;
  GeoPoint location;
  List<dynamic> reqdSkills;


  Job({
    this.title,this.description,this.duration,this.location,this.salary,this.uid,this.reqdSkills
  });

  factory Job.fromJson(Map<String,dynamic> json){
    return Job(
      title: json['title'],
      uid: json['uid'],
      description: json['description'],
      duration: int.parse(json['duration'].toString()) ,
      salary: double.parse(json['salary'].toString()),
      location: GeoPoint(json['location'].latitude, json['location'].longitude),
      reqdSkills: json['skills-required'] as List<dynamic>,
    );
  }
}