import 'package:flutter/material.dart';

class EvidenceLockerPage extends StatelessWidget {
  const EvidenceLockerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("EVIDENCE LOCKER"), backgroundColor: Colors.transparent),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _vaultItem("AUDIO_REC_001.mp4", "March 27, 2026", "SECURE"),
          _vaultItem("JOURNAL_ENTRY_04.pdf", "March 26, 2026", "HASHED"),
          _vaultItem("IMG_THREAT_DET.jpg", "March 25, 2026", "ENCRYPTED"),
        ],
      ),
    );
  }

  Widget _vaultItem(String name, String date, String status) {
    return Card(
      color: Colors.white10,
      margin: const EdgeInsets.only(bottom: 15),
      child: ListTile(
        leading: const Icon(Icons.insert_drive_file, color: Color(0xFF00FF94)),
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(date),
        trailing: Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(color: Colors.green.withOpacity(0.2), borderRadius: BorderRadius.circular(8)),
          child: Text(status, style: const TextStyle(color: Colors.green, fontSize: 10)),
        ),
      ),
    );
  }
}

  // ignore: unused_element
  Widget _buildEvidenceTile(String title, String date, String hash) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFF0D2B1D), // Dark green vibe for "Safe"
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: const Color(0xFF00FF94).withOpacity(0.2)),
      ),
      child: Row(
        children: [
          const Icon(Icons.verified_user, color: Color(0xFF00FF94)),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              Text(date, style: const TextStyle(color: Colors.white54, fontSize: 12)),
              Text(hash, style: const TextStyle(color: Color(0xFF00FF94), fontSize: 10, fontFamily: 'monospace')),
            ],
          ),
        ],
      ),
    );
  }
