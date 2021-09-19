import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:api_app/model/user.dart';

const BASE_URL = 'http://api.allnigerianewspapers.com.ng/api';

class AuthService {
  Future<String> login({
    required String username,
    required String password,
  }) async {
    try {
      final body = {
        'username': username,
        'password': password,
      };

      final response = await http.post(
        Uri.parse('$BASE_URL/login/'),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode(body),
      );

      if (response.statusCode != 200) {
        throw LoginError.unexpected;
      }

      return jsonDecode(response.body)['token'];
    } on LoginError {
      rethrow;
    } catch (e) {
      throw LoginError.unexpected;
    }
  }

  Future<User> register(User user) async {
    try {
      final response = await http.post(
        Uri.parse('$BASE_URL/register/'),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode(user.toJson()),
      );

      if (response.statusCode != 200) {
        throw RegisterError.unexpected;
      }

      Map<String, dynamic> data = jsonDecode(response.body);
      String token = data['token'];
      User newUser = User.fromJson(data['user']);

      return newUser;
    } on RegisterError {
      rethrow;
    } catch (e) {
      throw RegisterError.unexpected;
    }
  }
}

enum LoginError { unexpected }
enum RegisterError { unexpected }
