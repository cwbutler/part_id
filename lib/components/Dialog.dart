import 'package:flutter/material.dart';

class PartIDDialog extends StatelessWidget {
  final Widget? child;

  const PartIDDialog({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      content: Container(
        width: 640,
        height: 561,
        padding: const EdgeInsets.all(20),
        child: child,
      ),
    );
  }
}
