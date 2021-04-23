import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:safe_circle/controllers/map_controller.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Map extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CameraPosition initialCameraPosition = CameraPosition(
      target: LatLng(
        53.142400,
        -7.98100,
      ),
      zoom: 6.551926040649414,
    );
    return GoogleMap(
      compassEnabled: true,
      myLocationButtonEnabled: true,
      myLocationEnabled: true,
      zoomControlsEnabled: false,
      markers: context.watch<MapController>().markerSet,
      circles: context.watch<MapController>().circleSet,
      mapType: MapType.normal,
      initialCameraPosition: initialCameraPosition,
      gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
        new Factory<OneSequenceGestureRecognizer>(
          () => new EagerGestureRecognizer(),
        ),
      ].toSet(),
      onMapCreated: (GoogleMapController controller) async {
        bool cameraMoved = false;
        context.read<MapController>().locationHelper.locationStream.listen(
          (LatLng newLocation) {
            if (cameraMoved == false) {
              controller.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(
                    target: newLocation,
                    zoom: 12.551926040649414,
                  ),
                ),
              );
              cameraMoved = true;
            }
          },
        );
      },
    );
  }
}
