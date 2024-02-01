import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import 'exam.dart';

class CalendarPage extends StatefulWidget {
  static const String id = "calendarPage";
  final List<Exam> exams;

  const CalendarPage({super.key, required this.exams});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  late Map<DateTime, List<Exam>> _events;
  late CalendarFormat _calendarFormat;
  late DateTime _focusedDay;
  late DateTime _selectedDay;
  late List<Exam> _selectedExams;

  @override
  void initState() {
    super.initState();
    _calendarFormat = CalendarFormat.month;
    _focusedDay = DateTime.now();
    _selectedDay =
        DateTime(_focusedDay.year, _focusedDay.month, _focusedDay.day);
    _events = {};

    _selectedExams = [];

    for (var exam in widget.exams) {
      final date = DateTime(exam.date.year, exam.date.month, exam.date.day);
      if (_events[date] == null) _events[date] = [];
      _events[date]!.add(exam);
    }

    _selectedExams = _events[_selectedDay] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Календар'),
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2024, 1, 1),
            lastDay: DateTime.utc(2024, 12, 31),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = DateTime(
                    selectedDay.year, selectedDay.month, selectedDay.day);
                _focusedDay = focusedDay;
                _selectedExams = _events[_selectedDay] ?? [];
              });
            },
            eventLoader: (day) => _events[day] ?? [],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _selectedExams.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_selectedExams[index].subject),
                  subtitle:
                  Text(_selectedExams[index].date.toString().split(".")[0]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
