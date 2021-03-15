import 'package:flutter/material.dart';
import 'package:five_km_from_home/constants.dart';
import 'package:five_km_from_home/views/screens/map_screen.dart';

class DisclosureScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Safe Circle'),
          centerTitle: true,
          backgroundColor: primaryColor,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Safe Circle collects location data to alert you when you leave you're local excercise limit even when the app is closed or not in use.",
              style: TextStyle(
                fontSize: 20,
                fontFamily: 'RobotoSlab',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => MapScreen()),
            );
          },
          icon: Icon(Icons.check),
          label: Text('Accept And Continue'),
          backgroundColor: primaryColor,
        ),
      ),
    );
  }
}
