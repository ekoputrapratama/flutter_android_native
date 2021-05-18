import 'package:android_native/content/pm/PackageManager.dart';
import 'package:flutter/material.dart';
import 'package:android_native/app/Activity.dart';
import 'package:android_native/content/Intent.dart' as Native;

class PackageManagerPage extends Activity {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _PackageManagerState();
  }
}

class _PackageManagerState extends ActivityState<PackageManagerPage> {
  String _result = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PackageManager Example'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextButton(
            onPressed: () async {
              var apps = await getContext()
                  .getPackageManager()
                  .getInstalledApplications(PackageManager.MATCH_ALL);

              setState(() {
                _result = """

                  getInstalledApplications

                  Apps count : ${apps.length}
                  $apps
                  """
                    .replaceAll(new RegExp(r"^\s+", multiLine: true), "");
              });
            },
            child: Text("getInstalledApplications"),
          ),
          TextButton(
            onPressed: () async {
              var apps = (await getContext()
                      .getPackageManager()
                      .getInstalledPackages(PackageManager.MATCH_ALL))
                  .map((e) => e.toMap())
                  .toList();

              setState(() {
                _result = """

                  getInstalledPackages

                  Apps count : ${apps.length}
                  $apps
                  """
                    .replaceAll(new RegExp(r"^\s+", multiLine: true), "");
              });
            },
            child: Text("getInstalledPackages"),
          ),
          TextButton(
            onPressed: () async {
              var intent = Native.Intent(action: Native.Intent.ACTION_MAIN);
              // intent.addCategory(Native.Intent.CATEGORY_LAUNCHER);
              // intent.addCategory(Native.Intent.CATEGORY_LAUNCHER);
              intent.addCategory(Native.Intent.CATEGORY_HOME);
              var apps = (await getContext()
                      .getPackageManager()
                      .queryIntentActivities(intent, 0))
                  .map((e) => e.toMap());

              setState(() {
                _result = """

                  queryIntentActivities

                  Apps count : ${apps.length}
                  $apps
                  """
                    .replaceAll(new RegExp(r"^\s+", multiLine: true), "");
              });
            },
            child: Text("queryIntentActivities"),
          ),
          Text(
            "Result",
            textAlign: TextAlign.center,
          ),
          Expanded(
            flex: 1,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(5),
                child: Text(_result),
              ),
            ),
          )
        ],
      ),
    );
  }
}
