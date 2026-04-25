import 'dart:async';
import 'package:flutter/material.dart';

class SafetyTimerPage extends StatefulWidget {
  const SafetyTimerPage({super.key});
  @override
  State<SafetyTimerPage> createState() => _SafetyTimerPageState();
}

class _SafetyTimerPageState extends State<SafetyTimerPage> {
  int _seconds = 600;
  Timer? _timer;
  bool _isRunning = false;

  void _startTimer() {
    setState(() => _isRunning = true);
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (_seconds == 0) {
        t.cancel();
        setState(() => _isRunning = false);
        _onTimerEnd();
      } else {
        setState(() => _seconds--);
      }
    });
  }

  void _stopTimer() {
    _timer?.cancel();
    setState(() {
      _isRunning = false;
      _seconds = 600;
    });
  }

  void _onTimerEnd() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: const Color(0xFF1A1A1A),
        title: const Text("TIME UP!", style: TextStyle(color: Colors.red)),
        content: const Text("No check-in!", style: TextStyle(color: Colors.white)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("I AM SAFE", style: TextStyle(color: Colors.green)),
          ),
        ],
      ),
    );
  }

  String _formatTime() {
    int min = _seconds ~/ 60;
    int sec = _seconds % 60;
    return "${min.toString().padLeft(2, '0')}:${sec.toString().padLeft(2, '0')}";
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0B),
      appBar: AppBar(
        title: const Text("SAFETY TIMER"),
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: _isRunning ? Colors.red : Colors.white24,
                  width: 4,
                ),
              ),
              child: Center(
                child: Text(
                  _formatTime(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 52,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              _isRunning ? "TIMER RUNNING" : "TIMER READY",
              style: TextStyle(
                color: _isRunning ? Colors.green : Colors.grey,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 50),
            if (!_isRunning)
              ElevatedButton(
                onPressed: _startTimer,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 60, vertical: 18),
                ),
                child: const Text("START",
                    style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold)),
              ),
            if (_isRunning)
              ElevatedButton(
                onPressed: _stopTimer,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 60, vertical: 18),
                ),
                child: const Text("STOP",
                    style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold)),
              ),
            const SizedBox(height: 20),
            if (_isRunning)
              TextButton(
                onPressed: _stopTimer,
                child: const Text(
                  "I AM SAFE - Cancel Timer",
                  style: TextStyle(color: Colors.green, fontSize: 14),
                ),
              ),
          ],
        ),
      ),
    );
  }
}