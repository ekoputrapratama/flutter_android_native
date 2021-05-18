import 'package:android_native_example/pages/TelephonyManager.dart';
import 'package:flutter/material.dart';
import 'package:android_native/app/Application.dart';

import 'pages/AudioManager.dart';
import 'pages/Context.dart';
import 'pages/Home.dart';
import 'pages/KeyguardManager.dart';
import 'pages/PowerManager.dart';
import 'pages/SharedPreferences.dart';
import 'pages/Activity.dart';
import 'pages/ContentResolver.dart';
import 'pages/PackageManager.dart';
import 'pages/Settings.dart';
import 'pages/PermissionTest.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Application(
      home: HomePage(),
      routes: {
        "activity": (BuildContext context) => ActivityPage(),
        "audio-manager": (BuildContext context) => AudioManagerPage(),
        "package-manager": (BuildContext context) => PackageManagerPage(),
        "keyguard-manager": (BuildContext context) => KeyguardManagerPage(),
        "power-manager": (BuildContext context) => PowerManagerPage(),
        "shared-preferences": (BuildContext context) => SharedPreferencesPage(),
        "settings": (BuildContext context) => SettingsPage(),
        "context": (BuildContext context) => ContextPage(),
        "content-resolver": (BuildContext context) => ContentResolverPage(),
        "permission-test": (BuildContext context) => PermissionTestPage(),
        "telephony-manager": (BuildContext context) => TelephonyManagerPage(),
      },
    );
  }
}
