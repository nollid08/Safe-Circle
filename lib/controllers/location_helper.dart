import 'dart:async';
import 'package:background_location/background_location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationHelper {
  StreamController<LatLng> _locationController =
      StreamController<LatLng>.broadcast();
  Stream<LatLng> get locationStream =>
      _locationController.stream.asBroadcastStream();
  bool locationPermissionGranted = false;
  Future<void> startListener() async {
    BackgroundLocation.getPermissions(
      onGranted: () async {
        locationPermissionGranted = true;
        await BackgroundLocation.setAndroidNotification(
          title: "Safe Circle",
          message: "Safe Circle is using your location in the background",
          icon: "@mipmap/ic_launcher",
        );
        await BackgroundLocation.startLocationService(distanceFilter: 0);
        BackgroundLocation.getLocationUpdates((locationData) {
          if (locationData.accuracy <= 50) {
            _locationController.add(
              LatLng(
                locationData.latitude,
                locationData.longitude,
              ),
            );
          }
        });
        return;
      },
      onDenied: () {
        throw 'Permissions not granted';
      },
    );
  }
}
