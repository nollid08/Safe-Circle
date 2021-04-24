import 'dart:io';
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:safe_circle/constants.dart';
import 'package:safe_circle/views/screens/permission_checker_screen.dart';

class DisclosureScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Safe Circle'),
        centerTitle: true,
        backgroundColor: primaryColor,
      ),
      body: PermissionDisclosure(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => PermissionCheckerScreen()),
          );
        },
        icon: Icon(Icons.check),
        label: Text('Accept And Continue'),
        backgroundColor: primaryColor,
      ),
    );
  }
}

class PermissionDisclosure extends StatelessWidget {
  Future<double> getAndroidVersionNumber() async {
    if (Platform.isAndroid) {
      var androidInfo = await DeviceInfoPlugin().androidInfo;
      String releaseNumber = androidInfo.version.release;
      print(releaseNumber);
      if (releaseNumber.contains('.')) {
        releaseNumber = releaseNumber.substring(0, releaseNumber.indexOf('.'));
      }

      double versionNumber = double.parse(releaseNumber);
      return versionNumber;
    } else {
      return 10;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<double>(
      future: getAndroidVersionNumber(),
      builder: (context, AsyncSnapshot<double> androidVersionSnapshot) {
        if (androidVersionSnapshot.hasData) {
          if (androidVersionSnapshot.data >= 11) {
            return Android11UpPermissionDisclosure();
          } else {
            return Android10DownPermissionDisclosure();
          }
        } else
          return Android10DownPermissionDisclosure();
      },
    );
  }
}

class Android11UpPermissionDisclosure extends StatelessWidget {
  final String permissionSteps = '1. Press Accept And Continue\n'
      '2. In the dialog that pops up, select "while using the app".\n'
      '3. Another dialong will then appear. Press “Accept In Settings”\n'
      '4. A settings screen should now appear. Select “Allow All The Time”. You can then press the back arrow to return to the app.\n';

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            "Safe Circle collects location data to alert you when you leave your local excercise limit even when the app is closed or not in use. To grant these permissions, follow the steps below",
            style: TextStyle(
              fontSize: 20,
              fontFamily: 'RobotoSlab',
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Text(
            permissionSteps,
            style: TextStyle(
              fontSize: 18,
              fontFamily: 'RobotoSlab',
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Container(
          height: 160,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Flexible(
                flex: 1,
                child: Container(),
              ),
              Flexible(
                flex: 12,
                child: Image.asset(
                  'assets/images/permission_tutorial/step_1.png',
                  fit: BoxFit.fitHeight,
                ),
              ),
              Flexible(
                flex: 1,
                child: Container(),
              ),
              Flexible(
                flex: 12,
                child: Image.asset(
                  'assets/images/permission_tutorial/step_2.png',
                  fit: BoxFit.fitHeight,
                ),
              ),
              Flexible(
                flex: 1,
                child: Container(),
              ),
              Flexible(
                flex: 12,
                child: Image.asset(
                  'assets/images/permission_tutorial/step_3.png',
                  fit: BoxFit.fitHeight,
                ),
              ),
              Flexible(
                flex: 1,
                child: Container(),
              ),
              Flexible(
                flex: 12,
                child: Image.asset(
                  'assets/images/permission_tutorial/step_4.png',
                  fit: BoxFit.fitHeight,
                ),
              ),
              Flexible(
                flex: 1,
                child: Container(),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(20),
        ),
      ],
    );
  }
}

class Android10DownPermissionDisclosure extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          "Safe Circle collects location data to alert you when you leave your local excercise limit even when the app is closed or not in use.",
          style: TextStyle(
            fontSize: 21,
            fontFamily: 'RobotoSlab',
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
