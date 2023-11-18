import 'dart:io';

import 'package:flutter/material.dart';
import 'package:soberguardian/test_breath.dart';
import 'package:camera/camera.dart';
import 'package:soberguardian/shared/singleton.dart';

class PhotoScreen extends StatefulWidget {
  const PhotoScreen({super.key});

  @override
  State<PhotoScreen> createState() => _PhotoScreenState();
}

class _PhotoScreenState extends State<PhotoScreen> {
    bool photoTaken = false;
    XFile? takenPhoto;
    late CameraController camController;
    final _singleton = Singleton();

    @override
    void initState() {
        super.initState();

        camController = CameraController(
            _singleton.cameras[0],
            ResolutionPreset.max
        );
        camController.initialize().then((_) {
            if (!mounted) {
                return;
            }
            setState(() {});
        });
    }

    void onTakePictureButtonPressed() {
        takePicture().then((XFile? file) {
        if (mounted) {
            setState(() {
            // imageFile = file;
            print(file);
            takenPhoto = file;
            // videoController?.dispose();
            // videoController = null;
            });
            if (file != null) {
            // showInSnackBar('Picture saved to ${file.path}');
            }
        }
        });
    }

    Future<XFile?> takePicture() async {

        if (camController.value.isTakingPicture) {
        // A capture is already pending, do nothing.
        return null;
        }

        try {
        final XFile file = await camController.takePicture();
        return file;
        } on CameraException catch (e) {
        return null;
        }
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: (!photoTaken) ? [
                Container(
                    color: Colors.amber,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: CameraPreview(camController),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                SizedBox(
                    width: MediaQuery.of(context).size.height * 0.10,
                    height: MediaQuery.of(context).size.height * 0.10,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(75),
                          ),
                      ),
                      onPressed: camController.value.isInitialized &&
                        !camController.value.isRecordingVideo ? () {
                        setState(() {
                            photoTaken = true;
                            onTakePictureButtonPressed();
                        });
                      } : null, 
                      child: null
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.045),
            ] : [
                Container(
                    color: Colors.amber,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.7,
                    // child: (takenPhoto != null) ? Image.file(File(takenPhoto!.path)) : null,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.045),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: ElevatedButton(onPressed: () {
                                setState(() {
                                    photoTaken = false;
                                });
                            }, child: Text("Retake"))),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: ElevatedButton(onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => BreathScreen()));
                            }, child: Text("Confirm")))
                    ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.06),
            ],
        ),
    );
  }
}