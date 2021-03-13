import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:safe_circle/models/circles.dart';
import 'package:safe_circle/models/markers.dart';

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
  void setHomeLocation(LatLng newLocation, bool isInside5km) {
    _homeLocation = newLocation;
    print("isInside5km: $isInside5km");
    print("HomeLocation: $homeLocation");
    print("newLocation: $newLocation");
    circles.addCircle(_homeLocation, isInside5km);
    markers.addmarker(_homeLocation);
  }
}
