import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Circles {
  final Color _greenCircleFill = Color.fromARGB(50, 66, 245, 81);
  final Color _greenCircleBorder = Color.fromARGB(100, 23, 87, 28);
  final Color _redCircleFill = Color.fromARGB(50, 212, 19, 19);
  final Color _redCircleBorder = Color.fromARGB(100, 150, 38, 38);
  int _safeCircleRadius = 5;
  Set<Circle> _circles = {};

  Set<Circle> get circles => _circles;
  int get safeCircleRadius => _safeCircleRadius;

  void addCircle(LatLng location, double homeDistance, int radius) {
    bool isInsideLimit = homeDistance < safeCircleRadius ? true : false;
    double radiusInMeters = radius.toDouble() * 1000;
    _circles.removeWhere((c) => c.circleId.value == '<safe_circle>');
    _circles.add(
      Circle(
        circleId: CircleId('<safe_circle>'),
        center: LatLng(location.latitude, location.longitude),
        radius: radiusInMeters,
        fillColor: isInsideLimit ? _greenCircleFill : _redCircleFill,
        strokeColor: isInsideLimit ? _greenCircleBorder : _redCircleBorder,
        strokeWidth: 1,
      ),
    );
  }

  void reloadSafeCircleRadius(LatLng homeLocation, double homeDistance) {
    SharedPreferences.getInstance().then((prefs) {
      _safeCircleRadius = prefs.getInt('safeCircleRadius') ?? 5;
      addCircle(homeLocation, homeDistance, safeCircleRadius);
    });
  }
}
