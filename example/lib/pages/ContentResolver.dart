import 'dart:developer' as developer;
import 'dart:math';

import 'package:android_native/app/Activity.dart';
import 'package:android_native/provider/Settings.dart';
import 'package:flutter/material.dart';

class ContentResolverPage extends Activity {
  @override
  _ContentResolverPageState createState() => _ContentResolverPageState();
}

class _ContentResolverPageState extends ActivityState<ContentResolverPage> {
  String _result = "";
  late int currentBrightness;
  late int expectedBrightness;
  bool alreadyChanged = false;

  @override
  void initState() {
    super.initState();
  }

  Future onSettingsChanged(bool selfChange, Uri? uri, int flags) async {
    developer.log("onSettingsChanged : uri=$uri");
    // if (!alreadyChanged) {
    var brightnessUri =
        Settings.System.getUriFor(Settings.System.SCREEN_BRIGHTNESS);
    if (uri != null && uri.toString() == brightnessUri.toString()) {
      var brightness =
          await Settings.System.getInt(Settings.System.SCREEN_BRIGHTNESS);
      setState(() {
        _result = """
          Settings ContentObserver\n

          Previous Brightness : $currentBrightness
          Expected Brightness : $expectedBrightness
          Current Brightness  : $brightness
          """;
      });
      //   alreadyChanged = true;
      // }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ContentResolver Example'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextButton(
            onPressed: () async {
              getContentResolver().registerContentObserver(
                  Settings.System.CONTENT_URI, onSettingsChanged);
            },
            child: Text("registerContentResolver"),
          ),
          TextButton(
            onPressed: () {
              getContentResolver().unregisterContentObserver(onSettingsChanged);
            },
            child: Text("unregisterContentResolver"),
          ),
          Text(
            "Result",
            textAlign: TextAlign.center,
          ),
          Expanded(
            flex: 1,
            child: SingleChildScrollView(
              child: Text(_result),
            ),
          )
        ],
      ),
    );
  }
}
