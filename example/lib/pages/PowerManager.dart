import 'package:android_native/content/Context.dart';
import 'package:android_native/os/PowerManager.dart';
import 'package:flutter/material.dart';
import 'package:android_native/app/Activity.dart';

class PowerManagerPage extends Activity {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _PowerManagerState();
  }
}

class _PowerManagerState extends ActivityState<PowerManagerPage> {
  String _result = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PowerManager Example'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextButton(
            onPressed: () async {
              var powerManager =
                  getSystemService(Context.POWER_SERVICE) as PowerManager;
              var isInteractive = await powerManager.isInteractive();

              setState(() {
                _result = """

                  Is Interactive : $isInteractive
                  """;
              });
            },
            child: Text("isInteractive"),
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
