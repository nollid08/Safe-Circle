import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RetainApp extends StatelessWidget {
  const RetainApp({this.child});

  final Widget child;

  final _channel = const MethodChannel('com.example/app_retain');

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (Platform.isAndroid) {
          if (Navigator.of(context).canPop()) {
            return true;
          } else {
            _channel.invokeMethod('sendToBackground');
            return false;
          }
        } else {
          return true;
        }
      },
      child: child,
    );
  }
}
