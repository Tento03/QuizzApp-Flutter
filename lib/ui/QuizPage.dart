import 'package:flutter/material.dart';
import 'package:quizzapp/ui/QuizCard.dart';

class Quizpage extends StatefulWidget {
  final String label;

  const Quizpage({super.key, required this.label});

  @override
  State<Quizpage> createState() => _QuizpageState();
}

class _QuizpageState extends State<Quizpage> {
  final amountController = TextEditingController();
  String selectedDiff = 'Easy';
  String selectedType = "Multiple Choice";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Quiz Page",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.yellow,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Category: ${widget.label}",
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 32),
              Text(
                "Question Amout",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              TextField(
                controller: amountController,
                decoration: InputDecoration(label: Text("Amount Question")),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 32),
              Divider(thickness: 1.2),
              const Text(
                "Choose Difficulty",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 12),
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: selectedDiff,
                    icon: const Icon(Icons.arrow_drop_down),
                    underline: const SizedBox(),
                    items:
                        ["Any Difficulty", "Easy", "Medium", "Hard"]
                            .map(
                              (diff) => DropdownMenuItem<String>(
                                value: diff,
                                child: Text(diff),
                              ),
                            )
                            .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedDiff = value!;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(height: 32),
              Divider(thickness: 1.2),
              SizedBox(height: 32),
              Text(
                "Choose Type",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 12),
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: DropdownButton<String>(
                    value: selectedType,
                    isExpanded: true,
                    icon: Icon(Icons.arrow_drop_down),
                    underline: SizedBox(),
                    items:
                        ["Any Type", "Multiple Choice", "True / False"]
                            .map(
                              (type) => DropdownMenuItem<String>(
                                child: Text(type),
                                value: type,
                              ),
                            )
                            .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedType = value!;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Center(
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => QuestionCard(
                              amount: int.parse(amountController.text),
                              diff: selectedDiff,
                              type: selectedType,
                              category: widget.label,
                            ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.play_arrow),
                  label: const Text("Start Quiz"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow[700],
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 14,
                    ),
                    textStyle: const TextStyle(fontSize: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
