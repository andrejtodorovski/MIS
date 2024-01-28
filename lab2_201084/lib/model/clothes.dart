class Clothes {
  int id;
  String name;
  String? description;

  Clothes({required this.id, required this.name, this.description});

  Clothes copyWith({
    int? id,
    String? name,
    String? description,
  }) {
    return Clothes(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
    );
  }
}
