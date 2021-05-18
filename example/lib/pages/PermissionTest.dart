import 'package:android_native/provider/Settings.dart';
import 'package:flutter/material.dart';
import 'package:android_native/app/Activity.dart';
import 'package:android_native/content/Intent.dart' as Native;

class PermissionTestPage extends Activity {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _PermissionTestState();
  }
}

class _PermissionTestState extends ActivityState<PermissionTestPage> {
  String _result = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('PermissionTest Example'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextButton(
              onPressed: () async {
                var intent = Native.Intent(
                    action: Settings.ACTION_ACCESSIBILITY_SETTINGS);

                // intent
                //     .setData(Uri.dataFromString('package:com.mixaline.varity'));
                startActivity(intent);
              },
              child: Text("start Settings Activity"),
            ),
          ],
        ));
  }
}
