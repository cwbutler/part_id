import 'package:flutter/material.dart';

class PartIDButton extends StatelessWidget {
  final void Function()? onPressed;
  final Widget? child;

  const PartIDButton({
    super.key,
    this.onPressed,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(17),
          backgroundColor: Theme.of(context).primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: child,
      ),
    );
  }
}
