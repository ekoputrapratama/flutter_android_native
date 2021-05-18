import 'package:android_native/provider/Settings.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  var _canWrite = false;
  @override
  void initState() {
    super.initState();
    Settings.System.canWrite();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Column(
            children: [
              Text(
                "System Settings",
                textAlign: TextAlign.center,
              ),
              Text(
                "canWrite : $_canWrite",
              )
            ],
          )
        ],
      ),
    );
  }
}
