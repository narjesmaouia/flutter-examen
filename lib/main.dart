import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "ANALYSE VOYELLE",
      home: AverageCalculator(),
    );
  }
}

class AverageCalculator extends StatefulWidget {
  const AverageCalculator({Key? key}) : super(key: key);

  @override
  State createState() => _AverageCalculatorState();
}

class _AverageCalculatorState extends State<AverageCalculator> {
  final _wordController = TextEditingController();
  late int _vowelCount;
  late int _consonantCount;
  Map<String, int> _vowelCounts = {
    'a': 0,
    'e': 0,
    'i': 0,
    'o': 0,
    'u': 0,
    'y': 0,
  };

  Color getBackgroundColor(String vowel) {
    switch (vowel.toLowerCase()) {
      case 'a':
        return Colors.red[100]!;
      case 'e':
        return Colors.green[100]!;
      case 'i':
        return Colors.blue[100]!;
      case 'o':
        return Colors.orange[100]!;
      case 'u':
        return Colors.purple[100]!;
      case 'y':
        return Colors.yellow[100]!;
      default:
        return Colors.grey[100]!;
    }
  }

  void _clearFields() {
    setState(() {
      _wordController.clear();
      _vowelCount = 0;
      _consonantCount = 0;
      _vowelCounts = {
        'a': 0,
        'e': 0,
        'i': 0,
        'o': 0,
        'u': 0,
        'y': 0,
      };
    });
  }

  void _analyzeWord() {
    String word = _wordController.text.toLowerCase();
    int vowelCount = 0;
    int consonantCount = 0;

    for (int i = 0; i < word.length; i++) {
      if ('aeiouy'.contains(word[i])) {
        vowelCount++;
        _vowelCounts[word[i]] = (_vowelCounts[word[i]] ?? 0) + 1;
      } else if (word[i].trim().isNotEmpty) {
        consonantCount++;
      }
    }

    setState(() {
      _vowelCount = vowelCount;
      _consonantCount = consonantCount;
    });
  }

  @override
  void initState() {
    super.initState();
    _vowelCount = 0;
    _consonantCount = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.time_to_leave),
        title: Center(
          child: const Text(
            "ANALYSE VOYELLE",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
          ),
        ),
        actions: [
          IconButton(
            onPressed: _clearFields,
            icon: const Icon(
              Icons.clear,
              color: Colors.red,
            ),
          ),
        ],
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            TextField(
              controller: _wordController,
              decoration: InputDecoration(
                labelText: "Entrer un mot",
                hintText: "Mot",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _analyzeWord();
              },
              child: const Text('ANALYSER'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                textStyle: TextStyle(color: Colors.white),
              ),
            ),
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.yellow,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 6.0, horizontal: 10),
                    child: Text('Consonnes: $_consonantCount occurrences'),
                    width: 690,
                  ),
                  SizedBox(height: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: _vowelCounts.entries.map((entry) {
                      String vowel = entry.key;
                      int count = entry.value;
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 6.0, horizontal: 4.0),
                        child: Container(
                          width: 690,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey),
                            color: getBackgroundColor(vowel),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '${vowel.toUpperCase()}: $count occurrences',
                              style: TextStyle(
                                fontFamily: 'Courgette',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
