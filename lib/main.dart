import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'safety_timer.dart';

void main() {
  runApp(const RepShieldApp());
}

class RepShieldApp extends StatelessWidget {
  const RepShieldApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0A0A0B),
      ),
      home: const DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool isStealth = false;

  @override
  Widget build(BuildContext context) {
    if (isStealth) {
      return GestureDetector(
        onLongPress: () => setState(() => isStealth = false),
        child: const Scaffold(backgroundColor: Colors.black),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "REPSHIELD",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  "● SYSTEM ARMED",
                  style: TextStyle(
                    color: Color(0xFF00FF94),
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  children: [
                    _buildCard(
                      context,
                      "Journal",
                      Icons.book,
                      const Color(0xFF1A1A1B),
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const IncidentJournalPage(),
                        ),
                      ),
                    ),
                    _buildCard(
                      context,
                      "Vault",
                      Icons.lock,
                      const Color(0xFF0D2B1D),
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const EvidenceLockerPage(),
                        ),
                      ),
                    ),
                    _buildStealthCard(),
                    _buildCard(
                      context,
                      "Timer",
                      Icons.timer,
                      const Color(0xFF2E1A1A),
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SafetyTimerPage(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              _buildSOSButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, String title, IconData icon,
      Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 30),
            const SizedBox(height: 10),
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildStealthCard() {
    return GestureDetector(
      onTap: () => setState(() => isStealth = true),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF161618),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFF00F2FF)),
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.visibility_off, color: Color(0xFF00F2FF), size: 30),
            SizedBox(height: 10),
            Text("Stealth Mode", style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildSOSButton() {
    return GestureDetector(
      onLongPress: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: Colors.red,
            title: const Text(
              "SOS ACTIVATED",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            content: const Text(
              "GPS tracking enabled. Contacts notified.",
              style: TextStyle(color: Colors.white),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("OK", style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        );
      },
      child: Container(
        width: double.infinity,
        height: 80,
        decoration: BoxDecoration(
          color: Colors.redAccent,
          borderRadius: BorderRadius.circular(25),
        ),
        child: const Center(
          child: Text(
            "S O S",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

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
      appBar: AppBar(
        title: const Text("FORENSIC JOURNAL"),
        backgroundColor: Colors.transparent,
      ),
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
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _generateSeal,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00F2FF),
              ),
              child: const Text(
                "SEAL EVIDENCE",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            if (forensicHash.isNotEmpty) ...[
              const SizedBox(height: 30),
              const Text(
                "DIGITAL SEAL (SHA-256):",
                style: TextStyle(color: Color(0xFF00FF94), fontSize: 12),
              ),
              SelectableText(
                forensicHash,
                style: const TextStyle(
                  color: Colors.white54,
                  fontSize: 10,
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class EvidenceLockerPage extends StatelessWidget {
  const EvidenceLockerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0B),
      appBar: AppBar(
        title: const Text("EVIDENCE LOCKER"),
        backgroundColor: Colors.transparent,
      ),
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
          decoration: BoxDecoration(
            color: Colors.green.withOpacity(0.2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            status,
            style: const TextStyle(color: Colors.green, fontSize: 10),
          ),
        ),
      ),
    );
  }
}