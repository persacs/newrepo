import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class Musik extends StatelessWidget {
  AudioPlayer? player = AudioPlayer();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Play Audio",
              ),
              Image(image: AssetImage("assets/audio.jpg")),
              ElevatedButton(
                child: Text(
                  'Play',
                ),
                onPressed: () async {
                  player!.play(AssetSource('welcomestranger-34421.mp3'));
                },
              ),
              ElevatedButton(
                child: Text(
                  'Pause',
                ),
                onPressed: () async {
                  player!.pause();
                },
              ),
              ElevatedButton(
                child: Text(
                  'Resume',
                ),
                onPressed: () async {
                  player!.resume();
                },
              ),
              ElevatedButton(
                child: Text(
                  'Stop',
                ),
                onPressed: () async {
                  player!.stop();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
