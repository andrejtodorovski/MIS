import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lab2_201084/model/clothes.dart';

class NewClothes extends StatefulWidget {
  final Function addClothes;

  const NewClothes({Key? key, required this.addClothes}) : super(key: key);

  @override
  State<NewClothes> createState() => _NewClothesState();
}

class _NewClothesState extends State<NewClothes> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  String _title = "";
  String _description = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(children: [
        const Text("Додај нов артикл",
            style: TextStyle(fontSize: 20, color: Colors.lightBlueAccent)),
        TextField(
          controller: _titleController,
          decoration: const InputDecoration(
            labelText: "Име на артиклот",
            hintText: "Внесете име на артиклот",
          ),
          onSubmitted: (_) => _submitData,
        ),
        TextField(
          controller: _descriptionController,
          decoration: const InputDecoration(
            labelText: "Опис",
            hintText: "Внесете опис на артиклот",
          ),
          onSubmitted: (_) => _submitData,
        ),
        ElevatedButton(
            onPressed: _submitData,
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.redAccent,
              backgroundColor: Colors.lightGreenAccent,
              shadowColor: Colors.red,
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

  void _submitData() {
    if (_titleController.text.isEmpty) {
      return;
    }
    _title = _titleController.text;
    if (_descriptionController.text.isEmpty) {
      return;
    }
    _description = _descriptionController.text;
    if (_title.isEmpty || _description.isEmpty) {
      return;
    }
    final newClothes = Clothes(
      id: Random().nextInt(1000),
      name: _title,
      description: _description,
    );
    widget.addClothes(newClothes);
    Navigator.of(context).pop();
  }
}
