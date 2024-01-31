import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lab3_201084/calendar_page.dart';
import 'package:lab3_201084/exam.dart';
import 'package:lab3_201084/login_page.dart';
import 'package:lab3_201084/new_exam.dart';

class HomePage extends StatefulWidget {
  static const String id = "mainPage";

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  String? errorMessage = '';

  final List<Exam> _exams = [
    Exam(1, "МИС", DateTime.now()),
    Exam(2, "ВБС", DateTime.now().add(const Duration(days: 1))),
    Exam(3, "АПС", DateTime.now().add(const Duration(days: 2))),
    Exam(4, "ВИС", DateTime.now().add(const Duration(days: 2))),
    Exam(5, "ВНП", DateTime.now()),
  ];

  Future _signOut() async {
    try {
      await FirebaseAuth.instance.signOut().then((value) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const HomePage()));
      });
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  void _addExamFunction() {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            behavior: HitTestBehavior.opaque,
            child: NewExam(addExam: _addExam),
          );
        });
  }

  void _addExam(Exam exam) {
    setState(() {
      _exams.add(exam);
    });
  }

  @override
  Widget build(BuildContext context) {
    var isSignedIn = FirebaseAuth.instance.currentUser != null;
    return Scaffold(
      appBar: AppBar(title: const Text('Термини'), actions: [
        IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CalendarPage(
                            exams: _exams,
                          )));
            },
            icon: const Icon(Icons.calendar_today)),
        if (isSignedIn) ...[
          IconButton(
            icon: const Icon(Icons.add_box),
            onPressed: _addExamFunction,
          ),
          ElevatedButton(
            onPressed: _signOut,
            child: const Text("Одјави се"),
          )
        ] else ...[
          ElevatedButton(
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const LoginPage()));
            },
            child: const Text("Најави се"),
          ),
        ]
      ]),
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: _exams.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 2,
          mainAxisSpacing: 2,
          childAspectRatio: 3 / 2,
        ),
        itemBuilder: (ctx, index) {
          return Card(
            elevation: 5,
            child: Container(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _exams[index].subject,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    '${_exams[index].date.toLocal()}'.split('.')[0],
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
