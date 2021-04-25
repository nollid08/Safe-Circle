import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:safe_circle/constants.dart';

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Safe Circle'),
        centerTitle: true,
        backgroundColor: primaryColor,
      ),
      body: Center(
        child: SpinKitRing(
          color: Colors.black,
          size: 50.0,
        ),
      ),
    );
  }
}
