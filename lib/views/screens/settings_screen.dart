import 'package:five_km_from_home/controllers/map_controller.dart';
import 'package:flutter/material.dart';
import 'package:five_km_from_home/constants.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:five_km_from_home/views/widgets/safe_circle_radius_picker.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Safe Circle Settings'),
        centerTitle: true,
        backgroundColor: primaryColor,
      ),
      body: SettingsList(
        contentPadding: const EdgeInsets.only(top: 16.0),
        sections: [
          SettingsSection(
            titleTextStyle: TextStyle(
              color: primaryColor,
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
            title: 'Settings',
            tiles: [
              SettingsTile(
                title: 'Change Safe Circle Radius',
                leading: Icon(Icons.radio_button_unchecked_outlined),
                onPressed: (BuildContext context) {
                  Scaffold.of(context).showBottomSheet(
                    (BuildContext buildContext) {
                      return SafeCircleRadiusPicker(
                          safeCircleRadius:
                              context.read<MapController>().safeCircleRadius);
                    },
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
