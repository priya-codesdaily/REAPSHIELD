import 'package:flutter/material.dart';

class MentalSupportPage extends StatelessWidget {
  const MentalSupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mental Support"),
      ),
      body: const Center(
        child: Text(
          "You are not alone. Help is always available.",
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}