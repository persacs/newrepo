import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path/path.dart' as path;

class VideoCamera extends StatefulWidget {
  @override
  _VideoCameraState createState() => _VideoCameraState();
}

class _VideoCameraState extends State<VideoCamera> {
  File? _videoCamera;

  ImagePicker picker = ImagePicker();

  VideoPlayerController? _cameraVideoPlayerController;
  XFile? pickedFile;

  // This funcion will helps you to pick a Video File from Camera
  _pickVideoFromCamera() async {
    pickedFile = await picker.pickVideo(source: ImageSource.camera);

    _videoCamera = File(pickedFile!.path);

    _cameraVideoPlayerController = VideoPlayerController.file(_videoCamera!)
      ..initialize().then((_) {
        setState(() {});
        _cameraVideoPlayerController!.play();
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
        fileDir, 'vid_cmr_${dt.year}$bulan${hari}_$jam$menit$detik.mp4');
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
                if (_videoCamera != null)
                  _cameraVideoPlayerController!.value.isInitialized
                      ? AspectRatio(
                          aspectRatio:
                              _cameraVideoPlayerController!.value.aspectRatio,
                          child: VideoPlayer(_cameraVideoPlayerController!),
                        )
                      : Container()
                else
                  Text(
                    "Click on Pick Video to take video from Camera",
                    style: TextStyle(fontSize: 18.0),
                  ),
                ElevatedButton(
                  onPressed: () {
                    _pickVideoFromCamera();
                  },
                  child: Text("Pick Video From Camera"),
                ),
                if (_videoCamera != null)
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
