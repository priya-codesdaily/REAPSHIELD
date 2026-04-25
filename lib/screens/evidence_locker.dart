import 'package:flutter/material.dart';

class EvidenceLockerPage extends StatelessWidget {
  const EvidenceLockerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0B),
      appBar: AppBar(
        title: const Text('EVIDENCE LOCKER'),
        backgroundColor: Colors.transparent,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _vaultItem('AUDIO_REC_001.mp4', 'March 27, 2026', 'SECURE'),
          _vaultItem('JOURNAL_ENTRY_04.pdf', 'March 26, 2026', 'HASHED'),
          _vaultItem('IMG_THREAT_DET.jpg', 'March 25, 2026', 'ENCRYPTED'),
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
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(status, style: const TextStyle(color: Colors.white, fontSize: 10)),
        ),
      ),
    );
  }
}
