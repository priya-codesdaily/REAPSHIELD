import 'package:flutter/material.dart';

class AwarenessHubPage extends StatelessWidget {
  const AwarenessHubPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Awareness Hub"),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "Safety Awareness 📚",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 20),

            Text("• Save screenshots of suspicious messages"),

            SizedBox(height: 10),

            Text("• Never share personal information with strangers"),

            SizedBox(height: 10),

            Text("• Report harassment or threats immediately"),
          ],
        ),
      ),
    );
  }
}