// To parse this JSON data, do
//
//     final newsBySite = newsBySiteFromMap(jsonString);

import 'dart:convert';

NewsBySite newsBySiteFromMap(String str) => NewsBySite.fromMap(json.decode(str));

String newsBySiteToMap(NewsBySite data) => json.encode(data.toMap());

class NewsBySite {
  NewsBySite({
    required this.count,
    required this.next,
    this.previous,
    required this.results,
  });

  int count;
  String next;
  dynamic previous;
  List<Result> results;

  factory NewsBySite.fromMap(Map<String, dynamic> json) => NewsBySite(
    count: json["count"],
    next: json["next"],
    previous: json["previous"],
    results: List<Result>.from(json["results"].map((x) => Result.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "count": count,
    "next": next,
    "previous": previous,
    "results": List<dynamic>.from(results.map((x) => x.toMap())),
  };
}

class Result {
  Result({
    required this.id,
    required this.title,
    required this.content,
    required this.imageUrl,
    required this.url,
    required this.category,
    required this.author,
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
  Uploaded uploaded;
  List<dynamic> comment;

  factory Result.fromMap(Map<String, dynamic> json) => Result(
    id: json["id"],
    title: json["title"],
    content: json["content"],
    imageUrl: json["image_url"],
    url: json["url"],
    category: Category.fromMap(json["category"]),
    author: json["author"],
    site: Site.fromMap(json["site"]),
    uploaded: uploadedValues.map[json["uploaded"]],
    comment: List<dynamic>.from(json["comment"].map((x) => x)),
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
    "uploaded": uploadedValues.reverse[uploaded],
    "comment": List<dynamic>.from(comment.map((x) => x)),
  };
}

class Category {
  Category({
    this.id,
    this.name,
    this.updatedAt,
    this.createdAt,
  });

  int id;
  CategoryName name;
  DateTime updatedAt;
  DateTime createdAt;

  factory Category.fromMap(Map<String, dynamic> json) => Category(
    id: json["id"],
    name: categoryNameValues.map[json["name"]],
    updatedAt: DateTime.parse(json["updated_at"]),
    createdAt: DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": categoryNameValues.reverse[name],
    "updated_at": updatedAt.toIso8601String(),
    "created_at": createdAt.toIso8601String(),
  };
}

enum CategoryName { SPORT }

final categoryNameValues = EnumValues({
  "sport": CategoryName.SPORT
});

class Site {
  Site({
    this.name,
    this.logo,
  });

  SiteName name;
  String logo;

  factory Site.fromMap(Map<String, dynamic> json) => Site(
    name: siteNameValues.map[json["name"]],
    logo: json["logo"],
  );

  Map<String, dynamic> toMap() => {
    "name": siteNameValues.reverse[name],
    "logo": logo,
  };
}

enum SiteName { PUNCH }

final siteNameValues = EnumValues({
  "punch": SiteName.PUNCH
});

enum Uploaded { EMPTY, THE_14_OCTOBER_2021 }

final uploadedValues = EnumValues({
  "": Uploaded.EMPTY,
  "14 October 2021": Uploaded.THE_14_OCTOBER_2021
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
