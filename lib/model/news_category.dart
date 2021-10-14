import 'dart:convert';

List<NewsCategory> newcategoryFromJson(String str) => List<NewsCategory>.from(
    json.decode(str).map((x) => NewsCategory.fromMap(x)));

class NewsCategory {
  bool isSelected = false;

  NewsCategory({
    required this.id,
    required this.name,
  });

  int id;
  String name;

  factory NewsCategory.fromMap(Map<String, dynamic> json) => NewsCategory(
        id: json["id"],
        name: json["name"],
      );
}
