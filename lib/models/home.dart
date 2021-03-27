import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:five_km_from_home/models/circles.dart';
import 'package:five_km_from_home/models/markers.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  Future<void> setInitialHomeLocation(
      LatLng newLocation, bool isInsideLimit, int safeCircleRadius) async {
    final prefs = await SharedPreferences.getInstance();
    double latitude = prefs.getDouble('latitude');
    double longitude = prefs.getDouble('longitude');
    print('SetInitialHomeLocation: Latitude: $latitude');
    if (latitude == null || longitude == null) {
      prefs.setDouble('latitude', newLocation.latitude);
      prefs.setDouble('longitude', newLocation.longitude);
    }
    latitude = prefs.getDouble('latitude');
    longitude = prefs.getDouble('longitude');
    newLocation = LatLng(latitude, longitude);

    _homeLocation = newLocation;
    print(
        'SetInitialHomeLocation: HomeLocation.Latitude: ${_homeLocation.latitude}');
    circles.addCircle(_homeLocation, isInsideLimit, safeCircleRadius);
    markers.addmarker(_homeLocation);
    return;
  }

  void setHomeLocation(
      LatLng newLocation, bool isInsideLimit, int safeCircleRadius) {
    SharedPreferences.getInstance().then((prefs) {
      prefs.setDouble('latitude', newLocation.latitude);
      prefs.setDouble('longitude', newLocation.longitude);
      _homeLocation = newLocation;
      print("isInsideLimit: $isInsideLimit");
      print("HomeLocation: $homeLocation");
      print("newLocation: $newLocation");
      circles.addCircle(_homeLocation, isInsideLimit, safeCircleRadius);
      markers.addmarker(_homeLocation);
    });
  }
}
