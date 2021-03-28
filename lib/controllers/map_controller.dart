import 'package:safe_circle/controllers/location_helper.dart';
import 'package:safe_circle/controllers/notification_helper.dart';
import 'package:safe_circle/models/home.dart';
import 'package:flutter/foundation.dart';
import 'dart:math';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapController extends ChangeNotifier {
  Home home = Home();
  LocationHelper locationHelper = LocationHelper();
  NotificationHelper notificationHelper = NotificationHelper();
  double distanceFromHome = 0;
  LatLng _currentLocation;
  bool _alarmTriggered = false;

  int get safeCircleRadius => home.circles.safeCircleRadius;
  LatLng get currentLocation => _currentLocation;
  Set get circleSet => home.circles.circles;
  Set get markerSet => home.markers.markers;

  MapController() {
    locationHelper.startListener().then((value) {
      locationHelper.locationStream.listen(
        (LatLng newLocation) {
          if (home.homeLocation == null && newLocation != null) {
            home
                .setInitialHomeLocation(
                    newLocation, distanceFromHome, safeCircleRadius)
                .then((completed) {
              home.circles
                  .reloadSafeCircleRadius(home.homeLocation, distanceFromHome);
            });
            notifyListeners();
          }
          _currentLocation = newLocation;
          if (home.homeLocation != null) {
            updateDistanceFromHome();
          }
        },
      );
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
    if (distanceFromHome > safeCircleRadius) {
      home.circles
          .addCircle(home.homeLocation, distanceFromHome, safeCircleRadius);
      if (!_alarmTriggered) {
        notificationHelper.showNotification();
        _alarmTriggered = true;
      }
    } else {
      notificationHelper.clearNotifications();
      _alarmTriggered = false;
      home.circles
          .addCircle(home.homeLocation, distanceFromHome, safeCircleRadius);
    }
    notifyListeners();
  }

  void setHomeLocation(LatLng newLocation) {
    home.setHomeLocation(newLocation, distanceFromHome, safeCircleRadius);
    notifyListeners();
  }
}
