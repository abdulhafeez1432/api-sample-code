import 'dart:convert';

import 'package:api_app/model/post.dart';
import 'package:http/http.dart' as http;

Future<Post> getNews() async {
  final response = await http
      .get(Uri.parse('http://api.allnigerianewspapers.com.ng/api/news/'));
  var newsModel;
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    newsModel = Post.fromJson(jsonDecode(response.body));
    return newsModel;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load News');
  }
}
