import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_pads/AudioInfo.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Pads',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  AudioInfoProvider provider = AudioInfoProvider();

  AudioCache audioCache = new AudioCache();

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _createPadsTile(),
              _createPadsTile(),
              _createPadsTile()
            ]));
  }

  Widget _createPadsTile() {
    return Expanded(
        child: Row(children: <Widget>[
      PadWidget(provider.getAudioInfo(), playAudioInfo),
      PadWidget(provider.getAudioInfo(), playAudioInfo),
      PadWidget(provider.getAudioInfo(), playAudioInfo)
    ]));
  }

  playAudioInfo(AudioInfo audioInfo) {
    Future<AudioPlayer> result = audioCache.play(audioInfo.url);
    result.then((player) {
      audioCache.fixedPlayer = player;
    });
  }
}

class PadWidget extends StatefulWidget {
  PadWidget(this.audioInfo, this.padPressedListener);

  AudioInfo audioInfo;
  Function(AudioInfo) padPressedListener;

  @override
  State createState() => PadState();
}

class PadState extends State<PadWidget> {
  var pressed = false;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: GestureDetector(
            onTapDown: (details) {
              _setPressed(true);
            },
            onTapUp: (details) {
              widget.padPressedListener(widget.audioInfo);
              _setPressed(false);
            },
            onTapCancel: () {
              _setPressed(false);
            },
            child: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.all(10),
                color: Colors.green,
                child: Text(
                  widget.audioInfo.title,
                  style: TextStyle(
                      fontSize: 10,
                      color: pressed ? Colors.grey : Colors.white),
                ))));
  }

  void _setPressed(bool pressed) {
    setState(() {
      this.pressed = pressed;
    });
  }
}
