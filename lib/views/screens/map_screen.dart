import 'package:safe_circle/views/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_circle/controllers/map_controller.dart';
import 'package:safe_circle/constants.dart';
import 'package:safe_circle/views/widgets/map.dart';
import 'package:safe_circle/views/widgets/retain_app.dart';

class MapScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RetainApp(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Safe Circle'),
          centerTitle: true,
          backgroundColor: primaryColor,
          actions: [
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsScreen()),
                );
              },
            )
          ],
        ),
        body: Map(),
        floatingActionButton: FloatingActionButton.extended(
          icon: Icon(Icons.home_rounded),
          label: Text('Set Home Location'),
          backgroundColor: primaryColor,
          onPressed: () {
            print('btn pressed');
            print(context.read<MapController>().currentLocation);
            if (context.read<MapController>().currentLocation != null) {
              context.read<MapController>().setHomeLocation(
                    context.read<MapController>().currentLocation,
                  );
            }
          },
        ),
      ),
    );
  }
}
