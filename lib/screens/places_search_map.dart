import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codefury2020/configurations/maps_format.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import '../services/location_service.dart';
import 'package:flutter/services.dart' show rootBundle;

class PlacesSearchMap extends StatefulWidget {
  PlacesSearchMap({Key key}) : super(key: key);

  @override
  _PlacesSearchMapState createState() => _PlacesSearchMapState();
}

class _PlacesSearchMapState extends State<PlacesSearchMap> {

  List<Marker> allMarkers=[];

  // 1
Completer<GoogleMapController> _controller = Completer();
// 2
bool showLoading = true;
 LocationService locationService = LocationService(); 
CameraPosition _myLocation;

@override
void initState() { 
  super.initState();
  _init();
  


}

  _init()async{
    await Future.wait([_getMyLocation(),
    _getMarkers()
    ]);
    setState(() {
      showLoading =false;
    });
  }

  Future<void> _getMyLocation()async{
    List<double> location = await locationService.getLocation();
      print(location);
      setState(() {
        _myLocation =  CameraPosition(target: LatLng(location[0], location[1]),zoom: 13);
      });  
    
  }


   Future<void> _getMarkers() async{

    QuerySnapshot qs = await FirebaseFirestore.instance.collection('employers').get();
    var docs = qs.docs;
    print(docs[0].data);
    
    for(int i=0;i<docs.length;i++){
      dynamic doc = docs[i];
      allMarkers.add(
        Marker(
          markerId: MarkerId (doc.data['uid']),
          position: LatLng(doc['latitude'],doc['longitude']),
          
        )
      );
    }
   
  }


  
  @override
  Widget build(BuildContext context) {
   return showLoading?
   CircularProgressIndicator(): 
   Scaffold(
      // 1
      body: GoogleMap(
        // 2
        initialCameraPosition: _myLocation,
        
        // 3
        mapType: MapType.normal,
        // 4
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
          controller.setMapStyle(map_configuration);
        },
        markers: Set.from(allMarkers),
      ),
    );
  }
}