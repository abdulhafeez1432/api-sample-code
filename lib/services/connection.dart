import 'dart:convert';

import 'package:api_app/model/author.dart';
import 'package:api_app/model/post.dart';
import 'package:api_app/registration.dart';
import 'package:http/http.dart' as http;

Future<PostResponse> getNews() async {
  final response = await http
      .get(Uri.parse('http://api.allnigerianewspapers.com.ng/api/news/'));
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

Future<Registration> createUser(String username) async {
  final response = await http.post(
    Uri.parse('http://api.allnigerianewspapers.com.ng/api/register'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'username': username,
    }),
  );
  print(response.statusCode);

  if (response.statusCode == 201) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return Registration.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create album.');
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
