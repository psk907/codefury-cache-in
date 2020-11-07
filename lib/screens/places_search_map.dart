import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codefury2020/configurations/maps_format.dart';
import 'package:codefury2020/models/job.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import '../services/location_service.dart';

class PlacesSearchMap extends StatefulWidget {
  PlacesSearchMap({Key key}) : super(key: key);

  @override
  _PlacesSearchMapState createState() => _PlacesSearchMapState();
}

class _PlacesSearchMapState extends State<PlacesSearchMap> {
  List<Marker> allMarkers = [];

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

  _init() async {
    await Future.wait([_getMyLocation(), _getMarkers()]);
    setState(() {
      showLoading = false;
    });
  }

  Future<void> _getMyLocation() async {
    List<double> location = await locationService.getLocation();
    print(location);
    setState(() {
      _myLocation =
          CameraPosition(target: LatLng(location[0], location[1]), zoom: 13);
    });
  }

  Future<void> _getMarkers() async {
    QuerySnapshot qs =
        await FirebaseFirestore.instance.collection('employers').get();
    List<Job> jobs =
        qs.docs.map((employer) => Job.fromJson(employer.data())).toList();

    jobs.forEach((job) {
      allMarkers.add(Marker(
        markerId: MarkerId(job.uid),
        position: LatLng(job.location.latitude, job.location.longitude),
        infoWindow: InfoWindow(
            title: job.title,
            snippet: job.salary.toString(),
            onTap: () => print("hey")),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return showLoading
        ? Center(child: CircularProgressIndicator())
        : Scaffold(
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
                controller.setMapStyle(mapConfiguration);
              },
              markers: Set.from(allMarkers),
            ),
          );
  }
}
