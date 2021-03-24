import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:five_km_from_home/models/circles.dart';
import 'package:five_km_from_home/models/markers.dart';

class Home {
  Circles circles = Circles();
  Markers markers = Markers();
  LatLng _homeLocation;
  LatLng get homeLocation {
    return _homeLocation;
  }

  Home() {
    markers.initImage();
  }
  void setHomeLocation(
      LatLng newLocation, bool isInsideLimit, int safeCircleRadius) {
    _homeLocation = newLocation;
    print("isInsideLimit: $isInsideLimit");
    print("HomeLocation: $homeLocation");
    print("newLocation: $newLocation");
    circles.addCircle(_homeLocation, isInsideLimit, safeCircleRadius);
    markers.addmarker(_homeLocation);
  }
}
