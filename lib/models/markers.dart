import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Markers {
  Set<Marker> _markers = {};
  BitmapDescriptor _icon;

  Set<Marker> get markers => _markers;

  Future initImage() async {
    _icon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), 'assets/images/home.png');
  }

  void addmarker(LatLng location) {
    _markers.removeWhere((m) => m.markerId.value == '<HOME_MARKER>');
    _markers.add(
      Marker(
        markerId: MarkerId('<HOME_MARKER>'),
        position: LatLng(
            location.latitude - 0.0003, location.longitude), // updated position
        icon: _icon,
      ),
    );
  }
}
