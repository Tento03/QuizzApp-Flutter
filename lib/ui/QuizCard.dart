import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quizzapp/model/quiz.dart';
import 'package:quizzapp/ui/ScorePage.dart';

class QuestionCard extends StatefulWidget {
  final int amount;
  final String diff;
  final String type;
  final String category;

  const QuestionCard({
    super.key,
    required this.amount,
    required this.diff,
    required this.type,
    required this.category,
  });

  @override
  State<QuestionCard> createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
  List<Results> results = [];
  bool isLoading = true;

  final Map<int, List<String>> selectedMultipleAnswers = {};
  final Map<int, String> selectedBooleanAnswers = {};

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    setState(() {
      isLoading = true;
    });

    final amount = widget.amount;
    final diff = widget.diff.toLowerCase();
    final type = widget.type == 'Multiple Choice' ? 'multiple' : 'boolean';
    const Map<String, int> categoryMap = {
      "General Knowledge": 9,
      "Science Nature": 17,
      "Art": 25,
      "Animals": 27,
      "Vehicles": 28,
      "Mythology": 20,
      "Sports": 21,
      "Technology": 18,
    };

    final categoryId = categoryMap[widget.category] ?? 9;

    var uri = Uri.parse(
      'https://opentdb.com/api.php?amount=$amount&category=$categoryId&difficulty=$diff&type=$type',
    );
    var response = await http.get(uri);

    if (response.statusCode == 200) {
      final responseMap = json.decode(response.body);
      setState(() {
        final List responseFinal = responseMap['results'];
        results = responseFinal.map((e) => Results.fromJson(e)).toList();
        isLoading = false;
      });
    } else {
      setState(() {
        results = [];
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Question Page")),
      body:
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: results.length,
                itemBuilder: (context, index) {
                  final q = results[index];
                  final options = [
                    ...q.incorrectAnswers ?? [],
                    q.correctAnswer ?? '',
                  ]..shuffle();

                  if (q.type == 'multiple') {
                    List<bool> selected = List.generate(
                      options.length,
                      (int i) =>
                          selectedMultipleAnswers[index]?.contains(
                            options[i],
                          ) ??
                          false,
                    );

                    return StatefulBuilder(
                      builder: (context, setInnerState) {
                        return Card(
                          margin: const EdgeInsets.only(bottom: 12),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  q.question ?? 'Null',
                                  style: const TextStyle(fontSize: 16),
                                ),
                                const SizedBox(height: 8),
                                ...List.generate(options.length, (i) {
                                  return CheckboxListTile(
                                    title: Text(options[i]),
                                    value: selected[i],
                                    onChanged: (value) {
                                      setInnerState(() {
                                        selected[i] = value!;
                                        selectedMultipleAnswers[index] = [];
                                        for (
                                          int j = 0;
                                          j < selected.length;
                                          j++
                                        ) {
                                          if (selected[j]) {
                                            selectedMultipleAnswers[index]!.add(
                                              options[j],
                                            );
                                          }
                                        }
                                      });
                                    },
                                  );
                                }),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    String? selectedAnswer = selectedBooleanAnswers[index];

                    return StatefulBuilder(
                      builder: (context, setInnerState) {
                        return Card(
                          margin: const EdgeInsets.only(bottom: 12),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  q.question ?? 'Null',
                                  style: const TextStyle(fontSize: 16),
                                ),
                                const SizedBox(height: 8),
                                RadioListTile<String>(
                                  title: const Text('True'),
                                  value: 'True',
                                  groupValue: selectedAnswer,
                                  onChanged: (value) {
                                    setInnerState(() {
                                      selectedAnswer = value;
                                      selectedBooleanAnswers[index] = value!;
                                    });
                                  },
                                ),
                                RadioListTile<String>(
                                  title: const Text('False'),
                                  value: 'False',
                                  groupValue: selectedAnswer,
                                  onChanged: (value) {
                                    setInnerState(() {
                                      selectedAnswer = value;
                                      selectedBooleanAnswers[index] = value!;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          int correct = 0;
          int total = results.length;

          for (int i = 0; i < results.length; i++) {
            final r = results[i];
            final correctAnswer = r.correctAnswer;

            if (r.type == 'multiple') {
              final userAnswers = selectedMultipleAnswers[i] ?? [];
              if (userAnswers.length == 1 && userAnswers[0] == correctAnswer) {
                correct++;
              }
            } else {
              final userAnswer = selectedBooleanAnswers[i];
              if (userAnswer == correctAnswer) {
                correct++;
              }
            }
          }

          showDialog(
            context: context,
            builder:
                (_) => AlertDialog(
                  title: const Text("Hasil Kuis"),
                  content: Text(
                    "Benar: $correct\nSalah: ${total - correct}\nTotal: $total",
                  ),
                  actions: [
                    TextButton(
                      onPressed:
                          () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Scorepage(),
                            ),
                          ),
                      child: const Text("OK"),
                    ),
                  ],
                ),
          );
        },
        label: const Text("Selesai"),
        icon: const Icon(Icons.check),
      ),
    );
  }
}
