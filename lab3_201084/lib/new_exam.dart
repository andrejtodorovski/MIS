import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lab3_201084/exam.dart';

class NewExam extends StatefulWidget {
  final Function addExam;

  const NewExam({super.key, required this.addExam});

  @override
  State<NewExam> createState() => _NewExamState();
}

class _NewExamState extends State<NewExam> {
  final _subjectController = TextEditingController();
  DateTime? _selectedDate;

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    ).then((pickedDate) {
      if (pickedDate == null) return;
      _presentTimePicker(pickedDate);
    });
  }

  void _presentTimePicker(DateTime pickedDate) {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((pickedTime) {
      if (pickedTime == null) return;
      setState(() {
        _selectedDate = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );
      });
    });
  }

  void _submitData() {
    if (_subjectController.text.isEmpty) {
      return;
    }
    final enteredSubject = _subjectController.text;

    if (enteredSubject.isEmpty) {
      return;
    }

    final newExam = Exam(
      Random().nextInt(1000),
      enteredSubject,
      _selectedDate!,
    );

    widget.addExam(newExam);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(children: [
        const Text("Додај ново полагање",
            style: TextStyle(fontSize: 20, color: Colors.lightBlueAccent)),
        TextField(
          controller: _subjectController,
          decoration: const InputDecoration(
            labelText: "Име на предметот",
            hintText: "Внесете име на предметот",
          ),
          onSubmitted: (_) => _submitData,
        ),
        Row(
          children: <Widget>[
            if (_selectedDate == null)
              const Text(
                'Немате избрано датум и време',
              ),
            if (_selectedDate != null)
              Expanded(
                child: Text(
                  'Избран датум и време: ${_selectedDate!.toLocal()}'.split('.')[0],
                ),
              ),
            TextButton(
              onPressed: _presentDatePicker,
              child: const Text(
                'Одбери датум и време',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        ElevatedButton(
            onPressed: _submitData,
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.blue,
              backgroundColor: Colors.white,
              shadowColor: Colors.grey,
              elevation: 5,
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32.0),
              ),
            ),
            child: const Text("Зачувај"))
      ]),
    );
  }
}
