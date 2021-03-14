import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_circle/controllers/map_controller.dart';
import 'package:safe_circle/constants.dart';
import 'package:safe_circle/views/widgets/map.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool('welcomed', true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MapController>(
      create: (_) => MapController(),
      builder: (BuildContext context, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Safe Circle'),
            centerTitle: true,
            backgroundColor: primaryColor,
          ),
          body: Map(),
          floatingActionButton: FloatingActionButton.extended(
            icon: Icon(Icons.home_rounded),
            label: Text('Set Home Location'),
            backgroundColor: primaryColor,
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
      },
    );
  }
}
