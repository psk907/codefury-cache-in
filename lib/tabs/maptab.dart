import 'package:codefury2020/screens/places_search_map.dart';
import 'package:flutter/material.dart';

class MapTab extends StatefulWidget {
  @override
  _MapTabState createState() => _MapTabState();
}

class _MapTabState extends State<MapTab> {
  @override
  Widget build(BuildContext context) {
    return PlacesSearchMap();
  }
}
