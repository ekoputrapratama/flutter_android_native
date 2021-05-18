import 'package:flutter/material.dart';

import 'package:android_native/Manifest.dart';
import 'package:android_native/content/ComponentName.dart';
import 'package:android_native/content/pm/PackageManager.dart';
import 'package:android_native/app/Activity.dart';
import 'package:android_native/content/Intent.dart' as Native;

class ActivityPage extends Activity {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ActivityState();
  }
}

class _ActivityState extends ActivityState<ActivityPage> {
  String _result = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Activity Example'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // TextButton(
          //     onPressed: () {
          //       var intent = Native.Intent();
          //       // intent.action = Native.Intent.ACTION_VIEW;
          //       // intent.component = ComponentName(
          //       //     "com.example.android_native_example",
          //       //     "com.example.android_native_example.SecondActivity");

          //       startActivity(intent);
          //     },
          //     child: Text("startActivity")),
          TextButton(
              onPressed: () {
                var intent = Native.Intent();
                // intent.action = Native.Intent.ACTION_VIEW;
                // intent.component = ComponentName(
                //     "com.example.android_native_example",
                //     "com.example.android_native_example.SecondActivity");

                startActivityForResult(intent, 100);
              },
              child: Text("startActivityForResult")),
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
          TextButton(
              onPressed: () {
                requestPermissions(
                    [Manifest.permission.WRITE_EXTERNAL_STORAGE], 9878);
              },
              child: Text("requestPermissions")),
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
