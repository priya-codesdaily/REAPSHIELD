import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart'; // This is for the hashing

class IncidentJournalPage extends StatefulWidget {
  const IncidentJournalPage({super.key});

  @override
  State<IncidentJournalPage> createState() => _IncidentJournalPageState();
}

class _IncidentJournalPageState extends State<IncidentJournalPage> {
  final TextEditingController _controller = TextEditingController();
  String forensicHash = "";

  void _generateSeal() {
    if (_controller.text.isEmpty) return;
    
    // Create the digital fingerprint
    var bytes = utf8.encode(_controller.text + DateTime.now().toString()); 
    var digest = sha256.convert(bytes);

    setState(() {
      forensicHash = digest.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0B),
      appBar: AppBar(title: const Text("FORENSIC JOURNAL"), backgroundColor: Colors.transparent),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              maxLines: 5,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Describe the incident...",
                hintStyle: const TextStyle(color: Colors.white24),
                filled: true,
                fillColor: Colors.white10,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _generateSeal,
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF00F2FF)),
              child: const Text("SEAL EVIDENCE", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
            ),
            if (forensicHash.isNotEmpty) ...[
              const SizedBox(height: 30),
              const Text("DIGITAL SEAL (SHA-256):", style: TextStyle(color: Color(0xFF00FF94), fontSize: 12)),
              SelectableText(
                forensicHash,
                style: const TextStyle(color: Colors.white54, fontSize: 10, fontFamily: 'monospace'),
              ),
            ]
          ],
        ),
      ),
    );
  }
}