import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> predmeti = [
    "Мобилни информациски системи",
    "Веб базирани системи",
    "Менаџмент информациски системи",
    "Имплементација на софтвер",
    "Тимски проект"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Андреј Тодоровски 201084'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 50, 102, 145),
              Color.fromARGB(255, 87, 41, 174)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: predmeti.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.all(8.0),
                    color: Colors.transparent,
                    child: ListTile(
                      title: Text(
                        predmeti[index],
                        style:
                            const TextStyle(fontSize: 15, color: Colors.white),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.white),
                        onPressed: () {
                          setState(() {
                            predmeti.removeAt(index);
                          });
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showDialog,
        tooltip: 'Додади нов предмет',
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String novPredmet = "";
        return AlertDialog(
          title: const Text('Додади нов предмет'),
          content: TextField(
            decoration: const InputDecoration(hintText: "Име на предметот"),
            onChanged: (value) {
              novPredmet = value;
            },
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Откажи'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: const Text('Додади'),
              onPressed: () {
                if (novPredmet.isNotEmpty) {
                  setState(() {
                    predmeti.add(novPredmet);
                  });
                  Navigator.pop(context);
                }
              },
            ),
          ],
        );
      },
    );
  }
}
