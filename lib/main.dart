import 'package:flutter/material.dart';
import 'package:five_km_from_home/constants.dart';
import 'package:five_km_from_home/views/screens/disclosure_screen.dart';
import 'package:five_km_from_home/views/screens/map_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'controllers/map_controller.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MapController>(
      create: (_) => MapController(),
      builder: (BuildContext context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.light().copyWith(primaryColor: primaryColor),
          home: FutureBuilder<SharedPreferences>(
            future: SharedPreferences.getInstance(),
            builder: (BuildContext context,
                AsyncSnapshot<SharedPreferences> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return DisclosureScreen();
                default:
                  if (!snapshot.hasError) {
                    if (snapshot.data.getBool('welcomed') == null) {
                      snapshot.data.setInt('safeCircleRadius', 5);
                    }

                    return snapshot.data.getBool('welcomed') != null
                        ? new MapScreen()
                        : new DisclosureScreen();
                  } else {
                    throw (snapshot.error);
                  }
              }
            },
          ),
        );
      },
    );
  }
}
