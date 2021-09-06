import 'dart:convert';

import 'package:api_app/model/category.dart';
import 'package:api_app/model/site.dart';

import 'category.dart';

class PostResponse {
  String nextUrl;
  String prevUrl;
  List<Post> posts;

  PostResponse({
    required this.nextUrl,
    required this.prevUrl,
    required this.posts,
  });

  factory PostResponse.fromJson(dynamic json) {
    print(json);
    return PostResponse(
      posts: (json['results'] as List).map((x) => Post.fromJson(x)).toList(),
      // posts: [],
      nextUrl: json['next'] as String,
      prevUrl: json['previous'] as String,
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
  String author;
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
        title: json["title"] as String,
        content: json["content"] as String,
        imageUrl: json["image_url"] as String,
        url: json["url"] as String,
        category: Category.fromJson(json["category"]),
        //author: json["author"] as String ?? 'Admin',
        author: json["author"] as String,
        site: Site.fromJson(json["site"]),
        uploaded: json["uploaded"] as String,
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
