import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PartIDCamera extends HookConsumerWidget {
  const PartIDCamera({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        toolbarHeight: 148,
        leading: GestureDetector(
          child: Image.asset("assets/images/camera_close.png"),
        ),
      ),
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
