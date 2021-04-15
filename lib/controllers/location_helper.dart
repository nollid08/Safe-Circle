import 'dart:async';
import 'package:background_location/background_location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationHelper {
  StreamController<LatLng> _locationController =
      StreamController<LatLng>.broadcast();
  Stream<LatLng> get locationStream =>
      _locationController.stream.asBroadcastStream();
  bool locationPermissionGranted = false;

  Future<void> startListener() async {
    var locationPermissionGranted = await Permission.locationAlways.isGranted;
    if (locationPermissionGranted) {
      print('permissions Granted');
      startLocationService();
    } else {
      requestLocation(
        onGranted: () async {
          print('permissions Granted');
          startLocationService();
        },
        onDenied: () {
          print('Not Granted');
          throw ('No Permissions');
        },
      );
    }
  }

  void startLocationService() async {
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
  }

  Future<void> requestLocation({
    Function onGranted,
    Function onDenied,
  }) async {
    PermissionStatus foregroundLocationPermissionStatus =
        await Permission.location.request();
    if (foregroundLocationPermissionStatus.isGranted) {
      PermissionStatus backgroundLocationPermissionStatus =
          await Permission.locationAlways.request();
      if (backgroundLocationPermissionStatus.isGranted) {
        onGranted();
      } else {
        onDenied();
      }
    } else {
      onDenied();
    }
  }
}
