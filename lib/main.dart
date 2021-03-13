import 'package:flutter/material.dart';
import 'package:safe_circle/constants.dart';
import 'package:safe_circle/views/screens/map_screen.dart';
import 'controllers/map_controller.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MapController()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(primaryColor: primaryColor),
      home: MapScreen(),
    );
  }
}
