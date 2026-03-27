import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:crypto/crypto.dart';

void main() {
  runApp(const RepShieldApp());
}

class RepShieldApp extends StatelessWidget {
  const RepShieldApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: const Color(0xFF0A0A0B)),
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
              const Text("REPSHIELD", style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, letterSpacing: 2)),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(20)),
                child: const Text("● SYSTEM ARMED", style: TextStyle(color: Color(0xFF00FF94), fontSize: 12, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 30),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  children: [
                    _buildCard(context, "Journal", Icons.book, const Color(0xFF1A1A1B), () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const IncidentJournalPage()));
                    }),
                    _buildCard(context, "Vault", Icons.lock, const Color(0xFF0D2B1D), () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const EvidenceLockerPage()));
                    }),
                    _buildStealthCard(),
                    _buildCard(context, "Timer", Icons.timer, const Color(0xFF2E1A1A), () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const SafetyTimerPage()));
                    }),
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

  Widget _buildCard(BuildContext context, String title, IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.white10)),
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
        decoration: BoxDecoration(color: const Color(0xFF161618), borderRadius: BorderRadius.circular(20), border: Border.all(color: const Color(0xFF00F2FF))),
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
            title: const Text("SOS ACTIVATED", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            content: const Text("GPS tracking enabled. Contacts notified.", style: TextStyle(color: Colors.white)),
            actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text("OK", style: TextStyle(color: Colors.white)))]
          ),
        );
      },
      child: Container(
        width: double.infinity,
        height: 80,
        decoration: BoxDecoration(color: Colors.redAccent, borderRadius: BorderRadius.circular(25)),
        child: const Center(child: Text("S O S", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: Colors.white))),
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
  final TextEditingController _c = TextEditingController();
  String hash = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("JOURNAL")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(children: [
          TextField(controller: _c, maxLines: 3, decoration: const InputDecoration(hintText: "Enter incident...")),
          const SizedBox(height: 20),
          ElevatedButton(onPressed: () {
            setState(() { hash = sha256.convert(utf8.encode(_c.text + DateTime.now().toString())).toString(); });
          }, child: const Text("SEAL EVIDENCE")),
          if (hash.isNotEmpty) SelectableText("\nSeal: $hash", style: const TextStyle(fontSize: 10, color: Colors.green)),
        ]),
      ),
    );
  }
}

class EvidenceLockerPage extends StatelessWidget {
  const EvidenceLockerPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("VAULT")),
      body: const Center(child: Text("Evidence Locker Secure", style: TextStyle(color: Colors.white54))),
    );
  }
}

class SafetyTimerPage extends StatefulWidget {
  const SafetyTimerPage({super.key});
  @override
  State<SafetyTimerPage> createState() => _SafetyTimerPageState();
}

class _SafetyTimerPageState extends State<SafetyTimerPage> {
  int _s = 600;
  Timer? _t;
  @override
  void dispose() { _t?.cancel(); super.dispose(); }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("TIMER")),
      body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text("${(_s ~/ 60)}:${(_s % 60).toString().padLeft(2, '0')}", style: const TextStyle(fontSize: 80, color: Colors.red)),
        ElevatedButton(onPressed: () {
          _t = Timer.periodic(const Duration(seconds: 1), (t) { if (_s > 0) setState(() => _s--); });
        }, child: const Text("START")),
      ])),
    );
  }
}