import 'package:flutter/material.dart';

class PartIDFormInput extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? label;
  final String? Function(String?)? validator;
  final bool? obscureText;

  const PartIDFormInput({
    super.key,
    this.controller,
    this.keyboardType,
    this.label,
    this.validator,
    this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      obscureText: obscureText ?? false,
      decoration: InputDecoration(
        label: Text(label ?? "", style: const TextStyle(fontSize: 16)),
        contentPadding: const EdgeInsets.all(20),
        border: const OutlineInputBorder(
          borderSide: BorderSide(width: 2),
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 2,
            color: Theme.of(context).primaryColor,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
      ),
      validator: validator,
    );
  }
}
