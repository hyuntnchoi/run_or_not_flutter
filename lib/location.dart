import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:geolocator/geolocator.dart';

class Geolocation extends StatefulWidget {
  @override
  _GeolocationState createState() => _GeolocationState();
}

class _GeolocationState extends State<Geolocation> {
  late Geolocator _geolocator;
  late Position _position;

  @override
  void initState() {
    super.initState();

    _geolocator = Geolocator();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Geolocation Example'),
      ),
      body: Center(
        child: Text(
          'Latitude: ${_position != null ? _position.latitude.toString() : '0'},'
              'Longitude: ${_position != null ? _position.longitude.toString() : '0'}'
        )
      )
    );
  }
}