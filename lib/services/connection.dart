import 'dart:convert';

import 'package:api_app/model/author.dart';
import 'package:api_app/model/news_bycategory.dart';
import 'package:api_app/model/news_category.dart';
import 'package:api_app/model/post.dart';
import 'package:http/http.dart' as http;

Future<PostResponse> getNews(String? page) async {
  final response = await http.get(
      Uri.parse(page ?? 'http://api.allnigerianewspapers.com.ng/api/news/'));
  var newsModel;
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    newsModel = PostResponse.fromJson(jsonDecode(response.body));
    return newsModel;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load News');
  }
}

Future<List<NewsByCategory>> getNewsByCategory(String category) async {
  final response = await http.get(Uri.parse(
    'http://api.allnigerianewspapers.com.ng/api/allnewsbycategory/$category',
  ));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    List data = jsonDecode(response.body);
    return data.map((e) => NewsByCategory.fromMap(e)).toList();
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load News');
  }
}

Future<List<NewsCategory>> fetchCategory() async {
  final response = await http
      .get(Uri.parse('https://api.allnigerianewspapers.com.ng/api/category/'));

  if (response.statusCode == 200) {
    final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

    return parsed
        .map<NewsCategory>((json) => NewsCategory.fromMap(json))
        .toList();
  } else {
    throw Exception('Failed to load album');
  }
}

Future<Author> createAuthor(String name, String address) async {
  final response = await http.post(
    Uri.parse('http://api.allnigerianewspapers.com.ng/api/addauthor/'),
    headers: <String, String>{
      'Content-Type': 'application/json;charset=UTF-8',
    },
    body: jsonEncode(<String, String>{"name": name, "address": address}),
  );
  if (response.statusCode == 201) {
    //print(response.body);
    //return Author.fromJson(json.decode(response.body));
    return Author.fromJson(jsonDecode(response.body));
  } else {
    ///print('Error');
    throw Exception("Can't load author");
  }
}
