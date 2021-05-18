import 'package:android_native/content/Context.dart';
import 'package:android_native/media/AudioManager.dart';
import 'package:flutter/material.dart';
import 'package:android_native/app/Activity.dart';

class AudioManagerPage extends Activity {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AudioManagerState();
  }
}

class _AudioManagerState extends ActivityState<AudioManagerPage> {
  String _result = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AudioManager Example'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextButton(
            onPressed: () async {
              var audioManager =
                  getSystemService(Context.AUDIO_SERVICE) as AudioManager;
              var minVolume = await audioManager
                  .getStreamMinVolume(AudioManager.STREAM_MUSIC);
              var maxVolume = await audioManager
                  .getStreamMaxVolume(AudioManager.STREAM_MUSIC);
              var volume =
                  await audioManager.getStreamVolume(AudioManager.STREAM_MUSIC);
              setState(() {
                _result = """

                  Music

                  Min Volume     : $minVolume
                  Max Volume     : $maxVolume
                  Current Volume : $volume
                  """;
              });
            },
            child: Text("Music"),
          ),
          TextButton(
            onPressed: () async {
              var audioManager =
                  getSystemService(Context.AUDIO_SERVICE) as AudioManager;
              var minVolume = await audioManager
                  .getStreamMinVolume(AudioManager.STREAM_ALARM);
              var maxVolume = await audioManager
                  .getStreamMaxVolume(AudioManager.STREAM_ALARM);
              var volume =
                  await audioManager.getStreamVolume(AudioManager.STREAM_ALARM);
              setState(() {
                _result = """

                  Alarm

                  Min Volume     : $minVolume
                  Max Volume     : $maxVolume
                  Current Volume : $volume
                  """;
              });
            },
            child: Text("Alarm"),
          ),
          TextButton(
            onPressed: () async {
              var audioManager =
                  getSystemService(Context.AUDIO_SERVICE) as AudioManager;
              var minVolume = await audioManager
                  .getStreamMinVolume(AudioManager.STREAM_NOTIFICATION);
              var maxVolume = await audioManager
                  .getStreamMaxVolume(AudioManager.STREAM_NOTIFICATION);
              var volume = await audioManager
                  .getStreamVolume(AudioManager.STREAM_NOTIFICATION);
              setState(() {
                _result = """

                  Notification

                  Min Volume     : $minVolume
                  Max Volume     : $maxVolume
                  Current Volume : $volume
                  """;
              });
            },
            child: Text("Notification"),
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
