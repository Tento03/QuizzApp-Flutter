import 'package:flutter/material.dart';

class Scorepage extends StatefulWidget {
  final String label;
  final int score;

  const Scorepage({super.key, required this.label, required this.score});

  @override
  State<Scorepage> createState() => _ScorepageState();
}

class _ScorepageState extends State<Scorepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Score Page')),
      body: Center(
        child: Card(
          elevation: 4,
          margin: const EdgeInsets.all(24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.label,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(
                  'Score: ${widget.score}',
                  style: const TextStyle(
                    fontSize: 28,
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
