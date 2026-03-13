import 'package:flutter/material.dart';

class MentalSupportPage extends StatelessWidget {
  const MentalSupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mental Support"),
        backgroundColor: Colors.red,
      ),
      body: const Center(
        child: Text(
          "You are safe here.\n\nYou are not alone.\n\nTake a deep breath.",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 22),
        ),
      ),
    );
  }
}