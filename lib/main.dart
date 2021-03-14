import 'package:flutter/material.dart';
import 'package:safe_circle/constants.dart';
import 'package:safe_circle/views/screens/disclosure_screen.dart';
import 'package:safe_circle/views/screens/map_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(primaryColor: primaryColor),
      home: FutureBuilder<SharedPreferences>(
        future: SharedPreferences.getInstance(),
        builder:
            (BuildContext context, AsyncSnapshot<SharedPreferences> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return DisclosureScreen();
            default:
              if (!snapshot.hasError) {
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
  }
}
