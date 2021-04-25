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
    void requestPermissions() {
      context
          .read<MapController>()
          .locationHelper
          .checkAndRequestPermissions()
          .then(
        (permissionGranted) {
          print(' e $permissionGranted');
          switch (permissionGranted) {
            case LocationPermissionStatus.allGranted:
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => MapScreen(),
              //   ),
              // );
              break;
            default:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => PermissionCheckerScreen(),
                ),
              );
          }
        },
      );
    }

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
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => MapScreen(),
                ),
              );
            });
            return Container();
          } else {
            return Scaffold(
              backgroundColor: Colors.grey[200],
              appBar: AppBar(
                title: Text('Safe Circle'),
                centerTitle: true,
                backgroundColor: primaryColor,
              ),
              body: snapshot.data ==
                      LocationPermissionStatus.onlyforegroundGranted
                  ? ForegroundOnlyGrantedPrompt()
                  : NoPermissionsGrantedPrompt(),
              floatingActionButton: FloatingActionButton.extended(
                  backgroundColor: primaryColor,
                  onPressed: () => requestPermissions(),
                  icon: Icon(Icons.my_location),
                  label: Text(
                    'Request Permissions',
                  )),
            );
          }
        } else {
          return Scaffold(
            backgroundColor: Colors.grey[200],
            appBar: AppBar(
              title: Text('Safe Circle'),
              centerTitle: true,
              backgroundColor: primaryColor,
            ),
            body: Center(
              child: SpinKitRing(
                color: Colors.white,
                size: 50.0,
              ),
            ),
          );
        }
      },
    );
  }
}

class ForegroundOnlyGrantedPrompt extends StatelessWidget {
  final String permissionSteps = '1. Press Request Permissions\n'
      '2. Another dialong will then appear. Press “Accept In Settings”\n'
      '3. A settings screen should now appear. Select “Allow All The Time”. You can then press the back arrow to return to the app.\n';

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
            "Correct Permissions not granted. The app cannot work without these permissions. Follow The Steps below to grant these permissions.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 23,
              fontFamily: 'RobotoSlab',
              fontWeight: FontWeight.w600,
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
          height: 200,
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

class NoPermissionsGrantedPrompt extends StatelessWidget {
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
            "Correct Permissions not granted. The app cannot work without these permissions. Follow The Steps below to grant these permissions.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 23,
              fontFamily: 'RobotoSlab',
              fontWeight: FontWeight.w600,
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
