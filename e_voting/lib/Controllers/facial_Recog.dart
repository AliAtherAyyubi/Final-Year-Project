import 'dart:io';
import 'dart:ui';

import 'package:e_voting/Controllers/image_control.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

//
class FacialRecognition {
  late File file;
  XFile? image;

  //
  Future<void> faceDetection() async {
    image = await ImageController().pickCameraImage();
    //
    final ImagePath = File(image!.path);
    final data = await ImagePath.readAsBytes();
    final decodeImage = await decodeImageFromList(data);
    //
    //
    final inputImage = InputImage.fromFile(file);
    // final faces = await FaceDetector().processImage(inputImage);
  }
}
