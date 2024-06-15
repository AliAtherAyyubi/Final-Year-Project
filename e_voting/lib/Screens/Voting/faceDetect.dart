import 'dart:io';
import 'dart:ui' as ui;
import 'package:e_voting/Controllers/image_control.dart';
import 'package:e_voting/Screens/Widgets/alert.dart';
import 'package:e_voting/Screens/Widgets/loading.dart';
import 'package:e_voting/Screens/Widgets/myButton.dart';
import 'package:e_voting/utils/Appstyles.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class FaceDetectionScreen extends StatefulWidget {
  final Function(bool) onDetectingChange;

  FaceDetectionScreen({required this.onDetectingChange});
  @override
  _FaceDetectionScreenState createState() => _FaceDetectionScreenState();
}

class _FaceDetectionScreenState extends State<FaceDetectionScreen> {
  late FaceDetector _faceDetector;
  List<Face> _faces = [];
  bool _isDetecting = false;
  bool _isFaceDetected = false;
  ui.Image? _image;

  @override
  void initState() {
    super.initState();
    _initializeFaceDetector();
  }

  void _initializeFaceDetector() {
    final options = FaceDetectorOptions(
      enableContours: true,
      enableLandmarks: true,
    );
    _faceDetector = FaceDetector(options: options);
  }

  Future<void> _selectImage() async {
    setState(() {
      _image = null;
    });
    final pickedFile = await ImageController().pickCameraImage();
    if (pickedFile != null) {
      _loadImage(File(pickedFile.path));
      _detectFaces(File(pickedFile.path));
    }
  }

  Future<void> _loadImage(File file) async {
    final data = await file.readAsBytes();
    final image = await decodeImageFromList(data);
    setState(() {
      _image = image;
    });
  }

  Future<void> _detectFaces(File file) async {
    if (_isDetecting) return;
    _isDetecting = true;

    final inputImage = InputImage.fromFile(file);
    final faces = await _faceDetector.processImage(inputImage);

    if (faces.length > 2) {
      MyAlert.showToast(0, 'Multiple faces are detected');
    }
    if (faces.isNotEmpty) {
      MyAlert.showToast(1, 'Face Detected ');
    } else {
      MyAlert.showToast(0, 'No Face Detected');
    }
    setState(() {
      _faces = faces;
      _isFaceDetected = faces.isNotEmpty;
    });
    _isDetecting = false;
    widget.onDetectingChange(_isFaceDetected);
  }

  @override
  void dispose() {
    _faceDetector.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _image != null
            ? Center(
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: SizedBox(
                    width: _image!.width.toDouble(),
                    height: _image!.height.toDouble() - 300,
                    child: CustomPaint(
                      painter: FacePainter(_image!, _faces),
                    ),
                  ),
                ),
              )
            : Center(child: SizedBox(height: 300, child: Loading())),
        SizedBox(
          height: 10,
        ),
        MyButton(
          onPress: _selectImage,
          text: 'Open Camera',
          width: 50.w,
          elevation: 0,
          backClr: Colors.orange,
          height: 45,
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}

class FacePainter extends CustomPainter {
  final ui.Image image;
  final List<Face> faces;
  final List<Rect> rects = [];

  FacePainter(this.image, this.faces) {
    for (var i = 0; i < faces.length; i++) {
      rects.add(faces[i].boundingBox);
    }
  }

  @override
  void paint(ui.Canvas canvas, ui.Size size) {
    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10
      ..color = AppStyle.cardClr;

    final Rect imageRect = Rect.fromLTWH(
      0,
      0,
      size.width,
      size.height,
    );
    canvas.drawImageRect(image, imageRect, imageRect, Paint());

    for (var i = 0; i < faces.length; i++) {
      canvas.drawRect(rects[i], paint);
    }
  }

  @override
  bool shouldRepaint(FacePainter oldDelegate) {
    return image != oldDelegate.image || faces != oldDelegate.faces;
  }
}
