import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'dart:math';
import 'screens/safety_timer.dart';
import 'screens/evidence_locker.dart';
import 'screens/incident_journal.dart';

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
  bool _sosTriggered = false;

  @override
  void initState() {
    super.initState();
    _listenForShake();
  }

  void _listenForShake() {
    accelerometerEventStream().listen((AccelerometerEvent event) {
      double magnitude = sqrt(
        event.x * event.x +
        event.y * event.y +
        event.z * event.z
      );
      if (magnitude > 25 && !_sosTriggered) {
        _sosTriggered = true;
        // Show snackbar so user knows shake was detected
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("🚨 Shake detected! Sending SOS..."),
              backgroundColor: Colors.red,
              duration: Duration(seconds: 3),
            ),
          );
        }
        _sendSOS();
        // Reset after 10 seconds
        Future.delayed(const Duration(seconds: 10), () {
          if (mounted) setState(() => _sosTriggered = false);
        });
      }
    });
  }

  // ✅ GET LOCATION
  Future<Position> _getLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  // ✅ SEND SOS SMS
  Future<void> _sendSOS() async {
    try {
      final position = await _getLocation();
      String message =
          "🚨 EMERGENCY! I need help immediately!\nMy location: https://maps.google.com/?q=${position.latitude},${position.longitude}";
      final Uri smsUri = Uri.parse(
          "sms:+916370740383?body=${Uri.encodeComponent(message)}");
      if (await canLaunchUrl(smsUri)) {
        await launchUrl(smsUri);
      }
    } catch (e) {
      final Uri smsUri = Uri.parse(
          "sms:+916370740383?body=${Uri.encodeComponent('🚨 EMERGENCY! I need help immediately!')}");
      if (await canLaunchUrl(smsUri)) {
        await launchUrl(smsUri);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isStealth) {
      SystemChrome.setEnabledSystemUIMode(
        SystemUiMode.manual,
        overlays: [],
      );
      return GestureDetector(
        onLongPress: () {
          SystemChrome.setEnabledSystemUIMode(
            SystemUiMode.manual,
            overlays: SystemUiOverlay.values,
          );
          setState(() => isStealth = false);
        },
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
              const Text("REPSHIELD",
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 2)),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                    color: Colors.white10,
                    borderRadius: BorderRadius.circular(20)),
                child: const Text("● SYSTEM ARMED",
                    style: TextStyle(
                        color: Color(0xFF00FF94),
                        fontSize: 12,
                        fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 8),
              // Shake hint
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                    color: Colors.white10,
                    borderRadius: BorderRadius.circular(20)),
                child: const Text("📳 Shake phone to trigger SOS",
                    style: TextStyle(
                        color: Color(0xFFFFD700),
                        fontSize: 11)),
              ),
              const SizedBox(height: 30),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  children: [
                    _buildCard(context, "Journal", Icons.book,
                        const Color(0xFF1A1A1B), () {
                      Navigator.push(context,
                          MaterialPageRoute(
                              builder: (_) => IncidentJournalPage()));
                    }),
                    _buildCard(context, "Vault", Icons.lock,
                        const Color(0xFF0D2B1D), () {
                      Navigator.push(context,
                          MaterialPageRoute(
                              builder: (_) => EvidenceLockerPage()));
                    }),
                    _buildStealthCard(),
                    _buildCard(context, "Timer", Icons.timer,
                        const Color(0xFF2E1A1A), () {
                      Navigator.push(context,
                          MaterialPageRoute(
                              builder: (_) => SafetyTimerPage()));
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

  Widget _buildCard(BuildContext context, String title, IconData icon,
      Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 24),
            const SizedBox(height: 6),
            Text(title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 12)),
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
            border: Border.all(color: const Color(0xFF00F2FF))),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.visibility_off,
                color: Color(0xFF00F2FF), size: 24),
            SizedBox(height: 6),
            Text("Stealth Mode",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Widget _buildSOSButton() {
    return GestureDetector(
      onLongPress: () async {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => const AlertDialog(
            backgroundColor: Color(0xFF1A1A1A),
            content: Row(
              children: [
                CircularProgressIndicator(color: Colors.red),
                SizedBox(width: 20),
                Text("Getting location...",
                    style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
        );
        await _sendSOS();
        if (context.mounted) Navigator.pop(context);
      },
      child: Container(
        width: double.infinity,
        height: 80,
        decoration: BoxDecoration(
            color: Colors.redAccent,
            borderRadius: BorderRadius.circular(25)),
        child: const Center(
          child: Text("S O S",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  color: Colors.white)),
        ),
      ),
    );
  }
}