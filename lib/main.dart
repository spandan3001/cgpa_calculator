import 'package:flutter/material.dart';

void main() {
  runApp(const SgpaApp());
}

class SgpaApp extends StatelessWidget {
  const SgpaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SGPA Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SGPAHomePage(),
    );
  }
}

class SGPAHomePage extends StatefulWidget {
  @override
  _SGPAHomePageState createState() => _SGPAHomePageState();
}

class _SGPAHomePageState extends State<SGPAHomePage> {
  final List<double> _subjectCredits = [];
  final List<double> _subjectGrades = [];
  double _sgpa = 0.0;

  void _addSubject() {
    setState(() {
      _subjectCredits.add(0.0);
      _subjectGrades.add(0.0);
    });
  }

  void _removeSubject(int index) {
    setState(() {
      _subjectCredits.removeAt(index);
      _subjectGrades.removeAt(index);
    });
  }

  void _calculateSGPA() {
    double totalCredits = 0.0;
    double totalGradePoints = 0.0;

    for (int i = 0; i < _subjectCredits.length; i++) {
      double credit = _subjectCredits[i];
      double grade = _subjectGrades[i];
      totalCredits += credit;
      totalGradePoints += (credit * grade);
    }

    if (totalCredits > 0) {
      _sgpa = totalGradePoints / totalCredits;
    } else {
      _sgpa = 0.0;
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('SGPA Calculation'),
          content: Text('Your SGPA: $_sgpa'),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SGPA Calculator'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _subjectCredits.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Subject ${index + 1}'),
                  subtitle: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'Credits',
                          ),
                          onChanged: (value) {
                            setState(() {
                              _subjectCredits[index] = double.parse(value);
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      Expanded(
                        child: TextField(
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'Grade',
                          ),
                          onChanged: (value) {
                            setState(() {
                              _subjectGrades[index] = double.parse(value);
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () {
                      _removeSubject(index);
                    },
                  ),
                );
              },
            ),
          ),
          TextButton(onPressed: _addSubject, child: const Text('Add Subject')),
          const SizedBox(height: 16.0),
          TextButton(
              onPressed: _calculateSGPA, child: const Text('Calculate SGPA')),
        ],
      ),
    );
  }
}
