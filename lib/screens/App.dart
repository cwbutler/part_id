import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:part_id/screens/Landing.dart';

class PartIDApp extends StatelessWidget {
  const PartIDApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark),
    );

    return MaterialApp(
      title: 'SEC PartID',
      theme: ThemeData(
        primaryColor: const Color(0xff121B74),
      ),
      home: const PartIDAppLanding(),
      debugShowCheckedModeBanner: false,
    );
  }
}
