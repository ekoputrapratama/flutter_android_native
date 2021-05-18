import 'dart:developer';
import 'dart:ffi';

import 'package:android_native/Manifest.dart';
import 'package:android_native/app/KeyguardManager.dart';
import 'package:android_native/content/ComponentName.dart';
import 'package:android_native/content/Context.dart';
import 'package:android_native/content/pm/PackageManager.dart';
import 'package:android_native/media/AudioManager.dart';
import 'package:android_native/os/PowerManager.dart';
import 'package:android_native/preference/PreferenceManager.dart';
import 'package:flutter/material.dart';

import 'package:android_native/app/Activity.dart';
import 'package:android_native/content/Intent.dart' as ni;

class HomePage extends Activity {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomeState();
  }
}

class _HomeState extends ActivityState<HomePage> {
  List<String> exampleList = [
    "Activity",
    "PackageManager",
    "AudioManager",
    "PowerManager",
    "KeyguardManager",
    "SharedPreferences",
    "Context",
    "ContentResolver",
    "TelephonyManager",
    "PermissionTest"
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void onActivityResult(int requestCode, int resultCode, ni.Intent? intent) {
    super.onActivityResult(requestCode, resultCode, intent);
    // log("onActivityResult : requestCode=$requestCode resultCode=$resultCode");
    // setState(() {
    //   _result = """
    //   onActivityResult

    //   Request Code : $requestCode
    //   Result Code : $resultCode
    //   Intent Data  : $intent
    //   """;
    // });
  }

  @override
  void onRequestPermissionsResult(
      int requestCode, List<String>? permissions, List<int>? grantResults) {
    super.onRequestPermissionsResult(requestCode, permissions, grantResults);
    // log("onRequestPermissionsResult : requestCode=$requestCode permissions=$permissions grantResults=$grantResults");
    setState(() {
      // _result = """
      // OnRequestPermissionResult

      // Request Code : $requestCode
      // Permissions : $permissions
      // Grant Results  : $grantResults
      // """;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Android Native Example'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            // height: MediaQuery.of(context).size.height,
            // child: SingleChildScrollView(
            //   // axisDirection: AxisDirection.down,
            //   // semanticChildCount: apps.length,
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.stretch,
            //     children: [...apps.map((app) => AppItemView(app))],
            //   ),
            // ),
            child: ListView.builder(
              itemCount: exampleList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(exampleList[index]),
                  onTap: () {
                    switch (index) {
                      case 0:
                        Navigator.pushNamed(context, "activity");
                        break;
                      case 1:
                        Navigator.pushNamed(context, "package-manager");
                        break;
                      case 2:
                        Navigator.pushNamed(context, "audio-manager");
                        break;
                      case 3:
                        Navigator.pushNamed(context, "power-manager");
                        break;
                      case 4:
                        Navigator.pushNamed(context, "keyguard-manager");
                        break;
                      case 5:
                        Navigator.pushNamed(context, "shared-preferences");
                        break;
                      case 6:
                        Navigator.pushNamed(context, "context");
                        break;
                      case 7:
                        Navigator.pushNamed(context, "content-resolver");
                        break;
                      case 8:
                        Navigator.pushNamed(context, "telephony-manager");
                        break;
                      case 9:
                        Navigator.pushNamed(context, "permission-test");
                        break;
                    }
                  },
                );
              },
            ),
          ),
          // TextButton(
          //     onPressed: () {
          //       var intent = ni.Intent();
          //       intent.action = ni.Intent.ACTION_VIEW;
          //       intent.component = ComponentName(
          //           "com.example.android_native_example",
          //           "com.example.android_native_example.SecondActivity");

          //       startActivity(intent);
          //     },
          //     child: Text("startActivity")),
          // TextButton(
          //     onPressed: () {
          //       var intent = ni.Intent();
          //       intent.action = ni.Intent.ACTION_VIEW;
          //       intent.component = ComponentName(
          //           "com.example.android_native_example",
          //           "com.example.android_native_example.SecondActivity");

          //       startActivityForResult(intent, 100);
          //     },
          //     child: Text("startActivityForResult")),
          // TextButton(
          //     onPressed: () {
          //       checkSelfPermission(Manifest.permission.WRITE_EXTERNAL_STORAGE)
          //           .then((value) {
          //         setState(() {
          //           _result = """
          //           checkSelfPermission
          //           Storage
          //           Grant Result  : ${value == PackageManager.PERMISSION_GRANTED}
          //           """;
          //         });
          //       });
          //     },
          //     child: Text("checkSelfPermission")),
          // TextButton(
          //     onPressed: () {
          //       requestPermissions(
          //           [Manifest.permission.WRITE_EXTERNAL_STORAGE], 9878);
          //     },
          //     child: Text("requestPermissions")),
          // TextButton(
          //     onPressed: () async {
          //       var audioManager =
          //           getSystemService(Context.AUDIO_SERVICE) as AudioManager;
          //       var minVolume =
          //           await audioManager.getStreamMinVolume(StreamType.MUSIC);
          //       var maxVolume =
          //           await audioManager.getStreamMaxVolume(StreamType.MUSIC);
          //       var volume =
          //           await audioManager.getStreamVolume(StreamType.MUSIC);
          //       setState(() {
          //         _result = """

          //         AudioManager

          //         Min Volume     : $minVolume
          //         Max Volume     : $maxVolume
          //         Current Volume : $volume
          //         """;
          //       });
          //     },
          //     child: Text("AudioManager")),
          // TextButton(
          //     onPressed: () async {
          //       var keyguardManager = getSystemService(Context.KEYGUARD_SERVICE)
          //           as KeyguardManager;
          //       var isLocked = await keyguardManager.isKeyguardLocked();

          //       setState(() {
          //         _result = """

          //         KeyguardManager

          //         Is Keyguard Locked : $isLocked
          //         """;
          //       });
          //     },
          //     child: Text("KeyguardManager")),
          // TextButton(
          //     onPressed: () async {
          //       var powerManager =
          //           getSystemService(Context.POWER_SERVICE) as PowerManager;
          //       var isInteractive = await powerManager.isInteractive();

          //       setState(() {
          //         _result = """

          //         PowerManager

          //         Is Interactive : $isInteractive
          //         """;
          //       });
          //     },
          //     child: Text("PowerManager")),
          // TextButton(
          //     onPressed: () async {
          //       var prefs = PreferenceManager.getDefaultSharedPreference();
          //       await prefs.edit().putBoolean("test1", true).commit();
          //       await prefs.edit().putInt("test2", 100).commit();
          //       await prefs.edit().putFloat("test3", 31.5).commit();
          //       await prefs.edit().putString("test4", "Hello World").commit();

          //       setState(() {
          //         _result = """

          //         SharedPreferences

          //         ${prefs.getAll()}
          //         """;
          //       });
          //     },
          //     child: Text("SharedPreferences")),
          // Text(
          //   "Result",
          //   textAlign: TextAlign.center,
          // ),
          // Text(_result)
        ],
      ),
    );
  }
}

class ExampleItemView extends StatefulWidget {
  ExampleItemView(this._text);
  final String _text;

  @override
  _ExampleItemViewState createState() => _ExampleItemViewState();
}

class _ExampleItemViewState extends State<ExampleItemView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 5, top: 5),
      child: Text(widget._text),
    );
  }
}
