// To parse this JSON data, do
//
//     final newsCategory = newsCategoryFromMap(jsonString);

import 'dart:convert';

List<NewsByCategory> newsByCategoryFromMap(String str) =>
    List<NewsByCategory>.from(
        json.decode(str).map((x) => NewsByCategory.fromMap(x)));

String newsCategoryToMap(List<NewsByCategory> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class NewsByCategory {
  NewsByCategory({
    required this.id,
    required this.title,
    required this.content,
    required this.imageUrl,
    required this.url,
    required this.category,
    this.author,
    required this.site,
    required this.uploaded,
    required this.comment,
  });

  int id;
  String title;
  String content;
  String imageUrl;
  String url;
  Category category;
  dynamic author;
  Site site;
  String uploaded;
  List<int> comment;

  factory NewsByCategory.fromMap(Map<String, dynamic> json) => NewsByCategory(
        id: json["id"],
        title: json["title"],
        content: json["content"],
        imageUrl: json["image_url"],
        url: json["url"],
        category: Category.fromMap(json["category"]),
        author: json["author"],
        site: Site.fromMap(json["site"]),
        uploaded: json["uploaded"],
        comment: List<int>.from(json["comment"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "content": content,
        "image_url": imageUrl,
        "url": url,
        "category": category.toMap(),
        "author": author,
        "site": site.toMap(),
        "uploaded": uploaded,
        "comment": List<dynamic>.from(comment.map((x) => x)),
      };
}

class Category {
  Category({
    required this.id,
    required this.name,
    required this.updatedAt,
    required this.createdAt,
  });

  int id;
  String name;
  DateTime updatedAt;
  DateTime createdAt;

  factory Category.fromMap(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
      };
}

class Site {
  bool isSelected = false;
  Site({
    required this.name,
    required this.logo,
  });

  String name;
  String logo;

  factory Site.fromMap(Map<String, dynamic> json) => Site(
        name: json["name"],
        logo: json["logo"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "logo": logo,
      };
}
