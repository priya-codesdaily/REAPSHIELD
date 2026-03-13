import 'package:flutter/material.dart';

class EvidenceLockerPage extends StatefulWidget {
  const EvidenceLockerPage({super.key});

  @override
  State<EvidenceLockerPage> createState() => _EvidenceLockerPageState();
}

class _EvidenceLockerPageState extends State<EvidenceLockerPage> {

  final TextEditingController noteController = TextEditingController();
  String savedNote = "";

  void saveEvidence() {
    setState(() {
      savedNote = noteController.text;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Evidence Saved Securely")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Evidence Locker"),
        backgroundColor: Colors.blue,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [

            const Icon(
              Icons.lock,
              size: 80,
              color: Colors.blue,
            ),

            const SizedBox(height: 20),

            TextField(
              controller: noteController,
              decoration: const InputDecoration(
                labelText: "Write evidence note",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: saveEvidence,
              child: const Text("Save Evidence"),
            ),

            const SizedBox(height: 30),

            if (savedNote.isNotEmpty)
              Column(
                children: [
                  const Text(
                    "Saved Evidence:",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(savedNote),
                ],
              )

          ],
        ),
      ),
    );
  }
}