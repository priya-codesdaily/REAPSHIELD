import 'package:flutter/material.dart';

class EvidenceLockerPage extends StatelessWidget {
  const EvidenceLockerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Evidence Locker"),
        backgroundColor: Colors.red,
      ),
      body: const Center(
        child: Text(
          "Your proofs will be stored safely here 🔒",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
