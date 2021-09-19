class Author {
  int? id;
  String? name;
  String? address;

  Author({required this.id, required this.name, required this.address});

  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(id: json['id'], name: json['name'], address: json['address']);
  }
}
