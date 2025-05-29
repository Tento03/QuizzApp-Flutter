import 'package:flutter/material.dart';
import 'package:quizzapp/ui/QuizPage.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Welcome to Quiz App",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.yellowAccent,
        leading: const Icon(Icons.quiz, size: 30, color: Colors.black),
        centerTitle: true,
        elevation: 3,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Choose The Topic",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _buildTopicButton("General Knowledge", Icons.lightbulb_outline),
                _buildTopicButton("Science Nature", Icons.science_outlined),
                _buildTopicButton("Art", Icons.brush_outlined),
                _buildTopicButton("Animals", Icons.pets_outlined),
                _buildTopicButton("Vehicles", Icons.directions_car_outlined),
                _buildTopicButton("Mythology", Icons.auto_awesome_outlined),
                _buildTopicButton("Sports", Icons.sports_soccer_outlined),
                _buildTopicButton("Technology", Icons.memory_outlined),
              ],
            ),
            const SizedBox(height: 30),
            const Divider(thickness: 1.2),
            const SizedBox(height: 20),
            const Text(
              "Recent Scores",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildScoreCard("General Knowledge", 80),
            _buildScoreCard("Science Nature", 65),
            const SizedBox(height: 30),
            const Divider(thickness: 1.2),
            const SizedBox(height: 20),
            const Text(
              "Top Leaderboard",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildLeaderboardItem("Alice", 950),
            _buildLeaderboardItem("Bob", 910),
            _buildLeaderboardItem("Charlie", 890),
            const SizedBox(height: 30),
            Center(
              child: Text(
                "📚 Keep Learning, Keep Growing!",
                style: TextStyle(fontStyle: FontStyle.italic, fontSize: 16),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildTopicButton(String label, IconData icon) {
    return OutlinedButton.icon(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Quizpage(label: label)),
        );
      },
      icon: Icon(icon),
      label: Text(label),
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        textStyle: const TextStyle(fontSize: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  Widget _buildScoreCard(String topic, int score) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(Icons.star, color: Colors.orange),
        title: Text(topic),
        trailing: Text(
          "$score / 100",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildLeaderboardItem(String name, int score) {
    return ListTile(
      leading: Icon(Icons.emoji_events, color: Colors.amber),
      title: Text(name),
      trailing: Text(
        "$score pts",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}
