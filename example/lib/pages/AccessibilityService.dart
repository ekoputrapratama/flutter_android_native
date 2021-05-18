import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:android_native/app/Activity.dart';
import 'package:android_native/content/Intent.dart' as Native;
import 'package:android_native/accessibilityservice/AccessibilityService.dart';

class AccessibilityServicePage extends Activity {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AccessibilityServiceState();
  }
}

class _AccessibilityServiceState
    extends ActivityState<AccessibilityServicePage> {
  String _result = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('AccessibilityService Example'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextButton(
              onPressed: () async {
                // setState(() {
                //   _result = """

                //     getInstalledApplications

                //     Apps count : ${apps.length}
                //     $apps
                //     """
                //       .replaceAll(new RegExp(r"^\s+", multiLine: true), "");
                // });
              },
              child: Text("getInstalledApplications"),
            ),
          ],
        ));
  }
}

Future accessibilityRegistryCallback() async {
  log("registering accessibility Service in background");
  WidgetsFlutterBinding.ensureInitialized();
  // var db = AppDatabase.getInstance();
  // await db.init();

  AccessibilityService.registerService(MainAccessibilityService());
}

class MainAccessibilityService extends AccessibilityService {
  String? _currentApp;
  // AppDatabase db = AppDatabase.getInstance();
  // SharedPreferences prefs = PreferenceManager.getDefaultSharedPreference(true);
  // AudioManager? audioManager;
  List<String> _volumeUris = [
    "content://settings/system/volume_music_speaker",
    "content://settings/system/volume_music_headset",
    "content://settings/system/volume_ring_speaker",
    "content://settings/system/volume_alarm_speaker",
    "content://settings/system/volume_voice_earpiece",
    "content://settings/system/volume_voice_headset",
  ];

  @override
  Future onAccessibilityEvent(AccessibilityEvent? event) async {
    log("MainAccessibilityService : onAccessibilityEvent ${event?.toMap()}");
    switch (event?.eventType) {
      case AccessibilityEvent.TYPE_WINDOW_STATE_CHANGED:
        log("MainAccessibilityService : TYPE_WINDOW_STATE_CHANGED");
        // if (event?.packageName != null && event?.className != null) {
        //   var componentName =
        //       ComponentName(event!.packageName, event.className);
        //   var activityInfo = await _tryGetActivity(componentName);
        //   var isActivity = activityInfo != null;
        //   // log("accessibility event package name ${event.packageName}");
        //   log("activity info ${activityInfo?.toMap()}");
        //   if (isActivity) {
        //     _currentApp = componentName.packageName;
        //     await db.init();
        //     var app = await db.apps.getApp(_currentApp!);
        //     var autoSave = prefs.getBoolean(AUTO_SAVE_KEY, defaultValue: false);
        //     var dayTime = prefs.getString(DAY_TIME_KEY, defaultValue: "");

        //     if (app != null) {
        //       var savedBrightness = app.dayBrightness;
        //       log("restoring brightness for $_currentApp to $savedBrightness");
        //       await Settings.System.putInt(
        //           Settings.System.SCREEN_BRIGHTNESS, savedBrightness);
        //       var updatedBrightness = await Settings.System.getInt(
        //           Settings.System.SCREEN_BRIGHTNESS);
        //       if (updatedBrightness != savedBrightness) {
        //         log("cannot update brightness");
        //       }

        //       if (audioManager != null) {
        //         var isMusicActive = await audioManager!.isMusicActive();
        //         if (!isMusicActive) {
        //           var savedVolume = app.dayVolume;
        //           if (savedVolume == -1) {
        //             savedVolume = await audioManager!
        //                 .getStreamVolume(AudioManager.STREAM_MUSIC);
        //             prefs
        //                 .edit()
        //                 .putInt(componentName.packageName!, savedVolume)
        //                 .apply();
        //           } else {
        //             audioManager!.setStreamVolume(
        //                 AudioManager.STREAM_MUSIC, savedVolume);
        //           }
        //         }
        //       }
        //     }
        //   } else if (event.packageName != "com.android.systemui") {
        //     _currentApp = null;
        //   }
        // }
        break;
    }
  }

  // Future onSettingsChanged(bool selfChange, Uri? uri, int flags) async {
  //   final brightnessUri =
  //       Settings.System.getUriFor(Settings.System.SCREEN_BRIGHTNESS);
  //   log("onSettingsChanged : $uri");
  //   if (_currentApp != null) {
  //     var app = await db.apps.getApp(_currentApp!);
  //     if (app != null && uri.toString() == brightnessUri.toString()) {
  //       var savedBrightness = app.dayBrightness;
  //       var currentBridghtness =
  //           await Settings.System.getInt(Settings.System.SCREEN_BRIGHTNESS);

  //       if (currentBridghtness != savedBrightness) {
  //         log("updating value for brightness from $savedBrightness to $currentBridghtness for package $_currentApp");
  //         db.apps.updateDayBrightness(_currentApp!, currentBridghtness);
  //       }
  //     } else if (app != null && _volumeUris.contains(uri.toString())) {
  //       var savedVol = app.dayVolume;
  //       var currentVol =
  //           await audioManager!.getStreamVolume(AudioManager.STREAM_MUSIC);

  //       if (currentVol != savedVol) {
  //         log("updating value for volume from $savedVol to $currentVol");
  //         db.apps.updateDayVolume(app.packageName, currentVol);
  //       }
  //     }
  //   }
  // }

  @override
  void onDestroy() {
    log("MainAccessibilityService : onDestroy");
    // audioManager = null;
    // getContentResolver().unregisterContentObserver(onSettingsChanged);
  }

  @override
  void onInterrupt() {
    log("MainAccessibilityService : onInterrupt");
  }

  @override
  void onServiceConnected() {
    log("MainAccessibilityService : onServiceConnected");
    // audioManager = getSystemService(Context.AUDIO_SERVICE);

    // getContentResolver().registerContentObserver(
    //     Settings.System.CONTENT_URI, onSettingsChanged);
  }

  // Future<ActivityInfo?> _tryGetActivity(ComponentName componentName) async {
  //   return packageManager.getActivityInfo(componentName);
  // }
}
