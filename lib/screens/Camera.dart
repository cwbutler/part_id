import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:part_id/screens/AnalyzeImage.dart';

late CameraController controller;
late XFile image;

class PartIDCamera extends HookConsumerWidget {
  const PartIDCamera({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isInitialized = useState(false);
    final hasImage = useState(false);
    final previewImage = useState<XFile?>(null);

    void navigateAway(XFile? image) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PartIDAnalyzeImage(image: image),
        ),
      );
    }

    void init() async {
      // Ensure that plugin services are initialized so that `availableCameras()`
      // can be called before `runApp()`
      WidgetsFlutterBinding.ensureInitialized();
      // Obtain a list of the available cameras on the device.
      final cameras = await availableCameras();
      // To display the current output from the Camera, create a CameraController.
      controller = CameraController(cameras[0], ResolutionPreset.medium);
      await controller.initialize();
      isInitialized.value = true;
    }

    useEffect(() {
      init();
      return () => controller.dispose();
    }, []);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        toolbarHeight: 148,
        backgroundColor: Colors.black,
        leadingWidth: 120,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Image.asset("assets/images/camera_close.png"),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 208,
        child: (!hasImage.value)
            ? Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () async {
                        // Take the Picture in a try / catch block. If anything goes wrong,
                        // catch the error.
                        try {
                          // Attempt to take a picture and then get the location where the image file is saved.
                          final image = await controller.takePicture();
                          hasImage.value = true;
                          previewImage.value = image;
                        } catch (e) {
                          // If an error occurs, log the error to the console.
                          debugPrint(e.toString());
                        }
                      },
                      child: Image.asset(
                        "assets/images/camera_shutter.png",
                        width: 88,
                        height: 88,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      margin: const EdgeInsets.only(left: 210),
                      child: GestureDetector(
                        child: Image.asset(
                          "assets/images/flash_button.png",
                          width: 48,
                          height: 48,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: 320,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (previewImage.value != null) {
                          navigateAway(previewImage.value!);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xffA8DBA8),
                      ),
                      child: const Text(
                        "Use Photo",
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 320,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () {
                        hasImage.value = false;
                        previewImage.value = null;
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                      ),
                      child: const Text(
                        "Retake Photo",
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: (hasImage.value && previewImage.value != null)
            ? Image.file(File(previewImage.value!.path))
            : (isInitialized.value)
                ? CameraPreview(controller)
                : const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
