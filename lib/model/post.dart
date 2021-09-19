import 'dart:convert';

import 'package:api_app/model/category.dart';
import 'package:api_app/model/site.dart';

import 'category.dart';

class PostResponse {
  String? nextUrl;
  String? prevUrl;
  List<Post> posts;

  PostResponse({
    required this.nextUrl,
    required this.prevUrl,
    required this.posts,
  });

  factory PostResponse.fromJson(dynamic json) {
    // print(json);

    List<Post> posts = [];
    if (json['results'] != null) {
      posts = (json['results'] as List).map((x) => Post.fromJson(x)).toList();
    }

    return PostResponse(
      posts: posts,
      nextUrl: json['next'],
      prevUrl: json['previous'],
    );
  }

  String postToJson(List<Post> data) {
    final dyn = List<dynamic>.from(data.map((x) => x.toJson()));
    return json.encode(dyn);
  }
}

class Post {
  String title;
  String content;
  String imageUrl;
  String url;
  Category category;
  String? author;
  Site site;
  String uploaded;

  Post({
    required this.title,
    required this.content,
    required this.imageUrl,
    required this.url,
    required this.category,
    required this.author,
    required this.site,
    required this.uploaded,
  });

  factory Post.fromJson(dynamic json) => Post(
        title: json["title"],
        content: json["content"],
        imageUrl: json["image_url"],
        url: json["url"],
        category: Category.fromJson(json["category"]),
        author: json["author"] ?? 'Admin',
        site: Site.fromJson(json["site"]),
        uploaded: json["uploaded"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "content": content,
        "image_url": imageUrl,
        "url": url,
        "category": category.toJson(),
        "author": author,
        "site": site.toJson(),
        "uploaded": uploaded,
      };
}
