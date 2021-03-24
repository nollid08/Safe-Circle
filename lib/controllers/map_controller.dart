import 'package:five_km_from_home/controllers/location_helper.dart';
import 'package:five_km_from_home/controllers/notification_helper.dart';
import 'package:five_km_from_home/models/home.dart';
import 'package:flutter/foundation.dart';
import 'dart:math';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MapController extends ChangeNotifier {
  Home home = Home();
  double distanceFromHome = 0;
  LatLng _currentLocation;
  NotificationHelper notificationHelper = NotificationHelper();
  bool _alarmTriggered = false;
  LocationHelper locationHelper = LocationHelper();
  int _safeCircleRadius = 5;
  int get safeCircleRadius => _safeCircleRadius;

  LatLng get currentLocation => _currentLocation;
  Set get circleSet => home.circles.circles;
  Set get markerSet => home.markers.markers;

  MapController() {
    locationHelper.startListener().then((value) {
      locationHelper.locationStream.listen(
        (LatLng newLocation) {
          if (home.homeLocation == null && newLocation != null) {
            bool isInsideLimit =
                distanceFromHome <= safeCircleRadius * 1000 ? true : false;
            home.setHomeLocation(newLocation, isInsideLimit, safeCircleRadius);
            notifyListeners();
          }
          _currentLocation = newLocation;
          updateDistanceFromHome();
          notifyListeners();
        },
      );
      notifyListeners();
    });
    reloadSharedPreferences();
    notifyListeners();
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
    if (distanceFromHome > safeCircleRadius) {
      home.circles.addCircle(home.homeLocation, false, safeCircleRadius);
      if (!_alarmTriggered) {
        notificationHelper.showNotification();
        _alarmTriggered = true;
      }
    } else {
      notificationHelper.clearNotifications();
      _alarmTriggered = false;
      home.circles.addCircle(home.homeLocation, true, safeCircleRadius);
    }
    notifyListeners();
  }

  void setHomeLocation(LatLng newLocation, bool isInsideLimit) {
    home.setHomeLocation(newLocation, isInsideLimit, safeCircleRadius);
    notifyListeners();
  }

  void reloadSharedPreferences() {
    SharedPreferences.getInstance().then((prefs) {
      _safeCircleRadius = prefs.getInt('safeCircleRadius') ?? 5;
      bool isInsideLimit =
          distanceFromHome < safeCircleRadius * 1000 ? true : false;
      home.circles
          .addCircle(home.homeLocation, isInsideLimit, safeCircleRadius);
    });
  }
}
