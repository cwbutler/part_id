import 'dart:io';

import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:part_id/components/SettingsDropdown.dart';
import 'package:part_id/models/app.dart';
import 'package:part_id/screens/AnalyzeImage.dart';
import 'package:part_id/screens/Camera.dart';
import 'package:part_id/screens/Welcome.dart';

class PartIDHome extends HookConsumerWidget {
  const PartIDHome({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void navigateAway(XFile? image) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PartIDAnalyzeImage(image: image),
        ),
      );
    }

    void navigateToLogout() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const PartIDWelcome(),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 100,
          horizontal: 60,
        ),
        child: Column(children: [
          const Row(
            children: [
              Text(
                "PartID",
                style: TextStyle(
                  fontSize: 42,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Spacer(),
              PartIDSettingsDropdown(),
            ],
          ),
          Expanded(
            child: Center(
              child: Container(
                margin: const EdgeInsets.only(bottom: 40),
                width: 640,
                child: Wrap(
                  alignment: WrapAlignment.spaceEvenly,
                  runAlignment: WrapAlignment.spaceEvenly,
                  runSpacing: 20.0,
                  children: [
                    GestureDetector(
                      onTap: () => showCupertinoModalPopup(
                        context: context,
                        builder: (context) => CupertinoActionSheet(
                          message: const Text("Choose an action:"),
                          cancelButton: CupertinoActionSheetAction(
                            onPressed: () => Navigator.pop(context),
                            child: const Text("Dismiss"),
                          ),
                          actions: [
                            CupertinoActionSheetAction(
                              onPressed: () async {
                                final image = await AppUtils.pickImage();
                                if (image != null) {
                                  navigateAway(image);
                                }
                              },
                              child: const Text("Upload an image"),
                            ),
                            CupertinoActionSheetAction(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (route) => const PartIDCamera(),
                                  ),
                                );
                              },
                              child: const Text("Take a photo"),
                            ),
                          ],
                        ),
                      ),
                      child: Image.asset('assets/images/scan_parts.png'),
                    ),
                    GestureDetector(
                      child: Image.asset('assets/images/view_dash.png'),
                    ),
                  ],
                ),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              AppUtils.signOutCurrentUser();
              navigateToLogout();
            },
            child: const Text(
              "Logout",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Color(0xffC1292E),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
