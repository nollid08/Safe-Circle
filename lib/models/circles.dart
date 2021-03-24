import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Circles {
  final Color _greenCircleFill = Color.fromARGB(50, 66, 245, 81);
  final Color _greenCircleBorder = Color.fromARGB(100, 23, 87, 28);
  final Color _redCircleFill = Color.fromARGB(50, 212, 19, 19);
  final Color _redCircleBorder = Color.fromARGB(100, 150, 38, 38);
  Set<Circle> _circles = {};

  Set<Circle> get circles => _circles;

  void addCircle(LatLng location, bool isInside, int radius) {
    double radiusInMeters = radius.toDouble() * 1000;
    _circles.removeWhere((c) => c.circleId.value == '<five_km_from_home>');
    _circles.add(
      Circle(
        circleId: CircleId('<five_km_from_home>'),
        center: LatLng(location.latitude, location.longitude),
        radius: radiusInMeters,
        fillColor: isInside ? _greenCircleFill : _redCircleFill,
        strokeColor: isInside ? _greenCircleBorder : _redCircleBorder,
        strokeWidth: 1,
      ),
    );
  }
}
