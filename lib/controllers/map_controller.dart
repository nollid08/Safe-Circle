import 'package:five_km_from_home/controllers/location_helper.dart';
import 'package:five_km_from_home/controllers/notification_helper.dart';
import 'package:five_km_from_home/models/home.dart';
import 'package:flutter/foundation.dart';
import 'dart:math';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapController extends ChangeNotifier {
  Home home = Home();
  double distanceFromHome = 0;
  LatLng _currentLocation;
  NotificationHelper notificationHelper = NotificationHelper();
  bool _alarmTriggered = false;
  LocationHelper locationHelper = LocationHelper();
  int _safeCircleRadius = 5;
  int get safeCircleRadius => _safeCircleRadius;
  set safeCircleRadius(int newSafeCircleRadius) {
    _safeCircleRadius = newSafeCircleRadius;
    notifyListeners();
  }

  LatLng get currentLocation => _currentLocation;
  Set get circleSet => home.circles.circles;
  Set get markerSet => home.markers.markers;

  MapController() {
    locationHelper.startListener().then((value) {
      locationHelper.locationStream.listen(
        (LatLng newLocation) {
          if (home.homeLocation == null && newLocation != null) {
            home.setHomeLocation(
              newLocation,
              distanceFromHome <= 5000 ? true : false,
            );
            notifyListeners();
          }
          _currentLocation = newLocation;
          updateDistanceFromHome();
          notifyListeners();
        },
      );
      notifyListeners();
    });
  }

  void updateDistanceFromHome() {
    double deg2Rad(deg) {
      return deg * pi / 180;
    }

    final double lat1 = deg2Rad(_currentLocation.latitude);
    final double lat2 = deg2Rad(home.homeLocation.latitude);
    final double lon1 = deg2Rad(_currentLocation.longitude);
    final double lon2 = deg2Rad(home.homeLocation.longitude);

    const radius = 6371;
    final double x = (lon2 - lon1) * cos((lat1 + lat2) / 2);
    final double y = (lat2 - lat1);
    final double distance = sqrt(x * x + y * y) * radius;
    distanceFromHome = distance;
    if (distanceFromHome > 5.000) {
      home.circles.addCircle(home.homeLocation, false);
      if (!_alarmTriggered) {
        print('Triggering Alarm');
        notificationHelper.showNotification();
        _alarmTriggered = true;
      } else {
        print('Alarm already triggered');
      }
    } else {
      print('Still inside 5km limit');
      notificationHelper.clearNotifications();
      _alarmTriggered = false;
      home.circles.addCircle(home.homeLocation, true);
    }
    notifyListeners();
  }

  void setHomeLocation(LatLng newLocation, bool isInside5km) {
    home.setHomeLocation(newLocation, isInside5km);
    notifyListeners();
  }
}
