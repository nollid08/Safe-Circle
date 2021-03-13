import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:five_km_from_home/controllers/map_controller.dart';
import 'package:five_km_from_home/constants.dart';
import 'package:five_km_from_home/views/widgets/map.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SafeCircle'),
        centerTitle: true,
        backgroundColor: primaryColor,
      ),
      body: Map(),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.home_rounded),
        label: Text('Set Home Location'),
        onPressed: () {
          if (context.read<MapController>().currentLocation != null) {
            print(
                'Distance from home: ${context.read<MapController>().distanceFromHome}');
            print(
                'Current location: ${context.read<MapController>().currentLocation}');
            bool isInside =
                context.read<MapController>().distanceFromHome < 5.000
                    ? true
                    : false;
            context.read<MapController>().setHomeLocation(
                  context.read<MapController>().currentLocation,
                  isInside,
                );
          }
        },
      ),
    );
  }
}
