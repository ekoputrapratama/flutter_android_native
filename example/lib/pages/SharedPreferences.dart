import 'dart:developer';

import 'package:android_native/preference/PreferenceManager.dart';
import 'package:flutter/material.dart';
import 'package:android_native/app/Activity.dart';

class SharedPreferencesPage extends Activity {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SharedPreferencesState();
  }
}

class _SharedPreferencesState extends ActivityState<SharedPreferencesPage> {
  String _result = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SharedPreferences Example'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextButton(
            onPressed: () async {
              var prefs = PreferenceManager.getDefaultSharedPreference();

              var expectedVal1 = true;
              var expectedVal2 = 100;
              var expectedVal3 = 31.5;
              var expectedVal4 = "Hello World!";

              await prefs.edit().putBoolean("test1", expectedVal1).commit();
              await prefs.edit().putInt("test2", expectedVal2).commit();
              await prefs.edit().putFloat("test3", expectedVal3).commit();
              await prefs.edit().putString("test4", expectedVal4).commit();

              setState(() {
                _result = """

                  =====================
                  Write
                  =====================
                  test1 : $expectedVal1
                  test2 : $expectedVal2
                  test3 : $expectedVal3
                  test4 : $expectedVal4
                  =====================
                  Read
                  =====================
                  test1 : ${prefs.getBoolean("test1")}
                  test2 : ${prefs.getInt("test2")}  
                  test3 : ${prefs.getFloat("test3")}
                  test4 : ${prefs.getString("test4")}
                  =====================
                  JSON
                  =====================
                  ${prefs.getAll()}
                  """
                    .replaceAll(new RegExp(r"^\s+", multiLine: true), "");
                // .replaceAll(new RegExp(r"(\n\s+)", multiLine: true), "\n");
                log(_result);
              });
            },
            child: Text("Read/Write"),
          ),
          Text(
            "Result",
            textAlign: TextAlign.center,
          ),
          Expanded(
            flex: 1,
            child: SingleChildScrollView(
              child: Text(
                _result,
                textAlign: TextAlign.left,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
