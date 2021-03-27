import 'package:five_km_from_home/constants.dart';
import 'package:five_km_from_home/controllers/map_controller.dart';
import 'package:five_km_from_home/views/widgets/button.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:five_km_from_home/views/widgets/rounded_bottom_sheet.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SafeCircleRadiusPicker extends StatelessWidget {
  final int safeCircleRadius;

  const SafeCircleRadiusPicker({this.safeCircleRadius});
  @override
  Widget build(BuildContext context) {
    int _currentSafeCircleRadius =
        context.read<MapController>().safeCircleRadius;
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setModalState) {
        return RoundedBottomSheet(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Set A New Safe Circle Radius',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  fontFamily: 'RobotoSlab',
                ),
              ),
              NumberPicker(
                textStyle: TextStyle(
                  fontFamily: 'RobotoSlab',
                  fontSize: 15,
                ),
                selectedTextStyle: TextStyle(
                    fontFamily: 'RobotoSlab',
                    fontSize: 35,
                    color: primaryColor),
                value: _currentSafeCircleRadius,
                minValue: 0,
                maxValue: 100,
                axis: Axis.horizontal,
                haptics: true,
                onChanged: (int newSafeCircleRadius) {
                  setModalState(
                    () {
                      _currentSafeCircleRadius = newSafeCircleRadius;
                    },
                  );
                },
              ),
              Button(
                onPressed: () {
                  SharedPreferences.getInstance().then((prefs) {
                    prefs.setInt('safeCircleRadius', _currentSafeCircleRadius);
                    context
                        .read<MapController>()
                        .home
                        .circles
                        .reloadSafeCircleRadius(
                          context.read<MapController>().home.homeLocation,
                          context.read<MapController>().distanceFromHome,
                        );
                  });
                  Navigator.pop(context);
                },
                icon: Icon(Icons.check),
                text: 'Confirm',
              )
            ],
          ),
        );
      },
    );
  }
}
