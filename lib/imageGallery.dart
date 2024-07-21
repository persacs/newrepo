import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path/path.dart' as path;

class ImageGallery extends StatefulWidget {
  @override
  _ImageGalleryState createState() => _ImageGalleryState();
}

class _ImageGalleryState extends State<ImageGallery> {
  File? _imageGallery;
  ImagePicker picker = ImagePicker();
  XFile? pickedFile;

  // This function will help you to pick an Image from Gallery
  _pickImageFromGallery() async {
    pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      File image = File(pickedFile!.path);
      setState(() {
        _imageGallery = image;
      });
    }
  }

  // This function will save the picked Image to Gallery
  _saveImageToGallery() {
    if (pickedFile != null) {
      String fileDir = path.dirname(pickedFile!.path);
      var dt = DateTime.now();
      var bulan = dt.month < 10 ? '0${dt.month}' : dt.month.toString();
      var hari = dt.day < 10 ? '0${dt.day}' : dt.day.toString();
      var jam = dt.hour < 10 ? '0${dt.hour}' : dt.hour.toString();
      var menit = dt.minute < 10 ? '0${dt.minute}' : dt.minute.toString();
      var detik = dt.second < 10 ? '0${dt.second}' : dt.second.toString();

      String newPath = path.join(
          fileDir, 'img_glr_${dt.year}$bulan${hari}_$jam$menit$detik.jpg');

      File image = File(pickedFile!.path).renameSync(newPath);

      GallerySaver.saveImage(image.path, albumName: "Media");

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Image saved to Gallery'),
        ),
      );
    }
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
                if (_imageGallery != null)
                  Image.file(_imageGallery!)
                else
                  Text(
                    "Click on Pick Image to select an Image",
                    style: TextStyle(fontSize: 18.0),
                  ),
                ElevatedButton(
                  onPressed: () {
                    _pickImageFromGallery();
                  },
                  child: Text("Pick Image From Gallery"),
                ),
                if (_imageGallery != null)
                  ElevatedButton(
                    onPressed: () {
                      _saveImageToGallery();
                    },
                    child: Text("Save Image to Gallery"),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
