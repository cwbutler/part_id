import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:part_id/screens/App.dart';

void main() {
  runApp(const ProviderScope(child: PartIDApp()));
}
