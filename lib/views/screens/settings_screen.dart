import 'package:five_km_from_home/controllers/map_controller.dart';
import 'package:five_km_from_home/views/widgets/rounded_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:five_km_from_home/constants.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:numberpicker/numberpicker.dart';

class SettingsScreen extends StatelessWidget {
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
            title: 'Section',
            tiles: [
              SettingsTile(
                title: 'Change Safe Circle Radius',
                subtitle: 'English',
                leading: Icon(Icons.language),
                onPressed: (BuildContext context) {
                  Scaffold.of(context).showBottomSheet(
                    (BuildContext buildContext) {
                      return RoundedBottomSheet(child: null);
                    },
                  );
                },
              ),
              SettingsTile.switchTile(
                title: 'Use fingerprint',
                leading: Icon(Icons.fingerprint),
                switchValue: false,
                onToggle: (bool value) {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
