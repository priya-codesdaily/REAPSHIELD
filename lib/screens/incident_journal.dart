import 'package:flutter/material.dart';

class IncidentJournalPage extends StatelessWidget {
  const IncidentJournalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Incident Journal"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              "Write your incident safely 📝",
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),

            TextField(
              maxLines: 8,
              decoration: InputDecoration(
                hintText: "Describe what happened...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Incident saved (demo)"),
                  ),
                );
              },
              child: const Text("Save Incident"),
            ),
          ],
        ),
      ),
    );
  }
}