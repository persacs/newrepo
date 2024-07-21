import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path/path.dart' as path;

class VideoGallery extends StatefulWidget {
  @override
  _VideoGalleryState createState() => _VideoGalleryState();
}

class _VideoGalleryState extends State<VideoGallery> {
  File? _videoGallery;

  ImagePicker picker = ImagePicker();

  VideoPlayerController? _videoPlayerController;
  XFile? pickedFile;

  // This funcion will helps you to pick a Video File
  _pickVideo() async {
    pickedFile = await picker.pickVideo(source: ImageSource.gallery);

    _videoGallery = File(pickedFile!.path);

    _videoPlayerController = VideoPlayerController.file(_videoGallery!)
      ..initialize().then((_) {
        setState(() {});
        _videoPlayerController!.play();
      });
  }

  _saveVideoToGallery() {
    String fileDir = path.dirname(pickedFile!.path);
    var dt = DateTime.now();
    var bulan;
    if (dt.month < 10) {
      bulan = '0' + dt.month.toString();
    } else {
      bulan = dt.month;
    }
    var hari;
    if (dt.day < 10) {
      hari = '0' + dt.day.toString();
    } else {
      hari = dt.day;
    }
    var jam;
    if (dt.hour < 10) {
      jam = '0' + dt.hour.toString();
    } else {
      jam = dt.hour;
    }
    var menit;
    if (dt.minute < 10) {
      menit = '0' + dt.minute.toString();
    } else {
      menit = dt.minute;
    }
    var detik;
    if (dt.second < 10) {
      detik = '0' + dt.second.toString();
    } else {
      detik = dt.second;
    }
    String newPath = path.join(
        fileDir, 'vid_glr_${dt.year}$bulan${hari}_$jam$menit$detik.mp4');
    File image = File(pickedFile!.path).renameSync(newPath);
    if (pickedFile != null) {
      GallerySaver.saveVideo(image.path, albumName: "Media");
    }
    const snackBar = SnackBar(
      content: Text('Video saved to Gallery'),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                if (_videoGallery != null)
                  _videoPlayerController!.value.isInitialized
                      ? AspectRatio(
                        aspectRatio: _videoPlayerController!.value.aspectRatio,
                          child: VideoPlayer(_videoPlayerController!),
                        )
                      : Container()
                else
                  Text(
                    "Click on Pick Video to select video",
                    style: TextStyle(fontSize: 18.0),
                  ),
                ElevatedButton(
                  onPressed: () {
                    _pickVideo();
                  },
                  child: Text("Pick Video From Gallery"),
                ),
                if (_videoGallery != null)
                  ElevatedButton(
                    onPressed: () {
                      _saveVideoToGallery();
                    },
                    child: Text("Save Video to Gallery"),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
