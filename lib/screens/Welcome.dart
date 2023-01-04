import 'package:flutter/material.dart';
import 'package:part_id/components/Button.dart';
import 'package:part_id/screens/Login.dart';

class PartIDWelcome extends StatelessWidget {
  const PartIDWelcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SizedBox(
          width: 550,
          height: 734,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 40),
                child: const SizedBox(
                  width: 470,
                  height: 288,
                  child: AspectRatio(
                    aspectRatio: 16 / 9, //aspect ratio for Image
                    child: Image(
                      image: AssetImage('assets/images/scan.gif'),
                      fit: BoxFit.fill, //fill type of image inside aspectRatio
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: const Text(
                  "SEC PartID Scan",
                  style: TextStyle(
                    fontSize: 64,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const Text(
                "Identify unlabeled or mislabeled parts",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Color(0xffA09BA3),
                ),
              ),
              const Spacer(),
              PartIDButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const PartIDLogin();
                    },
                  );
                },
                child: const Text(
                  "Log In",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
