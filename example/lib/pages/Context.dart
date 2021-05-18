import 'package:android_native/Manifest.dart';
import 'package:android_native/app/Activity.dart';
import 'package:android_native/content/ComponentName.dart';
import 'package:android_native/content/Intent.dart' as Native;
import 'package:android_native/content/pm/PackageManager.dart';
import 'package:flutter/material.dart';

class ContextPage extends Activity {
  @override
  _ContextPageState createState() => _ContextPageState();
}

class _ContextPageState extends ActivityState<ContextPage> {
  String _result = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Context Example'),
      ),
      body: Column(
        children: [
          TextButton(
            onPressed: () {
              var intent = Native.Intent(action: Native.Intent.ACTION_VIEW);
              intent.setComponent(ComponentName(
                  "com.example.android_native_example",
                  "com.example.android_native_example.SecondActivity"));

              startActivity(intent);
            },
            child: Text("startActivity"),
          ),
          TextButton(
              onPressed: () {
                checkSelfPermission(Manifest.permission.WRITE_EXTERNAL_STORAGE)
                    .then((value) {
                  setState(() {
                    _result = """
                    checkSelfPermission
                    Storage
                    Grant Result  : ${value == PackageManager.PERMISSION_GRANTED}
                    """;
                  });
                });
              },
              child: Text("checkSelfPermission")),
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
