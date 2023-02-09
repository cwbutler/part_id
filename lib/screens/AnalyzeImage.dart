import 'dart:io';

import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:part_id/models/AirtableProduct.dart';
import 'package:part_id/models/app.dart';

class PartIDAnalyzeImage extends HookConsumerWidget {
  final XFile? image;
  const PartIDAnalyzeImage({super.key, this.image});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void navigateToProduct(PartIDAirtableProduct product) {}
    void showAlertModal() {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          actionsAlignment: MainAxisAlignment.center,
          title: const Text(
            "No part found",
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
          ),
          content: const Text(
            "We were unable to locate this particular part. Try another image.",
            style: TextStyle(fontSize: 13),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text(
                "Okay",
                style: TextStyle(
                  fontSize: 17,
                  color: Color(0xFF007AFF),
                  fontWeight: FontWeight.w600,
                ),
              ),
            )
          ],
        ),
      );
    }

    void init() async {
      if (image != null) {
        final expires = DateTime(DateTime.now().day + 1);
        final key = await AppUtils.uploadFileToS3(
          file: File(image!.path),
          key: "temp/${image!.name}",
        );
        if (key != null) {
          final product = await AppUtils.analyzeImage(key);
          if (product != null) {
            navigateToProduct(product);
            return;
          }
        }
        showAlertModal();
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
