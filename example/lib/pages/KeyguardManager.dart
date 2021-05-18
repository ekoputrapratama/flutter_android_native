import 'package:android_native/app/KeyguardManager.dart';
import 'package:android_native/content/Context.dart';
import 'package:flutter/material.dart';
import 'package:android_native/app/Activity.dart';

class KeyguardManagerPage extends Activity {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _KeyguardManagerState();
  }
}

class _KeyguardManagerState extends ActivityState<KeyguardManagerPage> {
  String _result = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('KeyguardManager Example'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextButton(
              onPressed: () async {
                var keyguardManager = getSystemService(Context.KEYGUARD_SERVICE)
                    as KeyguardManager;
                var isLocked = await keyguardManager.isKeyguardLocked();

                setState(() {
                  _result = """

                  Is Keyguard Locked : $isLocked
                  """;
                });
              },
              child: Text("isKeyguardLocked")),
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
