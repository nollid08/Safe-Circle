import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:safe_circle/controllers/map_controller.dart';
import 'package:provider/provider.dart';
import 'package:safe_circle/views/screens/map_screen.dart';
import 'package:safe_circle/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PermissionCheckerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool('prominentDisclosureAccepted', true);
    });
    return FutureBuilder(
      future: context
          .read<MapController>()
          .locationHelper
          .locationPermissionCompleter
          .future,
      builder: (BuildContext context,
          AsyncSnapshot<LocationPermissionStatus> snapshot) {
        if (snapshot.data != null) {
          if (snapshot.data == LocationPermissionStatus.allGranted) {
            return MapScreen();
          } else {
            return snapshot.data ==
                    LocationPermissionStatus.onlyforegroundGranted
                ? Scaffold(
                    backgroundColor: Colors.yellow[500],
                    appBar: AppBar(
                      title: Text('Safe Circle'),
                      centerTitle: true,
                      backgroundColor: primaryColor,
                    ),
                    body: ElevatedButton(
                        onPressed: () {
                          context
                              .read<MapController>()
                              .locationHelper
                              .checkAndRequestPermissions();
                        },
                        child: Text('Request Perms.')),
                  )
                : Scaffold(
                    backgroundColor: Colors.green[200],
                    appBar: AppBar(
                      title: Text('Safe Circle'),
                      centerTitle: true,
                      backgroundColor: primaryColor,
                    ),
                  );
          }
        } else {
          return Center(
            child: SpinKitRing(
              color: Colors.white,
              size: 50.0,
            ),
          );
        }
      },
    );
  }
}
