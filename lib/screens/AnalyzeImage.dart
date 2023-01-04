import 'dart:io';

import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:part_id/models/app.dart';

class PartIDAnalyzeImage extends HookConsumerWidget {
  final XFile? image;
  const PartIDAnalyzeImage({super.key, this.image});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void init() async {
      if (image != null) {
        final expires = DateTime(DateTime.now().day + 1);
        final key = await AppUtils.uploadFileToS3(
          file: File(image!.path),
          key: "temp/${image!.name}",
          options: S3UploadFileOptions(metadata: {
            "Expires": "${expires.year}-${expires.month}-${expires.day}"
          }),
        );
        debugPrint(key);
      }
    }

    useEffect(() {
      init();
      return null;
    }, [image]);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        height: double.infinity,
        child: Center(
          child: Column(
            children: [
              Image.asset("assets/images/analyze.gif"),
              const Text(
                "Analyzing your part....",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 48),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
