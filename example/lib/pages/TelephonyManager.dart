import 'package:android_native/content/Context.dart';
import 'package:android_native/telephony/TelephonyManager.dart';
import 'package:flutter/material.dart';
import 'package:android_native/app/Activity.dart';

class TelephonyManagerPage extends Activity {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _TelephonyManagerState();
  }
}

class _TelephonyManagerState extends ActivityState<TelephonyManagerPage> {
  String _result = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TelephonyManager Example'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextButton(
            onPressed: () async {
              var tm = getSystemService(Context.TELEPHONY_SERVICE)
                  as TelephonyManager;
              var countryIso = await tm.getNetworkCountryIso();

              setState(() {
                _result = """

                  Network Country ISO : $countryIso
                  """;
              });
            },
            child: Text("getNetworkCountryIso"),
          ),
          TextButton(
            onPressed: () async {
              var tm = getSystemService(Context.TELEPHONY_SERVICE)
                  as TelephonyManager;
              var operatorName = await tm.getNetworkOperatorName();

              setState(() {
                _result = """

                  Operator Name : $operatorName
                  """;
              });
            },
            child: Text("getNetworkOperatorName"),
          ),
          TextButton(
            onPressed: () async {
              var tm = getSystemService(Context.TELEPHONY_SERVICE)
                  as TelephonyManager;
              var id = await tm.getSimCarrierId();

              setState(() {
                _result = """

                  Carrier Id : $id
                  """;
              });
            },
            child: Text("getSimCarrierId"),
          ),
          TextButton(
            onPressed: () async {
              var tm = getSystemService(Context.TELEPHONY_SERVICE)
                  as TelephonyManager;
              var id = await tm.getDeviceId();

              setState(() {
                _result = """

                  Device Id : $id
                  """;
              });
            },
            child: Text("getDeviceId"),
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
