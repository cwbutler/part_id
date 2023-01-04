import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PartIDAnalyzeImage extends HookConsumerWidget {
  const PartIDAnalyzeImage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
