import 'package:flutter/material.dart';

class MentalSupportPage extends StatelessWidget {
  const MentalSupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mental Support"),
        backgroundColor: Colors.green,
      ),
      body: const Center(
        child: Text(
          "You are not alone ❤️",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}