import 'package:flutter/material.dart';
import 'package:myapp/musik.dart';
import 'imageGallery.dart';
import 'imageCamera.dart';
import 'videoGallery.dart';
import 'videoCamera.dart';
import 'musik.dart';
import 'youtube_video.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 6,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              "TUGAS PERTEMUAN 14",
            ),
            bottom: TabBar(
              tabs: [
                Tab(
                  icon: Icon(Icons.image),
                  text: "Image\nGallery",
                ),
                Tab(
                  icon: Icon(Icons.camera),
                  text: "Image\nCamera",
                ),
                Tab(
                  icon: Icon(Icons.video_camera_back),
                  text: "Video\nGallery",
                ),
                Tab(
                  icon: Icon(Icons.video_camera_front),
                  text: "Video\nCamera",
                ),
                Tab(
                  icon: Icon(Icons.queue_music),
                  text: "Audio",
                ),
                Tab(
                  icon: Icon(Icons.video_call),
                  text: "Youtube Video",
                ),
              ],
              indicatorColor: Colors.amber,
            ),
          ),
          body: Container(
            height: double.infinity,
            width: double.infinity,
            child: TabBarView(
              children: [
                ImageGallery(),
                ImageCamera(),
                VideoGallery(),
                VideoCamera(),
                Musik(),
                YoutubeVideo()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
