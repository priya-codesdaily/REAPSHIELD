import 'package:flutter/material.dart';

void main() {
  runApp(const RepShieldApp());
}

class RepShieldApp extends StatelessWidget {
  const RepShieldApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'REPSHIELD',
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],

      appBar: AppBar(
        title: const Text("REPSHIELD"),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),

      body: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            padding: const EdgeInsets.symmetric(
              horizontal: 60,
              vertical: 30,
            ),
          ),

          onPressed: () {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text("🚨 Emergency Activated"),
      content: const Text(
        "Help request is ready to send.",
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            print("Help message sent");
          },
          child: const Text("Send Alert"),
        ),
      ],
    ),
  );
},

          child: const Text(
            "EMERGENCY",
            style: TextStyle(
              fontSize: 24,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}