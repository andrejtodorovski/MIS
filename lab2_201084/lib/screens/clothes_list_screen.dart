import 'package:flutter/material.dart';
import 'package:lab2_201084/widgets/new_clothes.dart';

import '../model/clothes.dart';

class ClothesListScreen extends StatefulWidget {
  const ClothesListScreen({super.key});

  @override
  State<ClothesListScreen> createState() => _ClothesListScreenState();
}

class _ClothesListScreenState extends State<ClothesListScreen> {
  final List<Clothes> _clothes = [
    Clothes(
        id: 1, name: "Панталони", description: "Панталони со долги панталони"),
  ];

  void _addClothesFunction() {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            behavior: HitTestBehavior.opaque,
            child: NewClothes(addClothes: _addClothes),
          );
        });
  }

  void _addClothes(Clothes clothes) {
    setState(() {
      _clothes.add(clothes);
    });
  }

  void _editClothes(Clothes clothes) {
    TextEditingController nameController =
        TextEditingController(text: clothes.name);
    TextEditingController descriptionController =
        TextEditingController(text: clothes.description);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Ажурирај'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Име на артиклот',
                  ),
                ),
                TextField(
                  controller: descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Опис на артиклот',
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Назад'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Зачувај'),
              onPressed: () {
                setState(() {
                  clothes.name = nameController.text;
                  clothes.description = descriptionController.text;
                });
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
          title: const Text('Апликација за облека'),
          backgroundColor: Theme.of(context).colorScheme.primary,
          actions: [
            IconButton(
              icon: const Icon(Icons.add_circle_rounded, color: Colors.white),
              onPressed: _addClothesFunction,
            )
          ],
        ),
        body: ListView.builder(
            itemCount: _clothes.length,
            itemBuilder: (context, index) {
              return ListTile(
                  title: Text(_clothes[index].name,
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.red)),
                  subtitle: Text(_clothes[index].description ?? "",
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w100,
                          color: Colors.redAccent)),
                  trailing: FittedBox(
                      fit: BoxFit.fill,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit_rounded),
                            onPressed: () => _editClothes(_clothes[index]),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete_rounded),
                            onPressed: () {
                              setState(() {
                                _clothes.removeAt(index);
                              });
                            },
                          ),
                        ],
                      )));
            }));
  }
}
