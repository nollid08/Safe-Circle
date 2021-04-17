import 'package:flutter/material.dart';
import 'package:safe_circle/controllers/map_controller.dart';
import 'package:provider/provider.dart';
import 'package:safe_circle/views/screens/map_screen.dart';

class PermissionCheckerScreen extends StatefulWidget {
  @override
  _PermissionCheckerScreenState createState() =>
      _PermissionCheckerScreenState();
}

class _PermissionCheckerScreenState extends State<PermissionCheckerScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: context
            .read<MapController>()
            .locationHelper
            .locationPermissionCompleter
            .future,
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.data != null) {
            if (snapshot.data) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MapScreen(),
                ),
              );
              return Container();
            } else {
              return Scaffold(
                backgroundColor: Colors.red,
              );
            }
          } else {
            return Container(
              color: Colors.orange,
            );
          }
        });
  }
}
